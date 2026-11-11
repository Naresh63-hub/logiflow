import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/sync/sync_engine.dart';
import '../../auth/presentation/auth_provider.dart';
import '../../delivery/domain/pod_model.dart';
import '../data/shipment_repository.dart';
import '../domain/shipment_model.dart';

final shipmentRepositoryProvider = Provider<ShipmentRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final syncEngine = ref.watch(syncEngineProvider.notifier);
  final repo = ShipmentRepository(db, syncEngine);
  repo.seedIfEmpty();
  return repo;
});

final shipmentSearchQueryProvider = StateProvider<String>((ref) => '');

final shipmentStatusFilterProvider = StateProvider<ShipmentStatus?>((ref) => null);

final shipmentsStreamProvider = StreamProvider<List<ShipmentModel>>((ref) {
  final repository = ref.watch(shipmentRepositoryProvider);
  final user = ref.watch(currentUserProvider);
  final searchQuery = ref.watch(shipmentSearchQueryProvider);
  final statusFilter = ref.watch(shipmentStatusFilterProvider);

  return repository.watchShipments(
    searchQuery: searchQuery,
    statusFilter: statusFilter,
    userId: user?.id,
    isHubManager: user?.isHubManager ?? false,
  );
});

final shipmentDetailProvider = FutureProvider.family<ShipmentModel?, String>((ref, id) {
  final repo = ref.watch(shipmentRepositoryProvider);
  return repo.getShipmentById(id);
});

final shipmentEventsProvider = FutureProvider.family<List<ShipmentEventModel>, String>((ref, shipmentId) {
  final repo = ref.watch(shipmentRepositoryProvider);
  return repo.getEventsForShipment(shipmentId);
});

final shipmentPODProvider = FutureProvider.family<ProofOfDeliveryModel?, String>((ref, shipmentId) {
  final repo = ref.watch(shipmentRepositoryProvider);
  return repo.getPODForShipment(shipmentId);
});

class DashboardMetrics {
  final int total;
  final int inTransit;
  final int delivered;
  final int pending;
  final int delayed;
  final List<ShipmentModel> recentShipments;
  final Map<ShipmentStatus, int> distribution;

  const DashboardMetrics({
    this.total = 0,
    this.inTransit = 0,
    this.delivered = 0,
    this.pending = 0,
    this.delayed = 0,
    this.recentShipments = const [],
    this.distribution = const {},
  });
}

final dashboardMetricsProvider = Provider<DashboardMetrics>((ref) {
  final shipmentsAsync = ref.watch(shipmentsStreamProvider);

  return shipmentsAsync.when(
    data: (shipments) {
      int inTransit = 0;
      int delivered = 0;
      int pending = 0;
      int delayed = 0;
      final Map<ShipmentStatus, int> distribution = {};

      for (final s in shipments) {
        distribution[s.currentStatus] = (distribution[s.currentStatus] ?? 0) + 1;

        if (s.isDelivered) {
          delivered++;
        } else if (s.isInTransit) {
          inTransit++;
        } else if (s.isPending) {
          pending++;
        } else if (s.isDelayed) {
          delayed++;
        }
      }

      final recent = shipments.take(5).toList();

      return DashboardMetrics(
        total: shipments.length,
        inTransit: inTransit,
        delivered: delivered,
        pending: pending,
        delayed: delayed,
        recentShipments: recent,
        distribution: distribution,
      );
    },
    loading: () => const DashboardMetrics(),
    error: (_, __) => const DashboardMetrics(),
  );
});

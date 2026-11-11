import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/loading_skeleton.dart';
import '../../../shared/widgets/offline_banner.dart';
import '../../../shared/widgets/status_badge.dart';
import '../domain/shipment_model.dart';
import 'shipments_provider.dart';

class ShipmentListScreen extends ConsumerWidget {
  const ShipmentListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shipmentsAsync = ref.watch(shipmentsStreamProvider);
    final selectedFilter = ref.watch(shipmentStatusFilterProvider);
    final searchController = TextEditingController(text: ref.watch(shipmentSearchQueryProvider));

    final filters = <ShipmentStatus?>[
      null, // All
      ShipmentStatus.inTransit,
      ShipmentStatus.outForDelivery,
      ShipmentStatus.delivered,
      ShipmentStatus.arrivedAtHub,
      ShipmentStatus.pickupScheduled,
      ShipmentStatus.deliveryFailed,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('navShipments')),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            tooltip: context.tr('scanShipment'),
            onPressed: () => context.push('/scan'),
          ),
        ],
      ),
      body: Column(
        children: [
          const OfflineBanner(),

          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: context.tr('search'),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          ref.read(shipmentSearchQueryProvider.notifier).state = '';
                        },
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onChanged: (val) {
                ref.read(shipmentSearchQueryProvider.notifier).state = val;
              },
            ),
          ),

          // Horizontal Filter Chips
          SizedBox(
            height: 48,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final filter = filters[index];
                final isSelected = selectedFilter == filter;
                final label = filter == null
                    ? context.tr('all')
                    : context.tr(filter.translationKey);

                return FilterChip(
                  label: Text(label),
                  selected: isSelected,
                  onSelected: (_) {
                    ref.read(shipmentStatusFilterProvider.notifier).state = filter;
                  },
                  backgroundColor: Theme.of(context).cardTheme.color,
                  selectedColor: AppColors.accent.withOpacity(0.2),
                  labelStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? AppColors.accent : null,
                  ),
                  side: BorderSide(
                    color: isSelected ? AppColors.accent : AppColors.borderLight,
                  ),
                );
              },
            ),
          ),

          // Shipment Cards List
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(shipmentsStreamProvider);
              },
              child: shipmentsAsync.when(
                data: (shipments) {
                  if (shipments.isEmpty) {
                    return EmptyStateWidget(
                      icon: Icons.search_off,
                      title: 'No shipments found',
                      message: selectedFilter != null || ref.watch(shipmentSearchQueryProvider).isNotEmpty
                          ? 'Try adjusting your filters or search keywords.'
                          : 'No consignments registered yet. Create your first shipment!',
                      buttonText: selectedFilter != null || ref.watch(shipmentSearchQueryProvider).isNotEmpty
                          ? 'Clear Filters'
                          : 'Create Shipment',
                      onButtonPressed: () {
                        if (selectedFilter != null || ref.watch(shipmentSearchQueryProvider).isNotEmpty) {
                          ref.read(shipmentStatusFilterProvider.notifier).state = null;
                          ref.read(shipmentSearchQueryProvider.notifier).state = '';
                        } else {
                          context.push('/create-shipment');
                        }
                      },
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: shipments.length,
                    itemBuilder: (context, index) {
                      final item = shipments[index];
                      return _ShipmentListItemCard(shipment: item);
                    },
                  );
                },
                loading: () => const LoadingSkeletonList(count: 6),
                error: (err, stack) => Center(
                  child: Text('Error loading shipments: $err'),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/create-shipment'),
        backgroundColor: AppColors.accent,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: Text(context.tr('newShipment')),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) context.go('/dashboard');
          if (index == 1) return;
          if (index == 2) context.push('/scan');
          if (index == 3) context.go('/profile');
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.dashboard_outlined),
            activeIcon: const Icon(Icons.dashboard),
            label: context.tr('navDashboard'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.local_shipping_outlined),
            activeIcon: const Icon(Icons.local_shipping),
            label: context.tr('navShipments'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.qr_code_scanner),
            label: context.tr('navScan'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
            label: context.tr('navProfile'),
          ),
        ],
      ),
    );
  }
}

class _ShipmentListItemCard extends StatelessWidget {
  final ShipmentModel shipment;

  const _ShipmentListItemCard({required this.shipment});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy, hh:mm a');

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push('/shipments/${shipment.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Tracking & Status Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        shipment.trackingNumber,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      if (shipment.isDirty) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.warning.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'Offline',
                            style: TextStyle(
                              fontSize: 10,
                              color: AppColors.warning,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  StatusBadge(status: shipment.currentStatus, isCompact: true),
                ],
              ),
              const SizedBox(height: 12),

              // Destination & Category
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 16, color: AppColors.secondary),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'To: ${shipment.receiverName} • ${shipment.receiverAddress}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.inventory_2_outlined, size: 16, color: AppColors.textTertiaryLight),
                  const SizedBox(width: 6),
                  Text(
                    '${shipment.packageCategory} (${shipment.weightKg} kg)',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: shipment.priority.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      shipment.priority.displayName.split(' ').first,
                      style: TextStyle(
                        fontSize: 11,
                        color: shipment.priority.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 20),

              // Bottom ETA & Timestamp
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ETA: ${dateFormat.format(shipment.expectedDelivery)}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textTertiaryLight,
                    ),
                  ),
                  const Row(
                    children: [
                      Text(
                        'Details',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(Icons.chevron_right, size: 16, color: AppColors.secondary),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

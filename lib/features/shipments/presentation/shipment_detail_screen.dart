import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../shared/widgets/status_badge.dart';
import '../../auth/presentation/auth_provider.dart';
import '../domain/shipment_model.dart';
import 'shipments_provider.dart';

class ShipmentDetailScreen extends ConsumerWidget {
  final String shipmentId;

  const ShipmentDetailScreen({super.key, required this.shipmentId});

  String _hubNameForId(String hubId) {
    if (hubId.startsWith('2222')) return 'Greater Noida West Fulfillment Hub';
    if (hubId.startsWith('3333')) return 'Okhla NCR Gateway Hub';
    return 'Noida Sector 62 Central Hub';
  }

  void _showAssignDriverSheet(BuildContext context, WidgetRef ref, ShipmentModel shipment) {
    final user = ref.read(currentUserProvider);
    final drivers = [
      {'id': 'cccccccc-cccc-cccc-cccc-cccccccccccc', 'name': 'Vikas Singh (Van #14 • Noida Sec 62)'},
      {'id': 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'name': 'Rohan Verma (Bike #07 • Greater Noida)'},
      {'id': 'ffffffff-ffff-ffff-ffff-ffffffffffff', 'name': 'Arjun Chauhan (Van #09 • Okhla NCR)'},
    ];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.tr('assignDriver'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...drivers.map((d) => ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: AppColors.secondary,
                    child: Icon(Icons.delivery_dining, color: Colors.white),
                  ),
                  title: Text(d['name']!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    Navigator.pop(ctx);
                    await ref.read(shipmentRepositoryProvider).assignDeliveryDriver(
                          shipmentId: shipment.id,
                          driverId: d['id']!,
                          driverName: d['name']!,
                          assignedBy: user?.fullName ?? 'Hub Manager',
                          userId: user?.id ?? 'hub_manager',
                        );
                    ref.invalidate(shipmentDetailProvider(shipment.id));
                    ref.invalidate(shipmentEventsProvider(shipment.id));
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Assigned to ${d['name']}'),
                          backgroundColor: AppColors.success,
                        ),
                      );
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }

  void _showStatusUpdateSheet(BuildContext context, WidgetRef ref, ShipmentModel shipment) {
    final user = ref.read(currentUserProvider);
    final validTransitions = [
      ShipmentStatus.arrivedAtHub,
      ShipmentStatus.inTransit,
      ShipmentStatus.outForDelivery,
      ShipmentStatus.deliveryFailed,
      ShipmentStatus.returned,
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Update Shipment Status',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Current Status: ${shipment.currentStatus.displayName}',
                style: const TextStyle(color: AppColors.textSecondaryLight),
              ),
              const SizedBox(height: 16),
              ...validTransitions.map((status) {
                return ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: status.color.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(status.icon, color: status.color, size: 20),
                  ),
                  title: Text(status.displayName, style: const TextStyle(fontWeight: FontWeight.w600)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    Navigator.pop(ctx);
                    await ref.read(shipmentRepositoryProvider).updateShipmentStatus(
                          shipmentId: shipment.id,
                          newStatus: status,
                          locationName: 'Noida Sector 62 Hub Station',
                          remarks: 'Status updated by Hub Manager ${user?.fullName ?? ""}',
                          updatedBy: user?.fullName ?? 'Hub Staff',
                          userId: user?.id ?? 'hub_manager',
                        );
                    ref.invalidate(shipmentDetailProvider(shipment.id));
                    ref.invalidate(shipmentEventsProvider(shipment.id));
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Shipment status updated to ${status.displayName}'),
                          backgroundColor: AppColors.success,
                        ),
                      );
                    }
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shipmentAsync = ref.watch(shipmentDetailProvider(shipmentId));
    final eventsAsync = ref.watch(shipmentEventsProvider(shipmentId));
    final podAsync = ref.watch(shipmentPODProvider(shipmentId));
    final user = ref.watch(currentUserProvider);
    final isHubManager = user?.isHubManager ?? false;
    final dateFormat = DateFormat('dd MMM yyyy, hh:mm a');

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('shipmentDetails')),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(shipmentDetailProvider(shipmentId));
              ref.invalidate(shipmentEventsProvider(shipmentId));
              ref.invalidate(shipmentPODProvider(shipmentId));
            },
          ),
        ],
      ),
      body: shipmentAsync.when(
        data: (shipment) {
          if (shipment == null) {
            return const Center(child: Text('Shipment record not found'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header Card
                Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Tracking Identifier',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textSecondaryLight,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    Text(
                                      shipment.trackingNumber,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.copy, size: 16),
                                      tooltip: 'Copy Tracking ID',
                                      onPressed: () {
                                        Clipboard.setData(ClipboardData(text: shipment.trackingNumber));
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Tracking ID copied to clipboard')),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            StatusBadge(status: shipment.currentStatus),
                          ],
                        ),
                        const Divider(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: _DetailColumn(
                                label: 'Category',
                                value: shipment.packageCategory,
                              ),
                            ),
                            Expanded(
                              child: _DetailColumn(
                                label: 'Weight',
                                value: '${shipment.weightKg} kg',
                              ),
                            ),
                            Expanded(
                              child: _DetailColumn(
                                label: 'Priority',
                                value: shipment.priority.displayName.split(' ').first,
                                valueColor: shipment.priority.color,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Sender & Receiver Section
                Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _PartyRow(
                          icon: Icons.upload,
                          iconColor: AppColors.secondary,
                          partyType: 'SENDER (PICKUP)',
                          name: shipment.senderName,
                          phone: shipment.senderPhone,
                          address: shipment.senderAddress,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Divider(),
                        ),
                        _PartyRow(
                          icon: Icons.download,
                          iconColor: AppColors.accent,
                          partyType: 'RECEIVER (DELIVERY DESTINATION)',
                          name: shipment.receiverName,
                          phone: shipment.receiverPhone,
                          address: shipment.receiverAddress,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Proof of Delivery Section (if delivered)
                podAsync.when(
                  data: (pod) {
                    if (pod != null) {
                      return Card(
                        margin: EdgeInsets.zero,
                        color: AppColors.successSubtle.withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(color: AppColors.success, width: 1.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.verified, color: AppColors.success, size: 22),
                                  SizedBox(width: 8),
                                  Text(
                                    'Proof of Delivery Verified',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: AppColors.success,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text('Received By: ${pod.receiverName}',
                                  style: const TextStyle(fontWeight: FontWeight.w600)),
                              Text('Delivered: ${dateFormat.format(pod.deliveryTimestamp)}',
                                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondaryLight)),
                              Text('GPS Coordinates: ${pod.deliveryLatitude.toStringAsFixed(4)}, ${pod.deliveryLongitude.toStringAsFixed(4)}',
                                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondaryLight)),
                              if (pod.notes != null) ...[
                                const SizedBox(height: 4),
                                Text('Remarks: ${pod.notes}',
                                    style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
                              ],
                              const SizedBox(height: 12),
                              if (pod.signaturePath != null || pod.photoPath != null)
                                Row(
                                  children: [
                                    if (pod.photoPath != null)
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text('Delivery Photo', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                                            const SizedBox(height: 4),
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: Image.network(
                                                pod.photoPath!,
                                                height: 90,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                                errorBuilder: (_, __, ___) => Container(
                                                  height: 90,
                                                  color: Colors.grey.shade200,
                                                  child: const Center(child: Icon(Icons.broken_image)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (pod.signaturePath != null) ...[
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text('Digital Signature', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                                            const SizedBox(height: 4),
                                            Container(
                                              height: 90,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(color: Colors.grey.shade300),
                                              ),
                                              child: Center(
                                                child: pod.signaturePath!.startsWith('http')
                                                    ? Image.network(
                                                        pod.signaturePath!,
                                                        fit: BoxFit.contain,
                                                        errorBuilder: (_, __, ___) => const Icon(Icons.draw),
                                                      )
                                                    : const Icon(Icons.draw, size: 36, color: AppColors.secondary),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                            ],
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
                const SizedBox(height: 16),

                // Tracking Timeline Section
                Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.tr('timeline'),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        eventsAsync.when(
                          data: (events) {
                            if (events.isEmpty) {
                              return const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text('No timeline milestones logged yet.'),
                              );
                            }

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: events.length,
                              itemBuilder: (context, index) {
                                final event = events[index];
                                final isFirst = index == 0;
                                final isLast = index == events.length - 1;

                                return _TimelineItem(
                                  event: event,
                                  isFirst: isFirst,
                                  isLast: isLast,
                                );
                              },
                            );
                          },
                          loading: () => const Center(child: CircularProgressIndicator()),
                          error: (err, _) => Text('Error loading events: $err'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Hub Corridor & Route Overview (Functional Map Fallback)
                Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.route_outlined, color: AppColors.secondary, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              context.tr('routeOverview'),
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.borderLight),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.trip_origin, size: 16, color: AppColors.secondary),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Origin: ${_hubNameForId(shipment.originHubId)}',
                                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 7.0, top: 4, bottom: 4),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(height: 14, child: VerticalDivider(thickness: 2)),
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.flag, size: 16, color: AppColors.accent),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Destination: ${_hubNameForId(shipment.destinationHubId)}',
                                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(height: 18),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'ETA: ${dateFormat.format(shipment.expectedDelivery)}',
                                    style: const TextStyle(fontSize: 11, color: AppColors.textSecondaryLight),
                                  ),
                                  Text(
                                    shipment.assignedDriverId != null
                                        ? 'Courier Assigned'
                                        : 'Awaiting Driver',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: shipment.assignedDriverId != null
                                          ? AppColors.success
                                          : AppColors.warning,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Action Buttons for Hub Manager or Driver
                if (shipment.currentStatus != ShipmentStatus.delivered) ...[
                  if (isHubManager) ...[
                    OutlinedButton.icon(
                      onPressed: () => _showAssignDriverSheet(context, ref, shipment),
                      icon: const Icon(Icons.person_add_alt_1_outlined),
                      label: Text(context.tr('assignDriver')),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () => _showStatusUpdateSheet(context, ref, shipment),
                      icon: const Icon(Icons.edit_note),
                      label: Text(context.tr('updateStatus')),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  ElevatedButton.icon(
                    onPressed: () => context.push('/delivery/${shipment.id}'),
                    icon: const Icon(Icons.fact_check_outlined),
                    label: Text(context.tr('recordPOD')),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                    ),
                  ),
                ],
                const SizedBox(height: 32),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _DetailColumn extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _DetailColumn({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.textSecondaryLight,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}

class _PartyRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String partyType;
  final String name;
  final String phone;
  final String address;

  const _PartyRow({
    required this.icon,
    required this.iconColor,
    required this.partyType,
    required this.name,
    required this.phone,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                partyType,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: AppColors.textTertiaryLight,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Text(
                phone,
                style: const TextStyle(fontSize: 12, color: AppColors.secondary),
              ),
              const SizedBox(height: 2),
              Text(
                address,
                style: const TextStyle(fontSize: 12, color: AppColors.textSecondaryLight),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final ShipmentEventModel event;
  final bool isFirst;
  final bool isLast;

  const _TimelineItem({
    required this.event,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM, hh:mm a');

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          SizedBox(
            width: 32,
            child: Column(
              children: [
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: isFirst ? AppColors.accent : AppColors.primaryLight,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: AppColors.borderLight,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        event.newStatus.displayName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: isFirst ? AppColors.accent : null,
                        ),
                      ),
                      Text(
                        dateFormat.format(event.createdAt),
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textTertiaryLight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    event.locationName,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                  if (event.remarks != null && event.remarks!.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      event.remarks!,
                      style: const TextStyle(
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                        color: AppColors.textTertiaryLight,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

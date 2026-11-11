import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/app_localizations.dart';
import '../../auth/presentation/auth_provider.dart';
import '../domain/shipment_model.dart';
import 'shipments_provider.dart';

class CreateShipmentScreen extends ConsumerStatefulWidget {
  const CreateShipmentScreen({super.key});

  @override
  ConsumerState<CreateShipmentScreen> createState() => _CreateShipmentScreenState();
}

class _CreateShipmentScreenState extends ConsumerState<CreateShipmentScreen> {
  final _formKey = GlobalKey<FormState>();

  final _senderNameController = TextEditingController();
  final _senderPhoneController = TextEditingController();
  final _senderAddressController = TextEditingController();
  final _receiverNameController = TextEditingController();
  final _receiverPhoneController = TextEditingController();
  final _receiverAddressController = TextEditingController();
  final _weightController = TextEditingController(text: '1.5');
  final _descriptionController = TextEditingController();

  String _category = 'Electronics / IT Hardware';
  PriorityLevel _priority = PriorityLevel.express;
  bool _isSubmitting = false;

  final _categories = [
    'Electronics / IT Hardware',
    'Healthcare & Diagnostics',
    'Apparel & Textiles',
    'Industrial Hardware',
    'Automotive Spare Parts',
    'Documents & Legal Briefs',
  ];

  @override
  void initState() {
    super.initState();
    final user = ref.read(currentUserProvider);
    if (user != null) {
      _senderNameController.text = user.fullName;
      _senderPhoneController.text = user.phone;
      _senderAddressController.text = 'Tower 4, ATS One Hamlet, Sector 104, Noida, UP';
    }
  }

  @override
  void dispose() {
    _senderNameController.dispose();
    _senderPhoneController.dispose();
    _senderAddressController.dispose();
    _receiverNameController.dispose();
    _receiverPhoneController.dispose();
    _receiverAddressController.dispose();
    _weightController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitShipment() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final user = ref.read(currentUserProvider);
      final repo = ref.read(shipmentRepositoryProvider);

      final weight = double.tryParse(_weightController.text.trim()) ?? 1.0;

      final created = await repo.createShipment(
        senderId: user?.id ?? 'guest-shipper',
        senderName: _senderNameController.text.trim(),
        senderPhone: _senderPhoneController.text.trim(),
        senderAddress: _senderAddressController.text.trim(),
        receiverName: _receiverNameController.text.trim(),
        receiverPhone: _receiverPhoneController.text.trim(),
        receiverAddress: _receiverAddressController.text.trim(),
        packageCategory: _category,
        weightKg: weight,
        priority: _priority,
      );

      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
            title: Row(
              children: [
                const Icon(Icons.check_circle, color: AppColors.success, size: 28),
                const SizedBox(width: 8),
                Text(context.tr('shipmentCreatedSuccess')),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Consignment generated: ${created.trackingNumber}'),
                const SizedBox(height: 8),
                const Text(
                  'Saved locally to offline database and queued for automatic synchronization.',
                  style: TextStyle(fontSize: 13, color: AppColors.textSecondaryLight),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  context.go('/shipments/${created.id}');
                },
                child: const Text('View Shipment Details'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create shipment: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('createShipmentTitle')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Sender Information Card
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.person, color: AppColors.secondary, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            context.tr('senderDetails'),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: _senderNameController,
                        decoration: InputDecoration(
                          labelText: context.tr('senderName'),
                          prefixIcon: const Icon(Icons.badge_outlined),
                        ),
                        validator: (v) => v == null || v.trim().isEmpty ? 'Please enter sender name' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _senderPhoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Sender Contact Phone',
                          prefixIcon: Icon(Icons.phone_outlined),
                        ),
                        validator: (v) => v == null || v.trim().isEmpty ? 'Please enter contact phone' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _senderAddressController,
                        maxLines: 2,
                        decoration: InputDecoration(
                          labelText: context.tr('pickupAddress'),
                          prefixIcon: const Icon(Icons.location_on_outlined),
                        ),
                        validator: (v) => v == null || v.trim().isEmpty ? 'Please enter pickup location' : null,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Receiver Information Card
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.local_shipping, color: AppColors.accent, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            context.tr('receiverDetails'),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: _receiverNameController,
                        decoration: InputDecoration(
                          labelText: context.tr('receiverName'),
                          prefixIcon: const Icon(Icons.person_pin_outlined),
                        ),
                        validator: (v) => v == null || v.trim().isEmpty ? 'Please enter receiver name' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _receiverPhoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: context.tr('receiverPhone'),
                          prefixIcon: const Icon(Icons.phone_android_outlined),
                        ),
                        validator: (v) => v == null || v.trim().isEmpty ? 'Please enter receiver phone' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _receiverAddressController,
                        maxLines: 2,
                        decoration: InputDecoration(
                          labelText: context.tr('deliveryAddress'),
                          prefixIcon: const Icon(Icons.home_outlined),
                        ),
                        validator: (v) => v == null || v.trim().isEmpty ? 'Please enter delivery destination' : null,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Package Specifications Card
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.inventory_2, color: AppColors.primaryLight, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Package Specifications',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Category Dropdown
                      DropdownButtonFormField<String>(
                        value: _category,
                        decoration: InputDecoration(
                          labelText: context.tr('packageCategory'),
                          prefixIcon: const Icon(Icons.category_outlined),
                        ),
                        items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _category = val);
                        },
                      ),
                      const SizedBox(height: 12),

                      // Weight Field
                      TextFormField(
                        controller: _weightController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          labelText: context.tr('packageWeight'),
                          prefixIcon: const Icon(Icons.scale_outlined),
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Enter package weight';
                          final n = double.tryParse(v);
                          if (n == null || n <= 0) return 'Weight must be > 0 kg';
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),

                      // Description
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 2,
                        decoration: InputDecoration(
                          labelText: context.tr('description'),
                          prefixIcon: const Icon(Icons.description_outlined),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Priority Selection
                      Text(
                        context.tr('selectPriority'),
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: PriorityLevel.values.map((p) {
                          final isSelected = _priority == p;
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: ChoiceChip(
                                label: Text(
                                  p.displayName.split(' ').first,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    color: isSelected ? Colors.white : null,
                                  ),
                                ),
                                selected: isSelected,
                                selectedColor: p.color,
                                onSelected: (_) => setState(() => _priority = p),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submitShipment,
                child: _isSubmitting
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : Text(context.tr('submit')),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

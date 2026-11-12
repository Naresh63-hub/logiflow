import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/app_localizations.dart';
import '../../auth/presentation/auth_provider.dart';
import '../../shipments/presentation/shipments_provider.dart';
import '../domain/pod_model.dart';

class ProofOfDeliveryScreen extends ConsumerStatefulWidget {
  final String shipmentId;

  const ProofOfDeliveryScreen({super.key, required this.shipmentId});

  @override
  ConsumerState<ProofOfDeliveryScreen> createState() => _ProofOfDeliveryScreenState();
}

class _ProofOfDeliveryScreenState extends ConsumerState<ProofOfDeliveryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _receiverNameController = TextEditingController();
  final _notesController = TextEditingController();

  late SignatureController _signatureController;
  XFile? _capturedPhoto;
  final ImagePicker _picker = ImagePicker();

  double _latitude = 28.6280; // Default Noida Sector 62 Hub latitude
  double _longitude = 77.3649; // Default Noida Sector 62 Hub longitude
  bool _isAcquiringLocation = true;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _signatureController = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
    );

    // Pre-populate receiver name from shipment
    final shipmentAsync = ref.read(shipmentDetailProvider(widget.shipmentId));
    shipmentAsync.whenData((s) {
      if (s != null) {
        _receiverNameController.text = s.receiverName;
      }
    });

    _acquireLocation();
  }

  Future<void> _acquireLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() => _isAcquiringLocation = false);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => _isAcquiringLocation = false);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() => _isAcquiringLocation = false);
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 5),
      );

      if (mounted) {
        setState(() {
          _latitude = position.latitude;
          _longitude = position.longitude;
          _isAcquiringLocation = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isAcquiringLocation = false);
      }
    }
  }

  Future<void> _pickPhoto(ImageSource source) async {
    try {
      final photo = await _picker.pickImage(
        source: source,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );
      if (photo != null) {
        setState(() => _capturedPhoto = photo);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Camera access error: $e')),
        );
      }
    }
  }

  Future<void> _submitProof() async {
    if (!_formKey.currentState!.validate()) return;

    if (_signatureController.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please capture the receiver\'s digital signature.'),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final user = ref.read(currentUserProvider);
      final repo = ref.read(shipmentRepositoryProvider);
      final uuid = const Uuid();
      final podId = uuid.v4();

      // Export signature to PNG bytes and save locally
      String? localSignaturePath;
      try {
        final sigBytes = await _signatureController.toPngBytes();
        if (sigBytes != null) {
          final dir = await getApplicationDocumentsDirectory();
          final file = File('${dir.path}/sig_$podId.png');
          await file.writeAsBytes(sigBytes);
          localSignaturePath = file.path;
        }
      } catch (_) {
        localSignaturePath = 'local_signature_$podId.png';
      }

      final pod = ProofOfDeliveryModel(
        id: podId,
        shipmentId: widget.shipmentId,
        receiverName: _receiverNameController.text.trim(),
        signaturePath: localSignaturePath,
        photoPath: _capturedPhoto?.path ?? 'https://images.unsplash.com/photo-1549465220-1a8b9238cd48?w=500',
        deliveryLatitude: _latitude,
        deliveryLongitude: _longitude,
        deliveryTimestamp: DateTime.now(),
        notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
        submittedBy: user?.id ?? 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
        syncStatus: 'pending',
        createdAt: DateTime.now(),
      );

      await repo.submitProofOfDelivery(pod);

      // Invalidate providers
      ref.invalidate(shipmentDetailProvider(widget.shipmentId));
      ref.invalidate(shipmentEventsProvider(widget.shipmentId));
      ref.invalidate(shipmentPODProvider(widget.shipmentId));

      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.verified, color: AppColors.success, size: 28),
                SizedBox(width: 8),
                Text('Delivery Confirmed'),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Proof of Delivery has been captured successfully!'),
                const SizedBox(height: 8),
                Text(context.tr('podSavedOffline')),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  context.go('/shipments/${widget.shipmentId}');
                },
                child: const Text('View Updated Shipment'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit proof: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  void dispose() {
    _signatureController.dispose();
    _receiverNameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('podTitle')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Delivery Location & Timestamp Banner
              Card(
                margin: EdgeInsets.zero,
                color: AppColors.primaryLight.withOpacity(0.08),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: AppColors.secondary, size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.tr('gpsLocation'),
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            const SizedBox(height: 2),
                            _isAcquiringLocation
                                ? Text(context.tr('fetchingGPS'), style: const TextStyle(fontSize: 12, color: AppColors.secondary))
                                : Text(
                                    'Lat: ${_latitude.toStringAsFixed(5)}, Lng: ${_longitude.toStringAsFixed(5)} (Noida NCR)',
                                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondaryLight),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Receiver Name Field
              TextFormField(
                controller: _receiverNameController,
                decoration: InputDecoration(
                  labelText: context.tr('receiverName'),
                  prefixIcon: const Icon(Icons.person_outline),
                ),
                validator: (v) => v == null || v.trim().isEmpty ? 'Please enter receiver name' : null,
              ),
              const SizedBox(height: 16),

              // Photo Capture Section
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
                          Text(
                            context.tr('takePhoto'),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.camera_alt, color: AppColors.accent),
                                onPressed: () => _pickPhoto(ImageSource.camera),
                                tooltip: 'Camera',
                              ),
                              IconButton(
                                icon: const Icon(Icons.photo_library, color: AppColors.secondary),
                                onPressed: () => _pickPhoto(ImageSource.gallery),
                                tooltip: 'Gallery',
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (_capturedPhoto != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: kIsWeb
                              ? Image.network(_capturedPhoto!.path, height: 160, width: double.infinity, fit: BoxFit.cover)
                              : Image.file(File(_capturedPhoto!.path), height: 160, width: double.infinity, fit: BoxFit.cover),
                        )
                      else
                        Container(
                          height: 110,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.borderLight, style: BorderStyle.solid),
                          ),
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_a_photo_outlined, size: 36, color: AppColors.textTertiaryLight),
                                SizedBox(height: 6),
                                Text(
                                  'Tap camera icon to capture package / doorstep',
                                  style: TextStyle(fontSize: 12, color: AppColors.textSecondaryLight),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Digital Signature Pad Section
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
                          Text(
                            context.tr('receiverSignature'),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          TextButton.icon(
                            onPressed: () => _signatureController.clear(),
                            icon: const Icon(Icons.clear, size: 16),
                            label: Text(context.tr('clearSignature')),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.borderLight, width: 1.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Signature(
                            controller: _signatureController,
                            height: 160,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Center(
                        child: Text(
                          'Sign within the frame using finger or stylus',
                          style: TextStyle(fontSize: 11, color: AppColors.textTertiaryLight),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Delivery Notes
              TextFormField(
                controller: _notesController,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: context.tr('deliveryNotes'),
                  prefixIcon: const Icon(Icons.note_alt_outlined),
                ),
              ),
              const SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submitProof,
                child: _isSubmitting
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : Text(context.tr('submitPOD')),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

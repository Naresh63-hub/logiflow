import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/app_localizations.dart';
import '../../auth/domain/user_model.dart';
import '../../auth/presentation/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  void _showEditProfileDialog(BuildContext context, WidgetRef ref, UserModel user) {
    final nameController = TextEditingController(text: user.fullName);
    final phoneController = TextEditingController(text: user.phone);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile updated successfully'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  void _confirmLogout(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Sign Out'),
        content: const Text('Are you sure you want to log out of your 3PL logistics portal?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () async {
              Navigator.pop(ctx);
              await ref.read(authProvider.notifier).logout();
              if (context.mounted) {
                context.go('/login');
              }
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('profileTitle')),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: user == null
          ? const Center(child: Text('No active profile'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // User Avatar & Name Card
                  Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 46,
                            backgroundColor: AppColors.primaryLight,
                            backgroundImage: user.avatarUrl != null
                                ? NetworkImage(user.avatarUrl!)
                                : null,
                            child: user.avatarUrl == null
                                ? Text(
                                    user.fullName.isNotEmpty ? user.fullName[0].toUpperCase() : 'U',
                                    style: const TextStyle(fontSize: 32, color: Colors.white),
                                  )
                                : null,
                          ),
                          const SizedBox(height: 14),
                          Text(
                            user.fullName,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user.email,
                            style: const TextStyle(fontSize: 14, color: AppColors.textSecondaryLight),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                              color: user.isHubManager
                                  ? AppColors.primaryLight.withOpacity(0.12)
                                  : AppColors.secondary.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: user.isHubManager ? AppColors.primaryLight : AppColors.secondary,
                              ),
                            ),
                            child: Text(
                              user.role.displayName,
                              style: TextStyle(
                                color: user.isHubManager ? AppColors.primaryLight : AppColors.secondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Account Details
                  Card(
                    margin: EdgeInsets.zero,
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.phone_outlined, color: AppColors.secondary),
                          title: const Text('Contact Number'),
                          subtitle: Text(user.phone),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.warehouse_outlined, color: AppColors.accent),
                          title: Text(context.tr('assignedHub')),
                          subtitle: Text(context.tr('hubNoida')),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.edit_outlined, color: AppColors.primaryLight),
                          title: const Text('Edit Account Details'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _showEditProfileDialog(context, ref, user),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Role Switching Simulation (Demo Evaluation Feature)
                  Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.swap_horiz, color: AppColors.accent),
                              SizedBox(width: 8),
                              Text(
                                'Role Perspective Switcher',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Toggle perspective to evaluate both Shipper & Hub Manager workflows.',
                            style: TextStyle(fontSize: 12, color: AppColors.textSecondaryLight),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: user.isShipper ? AppColors.secondary.withOpacity(0.1) : null,
                                  ),
                                  onPressed: () {
                                    ref.read(authProvider.notifier).switchDemoUser(UserRole.shipper);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Switched to Shipper perspective')),
                                    );
                                  },
                                  child: const Text('Shipper View'),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: user.isHubManager ? AppColors.primaryLight.withOpacity(0.1) : null,
                                  ),
                                  onPressed: () {
                                    ref.read(authProvider.notifier).switchDemoUser(UserRole.hubManager);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Switched to Hub Manager perspective')),
                                    );
                                  },
                                  child: const Text('Manager View'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Logout Button
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error),
                    ),
                    onPressed: () => _confirmLogout(context, ref),
                    icon: const Icon(Icons.logout),
                    label: Text(context.tr('logout')),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        onTap: (index) {
          if (index == 0) context.go('/dashboard');
          if (index == 1) context.go('/shipments');
          if (index == 2) context.push('/scan');
          if (index == 3) return;
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

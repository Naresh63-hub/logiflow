import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/network/supabase_config.dart';
import '../../../shared/widgets/app_logo.dart';
import '../data/auth_repository.dart';
import '../domain/user_model.dart';
import 'auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _obscurePassword = true;
  bool _isSignUpMode = false;
  UserRole _selectedRole = UserRole.shipper;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _fillDemoCredentials({required bool isShipper}) {
    if (isShipper) {
      _emailController.text = AuthRepository.demoShipper.email;
      _passwordController.text = 'DemoShipper2026!';
    } else {
      _emailController.text = AuthRepository.demoHubManager.email;
      _passwordController.text = 'DemoManager2026!';
    }
    setState(() => _isSignUpMode = false);
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_isSignUpMode) {
      final res = await ref.read(authProvider.notifier).signUp(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            fullName: _fullNameController.text.trim(),
            phone: _phoneController.text.trim(),
            role: _selectedRole,
          );
      if (!mounted) return;
      if (res == 'SIGNED_IN') {
        context.go('/dashboard');
      } else if (res == 'CONFIRM_EMAIL') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Verification email sent! Please confirm your email, then log in.'),
            backgroundColor: AppColors.success,
          ),
        );
        setState(() => _isSignUpMode = false);
      } else {
        final err = ref.read(authProvider).errorMessage ?? 'Registration failed.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(err), backgroundColor: AppColors.error),
        );
      }
      return;
    }

    final success = await ref.read(authProvider.notifier).login(
          _emailController.text.trim(),
          _passwordController.text,
        );

    if (success && mounted) {
      context.go('/dashboard');
    } else if (mounted) {
      final err = ref.read(authProvider).errorMessage ?? context.tr('loginFailed');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  void _showBackendConfigDialog() {
    final urlCtrl = TextEditingController(
      text: SupabaseConfig.isRealBackendConfigured ? SupabaseConfig.url : '',
    );
    final keyCtrl = TextEditingController(
      text: SupabaseConfig.isRealBackendConfigured ? SupabaseConfig.anonKey : '',
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Supabase Cloud Backend'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              SupabaseConfig.isRealBackendConfigured
                  ? 'Currently connected to:\n${SupabaseConfig.url}'
                  : 'Currently running in offline-first SQLite evaluation mode.',
              style: const TextStyle(fontSize: 12, color: AppColors.textSecondaryLight),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: urlCtrl,
              decoration: const InputDecoration(
                labelText: 'Supabase Project URL',
                hintText: 'https://xxxx.supabase.co',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: keyCtrl,
              decoration: const InputDecoration(
                labelText: 'Supabase Anon / Publishable Key',
                hintText: 'eyJhbGci...',
              ),
            ),
          ],
        ),
        actions: [
          if (SupabaseConfig.isRealBackendConfigured)
            TextButton(
              onPressed: () async {
                await SupabaseConfig.resetToOfflineDemo();
                if (ctx.mounted) Navigator.pop(ctx);
                if (mounted) setState(() {});
              },
              child: const Text('Use Offline Demo'),
            ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final connected = await SupabaseConfig.saveAndConnect(
                newUrl: urlCtrl.text,
                newAnonKey: keyCtrl.text,
              );
              if (ctx.mounted) Navigator.pop(ctx);
              if (mounted) {
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      connected
                          ? 'Connected to live Supabase project!'
                          : 'Invalid Supabase URL or key.',
                    ),
                    backgroundColor: connected ? AppColors.success : AppColors.warning,
                  ),
                );
              }
            },
            child: const Text('Connect'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLive = SupabaseConfig.isRealBackendConfigured;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: ActionChip(
                    avatar: Icon(
                      isLive ? Icons.cloud_done : Icons.cloud_off,
                      size: 16,
                      color: isLive ? AppColors.success : AppColors.textSecondaryLight,
                    ),
                    label: Text(
                      isLive ? 'Live Cloud' : 'Offline Demo',
                      style: const TextStyle(fontSize: 11),
                    ),
                    onPressed: _showBackendConfigDialog,
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: AppLogo(size: 80, withGlow: true),
                ),
                const SizedBox(height: 20),
                Text(
                  _isSignUpMode ? 'Create Logistics Account' : context.tr('loginTitle'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  context.tr('loginSubtitle'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondaryLight,
                  ),
                ),
                const SizedBox(height: 28),

                if (_isSignUpMode) ...[
                  TextFormField(
                    controller: _fullNameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (v) => _isSignUpMode && (v == null || v.trim().isEmpty)
                        ? 'Please enter your full name'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Contact Phone',
                      prefixIcon: Icon(Icons.phone_outlined),
                    ),
                    validator: (v) => _isSignUpMode && (v == null || v.trim().length < 10)
                        ? 'Please enter valid phone number'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<UserRole>(
                    value: _selectedRole,
                    decoration: const InputDecoration(
                      labelText: 'Account Role',
                      prefixIcon: Icon(Icons.badge_outlined),
                    ),
                    items: const [
                      DropdownMenuItem(value: UserRole.shipper, child: Text('Shipper')),
                      DropdownMenuItem(value: UserRole.hubManager, child: Text('Hub Manager')),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedRole = val);
                    },
                  ),
                  const SizedBox(height: 16),
                ],

                // Email Field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: context.tr('email'),
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return context.tr('invalidEmail');
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return context.tr('invalidEmail');
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password Field
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: context.tr('password'),
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.textSecondaryLight,
                      ),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return context.tr('invalidPassword');
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),

                if (!_isSignUpMode)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () async {
                        final email = _emailController.text.trim();
                        if (email.isEmpty || !email.contains('@')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Enter your email first to reset password.')),
                          );
                          return;
                        }
                        await ref.read(authProvider.notifier).resetPassword(email);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Password reset instructions sent to your email.'),
                            ),
                          );
                        }
                      },
                      child: Text(
                        context.tr('forgotPassword'),
                        style: const TextStyle(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 12),

                // Login / Register Button
                ElevatedButton(
                  onPressed: authState.isLoading ? null : _handleSubmit,
                  child: authState.isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : Text(_isSignUpMode ? 'Create Account' : context.tr('login')),
                ),
                const SizedBox(height: 12),

                TextButton(
                  onPressed: () => setState(() => _isSignUpMode = !_isSignUpMode),
                  child: Text(
                    _isSignUpMode
                        ? 'Already have an account? Log In'
                        : 'New to LogiFlow? Create Account',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 20),

                // Demo Quick Fill Section
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'DEMO EVALUATION LOGINS',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textTertiaryLight,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 16),

                OutlinedButton.icon(
                  onPressed: () => _fillDemoCredentials(isShipper: true),
                  icon: const Icon(Icons.person_outline, size: 20),
                  label: Text(context.tr('demoLoginShipper')),
                ),
                const SizedBox(height: 12),

                OutlinedButton.icon(
                  onPressed: () => _fillDemoCredentials(isShipper: false),
                  icon: const Icon(Icons.warehouse_outlined, size: 20),
                  label: Text(context.tr('demoLoginHubManager')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../shared/widgets/custom_back_button.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../widgets/auth_footer.dart';
import '../widgets/auth_header.dart';
import 'register_screen.dart';
import '../../../../main.dart';

/// Halaman Login (Masuk) — formulir autentikasi pengguna.
///
/// Menampilkan:
/// - Back button oranye di kiri atas
/// - Header: "Selamat Datang" + "Masuk untuk melanjutkan"
/// - 2 input field: No.HP dan Password
/// - Tombol "Masuk" (pill, biru)
/// - Footer: "Belum punya akun? Daftar" → navigasi ke [RegisterScreen]
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Validasi dan proses login.
  void _handleLogin() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simulasi proses login (ganti dengan logika autentikasi sebenarnya)
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isLoading = false);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login berhasil!'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      }
    });
  }

  /// Navigasi ke halaman Register.
  void _navigateToRegister() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.screenHorizontalPadding,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSizes.paddingMD),

                // ─── Back Button ────────────────────────────────
                const CustomBackButton(),

                const SizedBox(height: AppSizes.paddingXXL),

                // ─── Header ─────────────────────────────────────
                const AuthHeader(
                  title: 'Selamat Datang',
                  subtitle: 'Masuk untuk melanjutkan',
                ),

                const SizedBox(height: AppSizes.paddingXL),

                // ─── Input: No. HP ──────────────────────────────
                CustomTextField(
                  hintText: 'No.HP',
                  prefixIcon: Icons.phone_outlined,
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nomor HP wajib diisi';
                    }
                    if (value.trim().length < 10) {
                      return 'Nomor HP minimal 10 digit';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: AppSizes.inputSpacing),

                // ─── Input: Password ────────────────────────────
                CustomTextField(
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outline_rounded,
                  controller: _passwordController,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Password wajib diisi';
                    }
                    if (value.length < 6) {
                      return 'Password minimal 6 karakter';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: AppSizes.formToButtonSpacing),

                // ─── Tombol Masuk ───────────────────────────────
                CustomButton(
                  text: 'Masuk',
                  onPressed: _handleLogin,
                  isLoading: _isLoading,
                ),

                const SizedBox(height: AppSizes.buttonToFooterSpacing),

                // ─── Footer: Link ke Register ───────────────────
                AuthFooter(
                  questionText: 'Belum punya akun? ',
                  actionText: 'Daftar',
                  onActionTap: _navigateToRegister,
                ),

                const SizedBox(height: AppSizes.paddingXL),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

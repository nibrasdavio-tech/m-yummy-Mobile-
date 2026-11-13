import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../shared/widgets/custom_back_button.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../widgets/auth_footer.dart';
import '../widgets/auth_header.dart';
import 'login_screen.dart';

/// Halaman Register (Daftar Akun) — formulir pendaftaran pengguna baru.
///
/// Menampilkan:
/// - Back button oranye di kiri atas
/// - Header: "Daftar Akun" + "Buat akun untuk memulai memesan"
/// - 5 input field: Nama Lengkap, No.HP, Password, Konfirmasi Password, Alamat
/// - Tombol "Daftar" (pill, biru)
/// - Footer: "Sudah punya akun? Masuk" → navigasi ke [LoginScreen]
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _addressController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  /// Validasi dan proses registrasi.
  void _handleRegister() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simulasi proses registrasi (ganti dengan logika pendaftaran sebenarnya)
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isLoading = false);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pendaftaran berhasil!'),
            backgroundColor: Colors.green,
          ),
        );

        // Kembali ke halaman login setelah berhasil
        Navigator.of(context).pop();
      }
    });
  }

  /// Navigasi kembali ke halaman Login.
  void _navigateToLogin() {
    Navigator.of(context).pop();
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

                const SizedBox(height: AppSizes.paddingXL),

                // ─── Header ─────────────────────────────────────
                const AuthHeader(
                  title: 'Daftar Akun',
                  subtitle: 'Buat akun untuk memulai memesan',
                ),

                const SizedBox(height: AppSizes.paddingXL),

                // ─── Input: Nama Lengkap ────────────────────────
                CustomTextField(
                  hintText: 'Nama Lengkap',
                  prefixIcon: Icons.person_outline_rounded,
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama lengkap wajib diisi';
                    }
                    if (value.trim().length < 3) {
                      return 'Nama minimal 3 karakter';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: AppSizes.inputSpacing),

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

                const SizedBox(height: AppSizes.inputSpacing),

                // ─── Input: Konfirmasi Password ─────────────────
                CustomTextField(
                  hintText: 'Konfirmasi Password',
                  prefixIcon: Icons.lock_outline_rounded,
                  controller: _confirmPasswordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Konfirmasi password wajib diisi';
                    }
                    if (value != _passwordController.text) {
                      return 'Password tidak cocok';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: AppSizes.inputSpacing),

                // ─── Input: Alamat Lengkap ──────────────────────
                CustomTextField(
                  hintText: 'Alamat Lengkap',
                  prefixIcon: Icons.location_on_outlined,
                  controller: _addressController,
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Alamat wajib diisi';
                    }
                    if (value.trim().length < 10) {
                      return 'Alamat terlalu pendek';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: AppSizes.formToButtonSpacing),

                // ─── Tombol Daftar ──────────────────────────────
                CustomButton(
                  text: 'Daftar',
                  onPressed: _handleRegister,
                  isLoading: _isLoading,
                ),

                const SizedBox(height: AppSizes.buttonToFooterSpacing),

                // ─── Footer: Link ke Login ──────────────────────
                AuthFooter(
                  questionText: 'Sudah punya akun? ',
                  actionText: 'Masuk',
                  onActionTap: _navigateToLogin,
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

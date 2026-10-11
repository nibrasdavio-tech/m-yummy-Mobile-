import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../auth/presentation/screens/login_screen.dart';
import '../../../auth/presentation/screens/register_screen.dart';

/// Tampilan Awal / Masuk m'Yummy dengan gaya modern.
///
/// Menampilkan:
/// - Hero branding: Maskot koki m'Yummy, logo, dan tagline dalam format visual utuh.
/// - Animasi masuk bertahap (staggered animation) yang halus & responsif.
/// - Action card modern di bagian bawah dengan dua pilihan:
///   1. Tombol utama "Masuk" (Royal Blue pill button dengan icon panah & soft glow)
///   2. Tombol sekunder "Daftar Akun" (Modern outlined pill button)
/// - Transisi halaman mulus (smooth slide transition) ke [LoginScreen] dan [RegisterScreen].
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<Offset> _slideActionAnimation;
  late final Animation<double> _fadeActionAnimation;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // Animasi hero artwork (fade & subtle scale)
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOutCubic),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.94, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutBack),
      ),
    );

    // Animasi tombol aksi meluncur dari bawah
    _slideActionAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _fadeActionAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  /// Navigasi mulus ke halaman Login dengan animasi slide dari kanan.
  void _navigateToLogin() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeOutCubic;

          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }

  /// Navigasi mulus ke halaman Register dengan animasi slide dari kanan.
  void _navigateToRegister() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const RegisterScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeOutCubic;

          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: Stack(
        children: [
          // ─── Layer 1: Visual Gambar Utama (Hero Artwork) ────
          Positioned.fill(
            bottom: screenHeight * 0.22,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Image.asset(
                      AppAssets.welcomeScreen,
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ─── Layer 2: Gradient Fade Transisi ke Bawah ───────
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: screenHeight * 0.38,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.backgroundWhite.withValues(alpha: 0.0),
                    AppColors.backgroundWhite.withValues(alpha: 0.85),
                    AppColors.backgroundWhite,
                    AppColors.backgroundWhite,
                  ],
                  stops: const [0.0, 0.35, 0.7, 1.0],
                ),
              ),
            ),
          ),

          // ─── Layer 3: Kontainer Tombol Aksi Modern ──────────
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              top: false,
              child: SlideTransition(
                position: _slideActionAnimation,
                child: FadeTransition(
                  opacity: _fadeActionAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.screenHorizontalPadding,
                      vertical: 16,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Tombol Utama "Masuk"
                        CustomButton(
                          text: 'Masuk',
                          icon: Icons.arrow_forward_rounded,
                          onPressed: _navigateToLogin,
                        ),

                        const SizedBox(height: 14),

                        // Tombol Sekunder "Daftar Akun"
                        CustomOutlinedButton(
                          text: 'Daftar Akun',
                          onPressed: _navigateToRegister,
                        ),

                        const SizedBox(height: 16),

                        // Tagline mikro / info
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: AppColors.accentOrange,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Pesan makanan harian jadi lebih gampang',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

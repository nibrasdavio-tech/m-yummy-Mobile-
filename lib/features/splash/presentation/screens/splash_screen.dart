import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../auth/presentation/screens/login_screen.dart';

/// Layar Tampilan Awal (Splash Screen) m'Yummy.
///
/// Karakteristik:
/// - Menggunakan gambar referensi secara UTUH memenuhi seluruh layar (full-screen edge-to-edge).
/// - Tanpa elemen teks duplikat dan tanpa CustomPaint dekorasi tambahan.
/// - Berpindah otomatis ke [LoginScreen] setelah 2.5 detik dengan transisi fade halus.
/// - Pengguna juga dapat mengetuk (tap) layar untuk langsung masuk tanpa menunggu.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();

    // Mode immersive / full-screen agar gambar tampil bersih edge-to-edge
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    // Navigasi otomatis setelah 2.5 detik
    _timer = Timer(const Duration(milliseconds: 2500), _navigateToLogin);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// Pindah ke halaman Login dengan transisi fade yang halus
  void _navigateToLogin() {
    if (_hasNavigated || !mounted) return;
    _hasNavigated = true;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: _navigateToLogin,
        behavior: HitTestBehavior.opaque,
        child: SizedBox.expand(
          child: Image.asset(
            AppAssets.welcomeScreen,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}

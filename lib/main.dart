import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/theme/app_theme.dart';
import 'features/splash/presentation/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Mengunci orientasi ke portrait untuk konsistensi layout mobile
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Status bar transparan agar visual layar penuh bersih
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(const MYummyApp());
}

/// Root widget aplikasi m'Yummy.
///
/// Menggunakan [AppTheme.lightTheme] sebagai tema global
/// dan [SplashScreen] sebagai tampilan awal.
class MYummyApp extends StatelessWidget {
  const MYummyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "m'Yummy",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

/// Footer reusable di bawah tombol auth — teks ajakan dengan link navigasi.
///
/// Contoh:
/// - "Belum punya akun? Daftar"  (di halaman Login)
/// - "Sudah punya akun? Masuk"   (di halaman Register)
class AuthFooter extends StatelessWidget {
  const AuthFooter({
    super.key,
    required this.questionText,
    required this.actionText,
    required this.onActionTap,
  });

  /// Teks pertanyaan, misal "Belum punya akun? ".
  final String questionText;

  /// Teks aksi yang berfungsi sebagai link, misal "Daftar".
  final String actionText;

  /// Callback saat teks aksi ditekan.
  final VoidCallback onActionTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
          children: [
            TextSpan(text: questionText),
            TextSpan(
              text: actionText,
              style: const TextStyle(
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primaryBlue,
              ),
              recognizer: TapGestureRecognizer()..onTap = onActionTap,
            ),
          ],
        ),
      ),
    );
  }
}

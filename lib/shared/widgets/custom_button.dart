import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

/// Tombol aksi utama pill (rounded penuh) khas m'Yummy.
///
/// Digunakan untuk tombol utama seperti "Masuk" dan "Daftar".
/// Mendukung:
/// - Loading state dengan spinner putih
/// - Icon opsional di sisi kanan
/// - Efek bayangan halus (elevation / shadow)
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.hasShadow = true,
  });

  /// Label teks pada tombol.
  final String text;

  /// Callback ketika tombol ditekan.
  final VoidCallback? onPressed;

  /// Jika true, menampilkan loading spinner dan menonaktifkan tombol.
  final bool isLoading;

  /// Icon opsional di sisi kanan teks.
  final IconData? icon;

  /// Efek bayangan halus berwarna biru.
  final bool hasShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppSizes.buttonHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusPill),
        boxShadow: hasShadow && !isLoading
            ? [
                BoxShadow(
                  color: AppColors.primaryBlue.withValues(alpha: 0.28),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ]
            : null,
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: AppColors.backgroundWhite,
          disabledBackgroundColor: AppColors.primaryBlue.withValues(alpha: 0.7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusPill),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.backgroundWhite),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.backgroundWhite,
                      letterSpacing: 0.3,
                    ),
                  ),
                  if (icon != null) ...[
                    const SizedBox(width: 8),
                    Icon(
                      icon,
                      size: 20,
                      color: AppColors.backgroundWhite,
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}

/// Tombol sekunder outlined (pill border biru, latar putih/transparan).
///
/// Digunakan pada tampilan awal untuk tombol "Daftar Akun"
/// atau aksi sekunder lainnya dengan gaya modern.
class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  /// Label teks pada tombol.
  final String text;

  /// Callback ketika tombol ditekan.
  final VoidCallback? onPressed;

  /// Icon opsional di sisi kanan teks.
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.buttonHeight,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.backgroundWhite,
          foregroundColor: AppColors.primaryBlue,
          side: const BorderSide(
            color: AppColors.primaryBlue,
            width: 1.8,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusPill),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryBlue,
                letterSpacing: 0.3,
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: 8),
              Icon(
                icon,
                size: 20,
                color: AppColors.primaryBlue,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

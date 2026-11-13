import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

/// Tombol navigasi kembali (back arrow) dengan warna oranye/amber khas m'Yummy.
///
/// Tampil di pojok kiri atas layar Login dan Register sesuai desain referensi.
/// Menggunakan icon arrow_back_ios_new yang lebih modern daripada arrow_back.
class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    this.onPressed,
  });

  /// Callback ketika tombol ditekan. Jika null, default ke Navigator.pop.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () => Navigator.of(context).pop(),
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.accentOrange,
          size: AppSizes.backButtonIconSize,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../core/constants/app_sizes.dart';

/// Header reusable untuk halaman auth (Login & Register).
///
/// Menampilkan judul utama (bold, besar) dan subtitle (abu-abu medium)
/// secara konsisten di kedua layar auth.
class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  /// Judul utama, misal "Selamat Datang" atau "Daftar Akun".
  final String title;

  /// Teks deskripsi di bawah judul.
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.headlineLarge,
        ),
        const SizedBox(height: AppSizes.paddingSM),
        Text(
          subtitle,
          style: textTheme.titleMedium,
        ),
      ],
    );
  }
}

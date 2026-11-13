import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

/// Widget dekoratif latar belakang untuk Splash Screen.
///
/// Menggambar ornamen organik blob (peach/krem) di sudut-sudut layar
/// dan dedaunan/ranting herbal hijau sage menggunakan CustomPainter.
/// Ini memastikan dekorasi selalu tajam di semua resolusi perangkat
/// tanpa bergantung pada aset bitmap.
class SplashDecorations extends StatelessWidget {
  const SplashDecorations({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SplashDecorationPainter(),
      size: Size.infinite,
    );
  }
}

class _SplashDecorationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _drawTopRightBlob(canvas, size);
    _drawBottomLeftBlob(canvas, size);
    _drawTopRightLeaves(canvas, size);
    _drawBottomLeftLeaves(canvas, size);
  }

  /// Blob peach organik di sudut kanan atas.
  void _drawTopRightBlob(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.blobPeach
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width * 0.65, 0)
      ..quadraticBezierTo(
        size.width * 0.85,
        size.height * 0.05,
        size.width,
        size.height * 0.02,
      )
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);

    // Blob tambahan yang lebih besar
    final path2 = Path()
      ..moveTo(size.width * 0.78, 0)
      ..quadraticBezierTo(
        size.width * 1.05,
        size.height * 0.08,
        size.width,
        size.height * 0.18,
      )
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path2, paint);
  }

  /// Blob peach organik di sudut kiri bawah.
  void _drawBottomLeftBlob(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.blobPeach
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height * 0.82)
      ..quadraticBezierTo(
        size.width * 0.05,
        size.height * 0.92,
        0,
        size.height,
      )
      ..lineTo(0, size.height)
      ..close();

    // Blob utama kiri bawah
    final path2 = Path()
      ..moveTo(0, size.height * 0.78)
      ..quadraticBezierTo(
        size.width * 0.15,
        size.height * 0.95,
        size.width * 0.35,
        size.height,
      )
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path2, paint);
  }

  /// Ranting dedaunan di sudut kanan atas.
  void _drawTopRightLeaves(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.leafSage.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..color = AppColors.leafSage.withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;

    // Ranting utama
    final startX = size.width * 0.82;
    final startY = size.height * 0.02;

    // Batang ranting
    final stem = Path()
      ..moveTo(startX, startY + 60)
      ..quadraticBezierTo(startX + 15, startY + 30, startX + 10, startY);
    canvas.drawPath(stem, paint);

    // Daun-daun kecil sepanjang batang
    _drawLeaf(canvas, startX + 3, startY + 10, 8, 4, -0.4, fillPaint);
    _drawLeaf(canvas, startX + 12, startY + 18, 8, 4, 0.5, fillPaint);
    _drawLeaf(canvas, startX + 5, startY + 28, 7, 3.5, -0.3, fillPaint);
    _drawLeaf(canvas, startX + 14, startY + 36, 7, 3.5, 0.4, fillPaint);
    _drawLeaf(canvas, startX + 7, startY + 45, 6, 3, -0.5, fillPaint);
    _drawLeaf(canvas, startX + 13, startY + 52, 6, 3, 0.3, fillPaint);
  }

  /// Ranting dedaunan di sudut kiri bawah.
  void _drawBottomLeftLeaves(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.leafSage.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..color = AppColors.leafSage.withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;

    final startX = size.width * 0.15;
    final startY = size.height * 0.85;

    // Batang ranting
    final stem = Path()
      ..moveTo(startX - 10, startY + 80)
      ..quadraticBezierTo(startX + 5, startY + 40, startX, startY);
    canvas.drawPath(stem, paint);

    // Daun-daun
    _drawLeaf(canvas, startX - 5, startY + 10, 8, 4, -0.4, fillPaint);
    _drawLeaf(canvas, startX + 5, startY + 20, 8, 4, 0.5, fillPaint);
    _drawLeaf(canvas, startX - 3, startY + 32, 7, 3.5, -0.3, fillPaint);
    _drawLeaf(canvas, startX + 7, startY + 42, 7, 3.5, 0.4, fillPaint);
    _drawLeaf(canvas, startX - 2, startY + 55, 6, 3, -0.5, fillPaint);
    _drawLeaf(canvas, startX + 5, startY + 65, 6, 3, 0.3, fillPaint);
  }

  /// Menggambar satu daun oval pada posisi tertentu.
  void _drawLeaf(
    Canvas canvas,
    double x,
    double y,
    double length,
    double width,
    double angle,
    Paint paint,
  ) {
    canvas.save();
    canvas.translate(x, y);
    canvas.rotate(angle);

    final leafPath = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(width, -length * 0.4, 0, -length)
      ..quadraticBezierTo(-width, -length * 0.4, 0, 0)
      ..close();

    canvas.drawPath(leafPath, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

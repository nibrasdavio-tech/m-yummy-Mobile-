import 'package:flutter/material.dart';

import '../../data/models/chat_message.dart';

/// Custom Painter untuk menggambar balon chat dengan ekor lancip di sudut atas
/// (sudut kanan-atas untuk pengirim, sudut kiri-atas untuk penerima)
/// persis seperti pada referensi desain.
class BubblePainter extends CustomPainter {
  final Color color;
  final bool isSender;

  const BubblePainter({
    required this.color,
    required this.isSender,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final path = Path();
    const double radius = 16.0;
    const double tailW = 9.0;
    const double tailH = 10.0;

    final w = size.width;
    final h = size.height;

    if (isSender) {
      // ─── Bubble Pengirim (Kanan, ekor di kanan-atas) ───
      // Mulai dari lengkungan kiri-atas
      path.moveTo(radius, tailH);

      // Garis atas lurus ke kanan
      path.lineTo(w - tailW - 4, tailH);

      // Ekor naik dan mengarah ke kanan-atas
      path.lineTo(w, 0);

      // Turun miring ke sisi kanan balon
      path.lineTo(w - tailW, tailH + 12);

      // Sisi kanan turun ke lengkungan bawah-kanan
      path.lineTo(w - tailW, h - radius);

      // Lengkungan sudut kanan-bawah
      path.arcToPoint(
        Offset(w - tailW - radius, h),
        radius: const Radius.circular(radius),
      );

      // Garis bawah lurus ke kiri
      path.lineTo(radius, h);

      // Lengkungan sudut kiri-bawah
      path.arcToPoint(
        Offset(0, h - radius),
        radius: const Radius.circular(radius),
      );

      // Sisi kiri naik ke lengkungan kiri-atas
      path.lineTo(0, tailH + radius);

      // Lengkungan sudut kiri-atas
      path.arcToPoint(
        Offset(radius, tailH),
        radius: const Radius.circular(radius),
      );
    } else {
      // ─── Bubble Penerima / Admin (Kiri, ekor di kiri-atas) ───
      // Mulai setelah ekor kiri-atas
      path.moveTo(tailW + 4, tailH);

      // Garis atas lurus ke kanan
      path.lineTo(w - radius, tailH);

      // Lengkungan sudut kanan-atas
      path.arcToPoint(
        Offset(w, tailH + radius),
        radius: const Radius.circular(radius),
      );

      // Sisi kanan turun ke lengkungan bawah-kanan
      path.lineTo(w, h - radius);

      // Lengkungan sudut kanan-bawah
      path.arcToPoint(
        Offset(w - radius, h),
        radius: const Radius.circular(radius),
      );

      // Garis bawah lurus ke kiri
      path.lineTo(tailW + radius, h);

      // Lengkungan sudut kiri-bawah
      path.arcToPoint(
        Offset(tailW, h - radius),
        radius: const Radius.circular(radius),
      );

      // Sisi kiri naik ke pangkal ekor
      path.lineTo(tailW, tailH + 12);

      // Ekor naik dan mengarah ke kiri-atas
      path.lineTo(0, 0);

      // Turun miring ke garis atas
      path.lineTo(tailW + 4, tailH);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant BubblePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.isSender != isSender;
  }
}

/// Widget Balon Chat yang menampilkan pesan teks, jam, dan status baca (centang dua biru).
class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isSender = message.isSender;
    // Warna bubble: biru lavender lembut untuk user, abu-abu lembut untuk admin
    final bubbleColor = isSender
        ? const Color(0xFF98ACF8)
        : const Color(0xFFE5E7EB);

    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 7.0),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.74,
        ),
        child: CustomPaint(
          painter: BubblePainter(
            color: bubbleColor,
            isSender: isSender,
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              isSender ? 14.0 : 22.0,
              18.0,
              isSender ? 22.0 : 14.0,
              10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Isi pesan
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    message.text,
                    style: const TextStyle(
                      color: Color(0xFF1E293B),
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      height: 1.35,
                    ),
                  ),
                ),
                const SizedBox(height: 5),

                // Baris waktu & centang (jika pengirim)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      message.time,
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                        color: isSender
                            ? const Color(0xFF475569)
                            : const Color(0xFF64748B),
                      ),
                    ),
                    if (isSender) ...[
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.done_all_rounded,
                        size: 16,
                        color: Color(0xFF3B82F6),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

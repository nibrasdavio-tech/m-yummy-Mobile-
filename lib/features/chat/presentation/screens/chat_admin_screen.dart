import 'dart:async';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/models/chat_message.dart';
import '../widgets/chat_bubble.dart';

/// Halaman "Chat dengan Admin"
///
/// Menampilkan:
/// - Tombol kembali oranye di kiri atas
/// - Judul tebal "Chat dengan Admin"
/// - Garis pemisah atas
/// - Daftar percakapan interaktif dengan bubble kustom (ekor lancip di atas)
/// - Garis pemisah bawah
/// - Kolom input pesan dengan icon lampiran (paperclip), input rounded, dan tombol kirim (paper plane)
class ChatAdminScreen extends StatefulWidget {
  const ChatAdminScreen({super.key});

  @override
  State<ChatAdminScreen> createState() => _ChatAdminScreenState();
}

class _ChatAdminScreenState extends State<ChatAdminScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  // Daftar pesan awal persis sesuai referensi desain
  final List<ChatMessage> _messages = [
    const ChatMessage(
      id: '1',
      text:
          'Halo kak, besok saya sedang tidak ada di kos. Apakah makanan bisa dititipkan ke penjaga kos?',
      time: '10.00',
      isSender: true,
      isRead: true,
    ),
    const ChatMessage(
      id: '2',
      text:
          'Bisa Kak. Diinformasikan tempat penitipannya saja agar kami sampaikan pada bagian pengantaran.😊',
      time: '10.02',
      isSender: false,
      isRead: true,
    ),
    const ChatMessage(
      id: '3',
      text: 'Ada di sebelah kiri pintu masuk kak, terimakasih banyak ya!',
      time: '10.00',
      isSender: true,
      isRead: true,
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  /// Mengirim pesan baru dari pengguna
  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final now = DateTime.now();
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    final formattedTime = '$hour.$minute';

    setState(() {
      _messages.add(
        ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: text,
          time: formattedTime,
          isSender: true,
          isRead: true,
        ),
      );
    });

    _messageController.clear();
    _scrollToBottom();

    // Simulasi balasan otomatis dari admin
    _simulateAdminReply(text);
  }

  /// Simulasi balasan otomatis dari Admin setelah jeda singkat
  void _simulateAdminReply(String userMessage) {
    Timer(const Duration(milliseconds: 1400), () {
      if (!mounted) return;

      final lower = userMessage.toLowerCase();
      String replyText =
          'Baik Kak, informasi sudah kami catat dan dikoordinasikan dengan kurir. Terima kasih! 😊';

      if (lower.contains('terima kasih') || lower.contains('makasih')) {
        replyText = 'Sama-sama Kak! Selamat menikmati hidangan m\'Yummy ya! 🙏😊';
      } else if (lower.contains('jam') || lower.contains('kapan')) {
        replyText =
            'Pengantaran makan siang dilakukan sekitar pukul 11.30 - 12.30 WIB ya Kak. 🍱';
      } else if (lower.contains('menu') || lower.contains('ganti')) {
        replyText =
            'Untuk perubahan menu, Kakak bisa ubah melalui menu Paket sebelum pukul 08.00 pagi ya Kak. 😊';
      }

      final now = DateTime.now();
      final hour = now.hour.toString().padLeft(2, '0');
      final minute = now.minute.toString().padLeft(2, '0');
      final formattedTime = '$hour.$minute';

      setState(() {
        _messages.add(
          ChatMessage(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            text: replyText,
            time: formattedTime,
            isSender: false,
            isRead: true,
          ),
        );
      });

      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  /// Menampilkan menu lampiran dokumen / foto
  void _showAttachmentModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kirim Lampiran',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _attachmentOption(
                      icon: Icons.camera_alt_rounded,
                      label: 'Kamera',
                      color: Colors.pinkAccent,
                    ),
                    _attachmentOption(
                      icon: Icons.photo_library_rounded,
                      label: 'Galeri',
                      color: AppColors.primaryBlue,
                    ),
                    _attachmentOption(
                      icon: Icons.insert_drive_file_rounded,
                      label: 'Dokumen',
                      color: Colors.amber.shade800,
                    ),
                    _attachmentOption(
                      icon: Icons.location_on_rounded,
                      label: 'Lokasi',
                      color: Colors.green,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _attachmentOption({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Fitur kirim $label siap diintegrasikan.'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: color.withValues(alpha: 0.12),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF475569),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Header: Tombol Back & Judul ───
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button oranye
                  GestureDetector(
                    onTap: () => Navigator.of(context).maybePop(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      color: Colors.transparent,
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppColors.accentOrange,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Judul Layar
                  const Text(
                    'Chat dengan Admin',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000000),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),

            // ─── Garis Pemisah Atas ───
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 1,
              color: const Color(0xFFD1D5DB),
            ),

            // ─── Pesan Chat (Scrollable Area) ───
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return ChatBubble(message: _messages[index]);
                },
              ),
            ),

            // ─── Garis Pemisah Bawah ───
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 1,
              color: const Color(0xFFD1D5DB),
            ),

            // ─── Input Bar Bawah ───
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
              child: Row(
                children: [
                  // Icon Lampiran (Paperclip)
                  IconButton(
                    onPressed: _showAttachmentModal,
                    splashRadius: 22,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.attach_file,
                      color: Color(0xFF4B5563),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Input Text "Ketik Pesan..."
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 2,
                      ),
                      child: TextField(
                        controller: _messageController,
                        focusNode: _focusNode,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => _sendMessage(),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1E293B),
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Ketik Pesan...',
                          hintStyle: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 11),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Tombol Kirim (Paper Plane)
                  IconButton(
                    onPressed: _sendMessage,
                    splashRadius: 22,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.send_outlined,
                      color: Color(0xFF374151),
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

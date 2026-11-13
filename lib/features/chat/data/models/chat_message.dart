class ChatMessage {
  final String id;
  final String text;
  final String time;
  final bool isSender;
  final bool isRead;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.time,
    required this.isSender,
    this.isRead = true,
  });
}

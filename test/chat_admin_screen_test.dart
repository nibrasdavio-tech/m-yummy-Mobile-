import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:home/features/chat/presentation/screens/chat_admin_screen.dart';
import 'package:home/features/chat/presentation/widgets/chat_bubble.dart';

void main() {
  testWidgets('ChatAdminScreen renders header, initial messages, and input bar',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ChatAdminScreen(),
      ),
    );

    // Verify title and header back button
    expect(find.text('Chat dengan Admin'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);

    // Verify initial messages
    expect(
      find.text(
        'Halo kak, besok saya sedang tidak ada di kos. Apakah makanan bisa dititipkan ke penjaga kos?',
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        'Bisa Kak. Diinformasikan tempat penitipannya saja agar kami sampaikan pada bagian pengantaran.😊',
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        'Ada di sebelah kiri pintu masuk kak, terimakasih banyak ya!',
      ),
      findsOneWidget,
    );

    // Verify 3 ChatBubbles rendered
    expect(find.byType(ChatBubble), findsNWidgets(3));

    // Verify input bar elements
    expect(find.text('Ketik Pesan...'), findsOneWidget);
    expect(find.byIcon(Icons.attach_file), findsOneWidget);
    expect(find.byIcon(Icons.send_outlined), findsOneWidget);

    // Enter new text and send
    await tester.enterText(find.byType(TextField), 'Siap kak!');
    await tester.tap(find.byIcon(Icons.send_outlined));
    await tester.pump();

    // Verify the sent message appears
    expect(find.text('Siap kak!'), findsOneWidget);
    expect(find.byType(ChatBubble), findsNWidgets(4));

    // Settle scroll animation
    await tester.pump(const Duration(milliseconds: 400));

    // Advance past the 1400ms Timer
    await tester.pump(const Duration(milliseconds: 1600));

    // Settle reply scroll animation
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.byType(ChatBubble), findsNWidgets(5));
  });
}

import 'package:flutter/material.dart';
import 'package:deneme2/models/conversation.dart';

import 'message_widget.dart';

//chatlistview kullanıcı ve yapay zeka yanıtlarını içeren widget
class ChatListView extends StatefulWidget {
  final List<Conversation> conversations;
  const ChatListView({super.key, required this.conversations});

  @override

  //bu widget'a iletilen konuşmaların listesini tutar
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  @override
  //konuşma içeriğinin liste olarak tutulması için yazılan kod dizisi
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.conversations.length,
      itemBuilder: (context, index) {
        Conversation conversation = widget.conversations[index];
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MessageWidget(text: conversation.question),
            const SizedBox(height: 32),
            MessageWidget(
                text: conversation.answer,
                fromAi: true) //yapay zeka mı gönderdi kontrolü
          ],
        );
      },
    );
  }
}

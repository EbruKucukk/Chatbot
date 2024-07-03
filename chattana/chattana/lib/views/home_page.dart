import 'package:deneme2/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:deneme2/models/conversation.dart';
import 'package:deneme2/views/widgets/example_widget.dart';
import 'package:deneme2/views/widgets/chat_text_field.dart';
import 'package:deneme2/views/widgets/chat_list_view.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //kullanıcının metin girişi için controller denetleyicisi
  final TextEditingController controller = TextEditingController();
  List<Conversation> conversations = [];

  //liste boş değilse boolean değeri true döner
  bool get isConversationStarted => conversations.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: CustomColors.background,
      body: SafeArea( //cihazın güvenli sınırları içinde içerik oluşturulur
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //yukarıda belirlenen boolean değere göre içerik değişir
                //eğer konuşma başlamışsa chatlistview konuşmaları listeler
                if (!isConversationStarted) ...[
                  const SizedBox(height: 24), // Üstten biraz boşluk
                  Image.asset("assets/images/logo.png"),
                  const SizedBox(height: 24),
                  Text(
                    "Merhaba! \nBen Tana!",
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: textTheme.headlineMedium!.fontSize! + 2,
                      color: CustomColors.redText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Size nasıl yardımcı olabilirim?",
                    style: textTheme.bodyMedium?.copyWith(
                      fontSize: textTheme.bodyMedium!.fontSize! + 2,
                      color: CustomColors.redText,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Icon(Icons.wb_sunny_outlined,
                      color: CustomColors.redText),
                ] else
                  Expanded(child: ChatListView(conversations: conversations)),
              ],
            ),
          ),
        ),
      ),
      //ekranın altına metin giriş alanı eklenir
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: ChatTextField( //kulanıcının metin girişi yapması sağlanır
          controller: controller,
          //kulanıcı metin gönderdiğinde bu blok çalışır
          onSubmitted: (question) {
            setState(() {
              conversations.add(Conversation(question, "")); //soruyu listeye ekleme
            });
            controller.clear();
            //sunucuya http post isteği gönderilir ve yanıt alınır
            http.post(
              Uri.parse("http://127.0.0.1:5000/get-response"),
              body: jsonEncode({"text": question}),
              headers: {
                "Content-Type": "application/json",
              },
            ).then((response) {
              String result = jsonDecode(response.body)['response'];
              //conversation listesi güncellenir
              setState(() {
                conversations.last =
                    Conversation(conversations.last.question, result);
              });
            });
          },
        ),
      ),
    );
  }
}

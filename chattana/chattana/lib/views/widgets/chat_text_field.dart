import 'package:deneme2/constants/colors.dart';
import 'package:flutter/material.dart';

class ChatTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSubmitted;

  const ChatTextField(
      {super.key, required this.controller, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: CustomColors.lightRedBubble, // Daha açık kırmızı renk
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white)),
        child: Row(
          children: [
            const SizedBox(width: 8),
            Flexible(
              child: TextField(
                  controller: controller,
                  cursorColor: Colors.white,
                  style:
                      const TextStyle(color: Colors.white), // Yazı rengi beyaz
                  decoration: const InputDecoration(border: InputBorder.none)),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: IconButton(
                //butona basıldığında kullanıcının yazdığı metni fonksiyona çevirir
                onPressed: () {
                  onSubmitted(controller.text);
                },
                //buton ve stili oluşturuldu
                style: IconButton.styleFrom(
                    backgroundColor: CustomColors.sendButton,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4))),
                icon: const Icon(Icons.arrow_forward_ios,
                    color: Colors.white), // Kibar ok
              ),
            )
          ],
        ));
  }
}

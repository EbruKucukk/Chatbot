import 'package:deneme2/constants/colors.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final String text;
  final bool fromAi;

  const MessageWidget({super.key, required this.text, this.fromAi = false});

  @override
  Widget build(BuildContext context) {
    return Align(
      //alignment 'fromAi' değişkeinine göre ayarlanır
      //yapay zeka mesajları sola, kullanıcı mesajları sağa hizalanır
      alignment: fromAi ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .8),
        decoration: BoxDecoration(
            //mesajın yapay zeka tarafından gönderilip gönderilmediği kontrol edilir
            color: fromAi ? CustomColors.pinkBubble : CustomColors.redBubble,
            borderRadius: BorderRadius.circular(8).copyWith(
                bottomLeft: fromAi ? const Radius.circular(0) : null,
                bottomRight: !fromAi ? const Radius.circular(0) : null)),
        padding: const EdgeInsets.all(12),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}

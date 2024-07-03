import 'package:deneme2/constants/colors.dart';
import 'package:flutter/material.dart';

class ExampleWidget extends StatelessWidget {
  //iletilen ve gösterilecek metin
  final String text;

  const ExampleWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    //uygulama için tema ayarları
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: CustomColors.darkGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 36),
      child: Text(
        text,
        style: textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
    );
  }
}

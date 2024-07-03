import 'package:flutter/material.dart';
import 'package:deneme2/views/home_page.dart';

//MyApp fonksiyonu başlatılır
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatTana', //ChatTana uygulama başlığı
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(), //home_page dosyasından HomePage widget'ı çağrılır
    );
  }
}

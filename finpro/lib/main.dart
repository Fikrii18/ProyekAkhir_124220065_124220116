import 'package:finpro/login_pages.dart';
import 'package:finpro/model/komentar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Hive.initFlutter(); 
  Hive.registerAdapter(KomentarAdapter());

  await Hive.openBox<Komentar>('komentarBox'); 

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resep Makanan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.white,
          textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white))),
      home: LoginPages(), 
    );
  }
}

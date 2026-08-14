import 'package:flutter/material.dart';
import 'package:book_nook/core/injection/injection_container.dart';
import 'package:book_nook/features/library/presentation/pages/book_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Nook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BookPage(),
    );
  }
}
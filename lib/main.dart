import 'package:ajiledakarv/auth/begin.dart';
import 'package:ajiledakarv/auth/login.dart';
import 'package:ajiledakarv/auth/splash.dart';
import 'package:ajiledakarv/bottom_navigation_bar.dart';
import 'package:ajiledakarv/roviders/notifier.dart';
import 'package:ajiledakarv/screen/chat/chatBoot.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => DNotifier(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.orange,
          ),
          title: '',
          home: Splash(),
        ));
  }
}

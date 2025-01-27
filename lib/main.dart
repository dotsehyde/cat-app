import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:simpleapp/controller/auth.controller.dart';
import 'package:simpleapp/page/home.dart';
import 'package:simpleapp/page/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AuthController authState = AuthController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      darkTheme: ThemeData.dark().copyWith(
          primaryColor: Colors.red,
          textTheme: TextTheme(
            headlineMedium: TextStyle(color: Colors.white),
            headlineSmall: TextStyle(color: Colors.white),
            bodySmall: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white),
          )),
      theme: ThemeData.light().copyWith(
          primaryColor: Colors.red,
          textTheme: TextTheme(
            headlineMedium: TextStyle(color: Colors.black),
            headlineSmall: TextStyle(color: Colors.black),
            bodySmall: TextStyle(color: Colors.black),
            bodyMedium: TextStyle(color: Colors.black),
          )),
      home: AnimatedBuilder(
          animation: authState,
          builder: (context, _) {
            if (authState.user != null) {
              return HomePage();
            }
            return LoginPage();
          }),
    );
  }
}

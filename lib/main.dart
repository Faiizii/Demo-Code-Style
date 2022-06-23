import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upwork_assignment/test_code/test_screen.dart';
import 'package:upwork_assignment/view/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upwork Assignment',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: const Color(0xFF25a0a2),
        )
      ),
      home: const TestScreen(),
    );
  }

}
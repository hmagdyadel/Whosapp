import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whosapp/model/chat_model.dart';
import 'package:whosapp/screens/home_screen.dart';
import 'package:whosapp/screens/landing_screen.dart';
import '../screens/camera_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  cameras = await availableCameras();
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  String? _id = preferences.getString('id');
  runApp(MyApp(id: _id));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, this.id}) : super(key: key);
  final String? id;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhosApp',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primaryColor: const Color(0xFF128C7E),
        colorScheme: theme.colorScheme.copyWith(
          secondary: const Color(0xFF075E54),
        ),
      ),
      home: widget.id != null
          ? HomeScreen(
              chatModel: [],
              sourceChat: ChatModel(isGroup: false),
            )
          : LandingScreen(),
    );
  }
}

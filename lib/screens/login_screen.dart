import 'package:flutter/material.dart';
import 'package:whosapp/customUI/button_card.dart';
import 'package:whosapp/screens/home_screen.dart';
import '../model/chat_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ChatModel? sourceChat;
  List<ChatModel> chats = [
    ChatModel(
      name: 'Mena Magdy',
      isGroup: false,
      currentMessage: 'Hello How are you?',
      time: '11:13',
      icon: 'person.svg',
      id: 1,
    ),
    ChatModel(
        name: 'Ebram Magdy',
        isGroup: false,
        currentMessage: 'Hello How do you do?',
        time: '9:15',
        icon: 'person.svg',
        id: 2),
    ChatModel(
      name: 'Ebram Ayoub',
      isGroup: false,
      currentMessage: 'Hello where are you?',
      time: '4:21',
      icon: 'person.svg',
      id: 3,
    ),
    ChatModel(
      name: 'Mina Ashraf',
      isGroup: false,
      currentMessage: 'Hello where are you?',
      time: '4:12',
      icon: 'person.svg',
      id: 4,
    ),
    // ChatModel(
    //   name: 'Friends',
    //   isGroup: true,
    //   currentMessage: 'Hello anyone is online?',
    //   time: '3:31',
    //   icon: 'groups.svg',
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            sourceChat = chats.removeAt(index);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (builder) => HomeScreen(
                          chatModel: chats,
                          sourceChat: sourceChat,
                        )));
          },
          child: ButtonCard(
            name: chats[index].name,
            icon: Icons.person,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../screens/select_contact.dart';
import '../customUI/custom_card.dart';
import '../model/chat_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, this.chatModel, this.sourceChat}) : super(key: key);
  final List<ChatModel>? chatModel;
  final ChatModel? sourceChat;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.chatModel!.length != 0
          ? ListView.builder(
              itemCount: widget.chatModel!.length,
              itemBuilder: (context, index) => CustomCard(
                chatModel: widget.chatModel![index],
                sourceChat: widget.sourceChat,
              ),
            )
          : Center(
              child: Text(
                'Chat with your friends who use WhosApp on iPhone, Android, or kaiOS Phone.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.grey[700]),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent[700],
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => const SelectContact()));
        },
        child: const Icon(
          Icons.chat,
        ),
      ),
    );
  }
}

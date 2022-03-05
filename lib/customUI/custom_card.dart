import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whosapp/model/chat_model.dart';
import 'package:whosapp/screens/individual_page.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, this.chatModel, this.sourceChat})
      : super(key: key);
  final ChatModel? chatModel;
  final ChatModel? sourceChat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IndividualPage(
              chatModel: chatModel,
            ),
          ),
        );
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: SvgPicture.asset(
                chatModel!.isGroup
                    ? 'assets/icons/groups.svg'
                    : 'assets/icons/person.svg',
                color: Colors.white,
                height: 35,
                width: 35,
              ),
              backgroundColor: Colors.blueGrey[200],
            ),
            title: Text(
              chatModel!.name.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                const Icon(
                  Icons.done_all,
                  color: Colors.grey,
                ),
                const SizedBox(width: 3),
                Text(
                  chatModel!.currentMessage.toString(),
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            trailing: Text(chatModel!.time.toString()),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whosapp/model/chat_model.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({Key? key, this.contacts}) : super(key: key);
  final ChatModel? contacts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blueGrey[200],
                radius: 23,
                child: SvgPicture.asset(
                  'assets/icons/person.svg',
                  color: Colors.white,
                  width: 30,
                  height: 30,
                ),
              ),
              const Positioned(
                bottom: 4,
                right: 0,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: 13,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 2),
          Text(
            contacts!.name.toString(),
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

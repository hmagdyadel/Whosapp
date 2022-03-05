import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whosapp/customUI/avatar_card.dart';
import 'package:whosapp/customUI/contact_cart.dart';
import 'package:whosapp/model/chat_model.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ChatModel> contacts = [
    ChatModel(isGroup: false, name: 'Ebram Magdy', status: 'My brother'),
    ChatModel(isGroup: false, name: 'Mena Magdy', status: 'My Friend'),
    ChatModel(isGroup: false, name: 'Jack Magdy', status: 'My brother'),
    ChatModel(isGroup: false, name: 'Ebram Samir', status: 'My Friend'),
    ChatModel(isGroup: false, name: 'Ebram Magdy', status: 'My brother'),
    ChatModel(isGroup: false, name: 'Mena Magdy', status: 'My Friend'),
    ChatModel(isGroup: false, name: 'Jack Magdy', status: 'My brother'),
    ChatModel(isGroup: false, name: 'Ebram Samir', status: 'My Friend'),
    ChatModel(isGroup: false, name: 'Ebram Magdy', status: 'My brother'),
    ChatModel(isGroup: false, name: 'Mena Magdy', status: 'My Friend'),
    ChatModel(isGroup: false, name: 'Jack Magdy', status: 'My brother'),
    ChatModel(isGroup: false, name: 'Ebram Samir', status: 'My Friend'),
  ];
  List<ChatModel> groups = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF075E54),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'New Group',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Add participants',
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 26,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
              itemCount: contacts.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    height: groups.isNotEmpty ? 90 : 10,
                  );
                }
                return InkWell(
                  onTap: () {
                    if (contacts[index - 1].select == false) {
                      setState(() {
                        contacts[index - 1].select = true;
                        groups.add(contacts[index - 1]);
                      });
                    } else {
                      setState(() {
                        contacts[index - 1].select = false;
                        groups.remove(contacts[index - 1]);
                      });
                    }
                  },
                  child: Container(),
                  // child: ContactCard(
                  //   contact: contacts[index-1],
                  // ),
                );
              }),
          groups.isNotEmpty
              ? Column(
                  children: [
                    Container(
                      height: 75,
                      color: Colors.white,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            if (contacts[index].select) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    contacts[index].select = false;
                                    groups.remove(contacts[index]);
                                  });
                                },
                                child: AvatarCard(
                                  contacts: contacts[index],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ),
                    const Divider(thickness: 1)
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}

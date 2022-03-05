import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whosapp/pages/calls_page.dart';
import 'package:whosapp/pages/status_page.dart';
import 'package:whosapp/screens/settings_screen.dart';
import '../model/chat_model.dart';
import '../pages/camera_page.dart';
import '../pages/chat_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.chatModel, this.sourceChat})
      : super(key: key);
  final List<ChatModel>? chatModel;
  final ChatModel? sourceChat;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    getPrefs();
    _controller = TabController(
      length: 4,
      vsync: this,
      initialIndex: 1,
    );
    super.initState();
  }

  getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('id'));
    print(prefs.getString('name'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF075E54),
          title: const Text('WhosApp'),
          actions: [
            IconButton(
              onPressed: () {
                print(widget.chatModel!.length);
              },
              icon: const Icon(Icons.search),
            ),
            PopupMenuButton(
              onSelected: (value) {
                if (value == 'Settings') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) =>const SettingsScreen()));
                }
              },
              itemBuilder: (context) {
                return const [
                  PopupMenuItem(
                    child: Text('New group'),
                    value: 'New group',
                  ),
                  PopupMenuItem(
                    child: Text('New broadcast'),
                    value: 'New broadcast',
                  ),
                  PopupMenuItem(
                    child: Text('WhosApp web'),
                    value: 'WhosApp web',
                  ),
                  PopupMenuItem(
                    child: Text('Starred messages'),
                    value: 'Starred messages',
                  ),
                  PopupMenuItem(
                    child: Text('Settings'),
                    value: 'Settings',
                  ),
                ];
              },
            )
          ],
          bottom: TabBar(
            controller: _controller,
            indicatorColor: Colors.white,
            tabs: const [
              Tab(
                icon: Icon(Icons.camera_alt),
              ),
              Tab(
                text: 'Chats',
              ),
              Tab(
                text: 'Status',
              ),
              Tab(
                text: 'Calls',
              )
            ],
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            const CameraPage(),
            ChatPage(
              chatModel: widget.chatModel,
              sourceChat: widget.sourceChat,
            ),
            const StatusPage(),
            const CallsPage(),
          ],
        ));
  }
}

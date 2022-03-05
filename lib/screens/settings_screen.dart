import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whosapp/model/utility.dart';
import 'package:whosapp/screens/profile_details.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String name = '';
  Widget? imageFromPreferences;
  String? image;
  String about='';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadImageFromPreferences(MediaQuery.of(context).size.height);

    getName();
  }

  loadImageFromPreferences(double height) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    image = preferences.getString('image_key');
    setState(() {
      imageFromPreferences = CircleAvatar(
        backgroundColor: Colors.grey[400],
        radius: height / 25,
        child: Container(
          height: height / 12.5,
          width: height / 12.5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Transform.rotate(
              angle: preferences.getDouble('angle')!,
              child: Image.memory(
                base64Decode(
                  image!,
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      );
    });
  }

  getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

      name =(await Utility.getDetails('name'))!;
      image = prefs.getString('image_key');
      about=(await Utility.getDetails('about'))!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF075E54),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => const ProfileDetails()));
              },
              child: ListTile(
                leading: Hero(
                  tag: 'profile',
                  child: image == null
                      ? CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey[400],
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 40,
                          ),
                        )
                      : imageFromPreferences!,
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.qr_code_outlined),
                  color: Colors.teal[300],
                ),
                title: Text(
                  name,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  about,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
            Divider(
              thickness: 0.5,
              color: Colors.grey[300],
            ),
            ListTile(
              leading: Transform.rotate(
                angle: 190,
                child: Icon(
                  Icons.vpn_key_sharp,
                  size: 30,
                  color: Colors.teal[300],
                ),
              ),
              title: Text('Account'),
              subtitle: Text('Privacy, Security, change number'),
            ),
            ListTile(
              leading: Icon(
                Icons.chat_rounded,
                size: 30,
                color: Colors.teal[300],
              ),
              title: Text('Chats'),
              subtitle: Text('Theme, wallpapers, chat history'),
            ),
            ListTile(
              leading: Icon(
                Icons.add_alert_rounded,
                size: 30,
                color: Colors.teal[300],
              ),
              title: Text('Notifications'),
              subtitle: Text('Message, group & call tones'),
            ),
            ListTile(
              leading: Icon(
                Icons.data_usage,
                size: 30,
                color: Colors.teal[300],
              ),
              title: Text('Storage and data'),
              subtitle: Text('Network usage, auto download'),
            ),
            ListTile(
              leading: Icon(
                Icons.help_outline_outlined,
                size: 30,
                color: Colors.teal[300],
              ),
              title: Text('Help'),
              subtitle: Text('Help center, contact us, privacy policy'),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: MediaQuery.of(context).size.width / 5),
              child: Divider(
                thickness: 0.5,
                color: Colors.grey[300],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.group,
                size: 30,
                color: Colors.teal[300],
              ),
              title: Text('Invite a friend'),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 15),
            Text(
              'from',
              style: TextStyle(color: Colors.grey[600]),
            ),
            Text(
              'HAITHAM',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:whosapp/customUI/call_card.dart';

class CallsPage extends StatefulWidget {
  const CallsPage({Key? key}) : super(key: key);

  @override
  _CallsPageState createState() => _CallsPageState();
}

class _CallsPageState extends State<CallsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Calls(
                name: 'Ebram Magdy',
                time: 'July 18,11:46 AM',
                imageName: 'assets/icons/3.png',
                whoCall: true,
                callOrVideo: false),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 4, right: 10),
              child: const Divider(),
            ),
            const Calls(
                name: 'Mina Magdy',
                time: 'June 11,01:46 AM',
                imageName: 'assets/icons/1.png',
                whoCall: false,
                callOrVideo: true),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 4, right: 10),
              child: const Divider(),
            ),
            const Calls(
                name: 'Mina Magdy',
                time: 'June 10,11:46 AM',
                imageName: 'assets/icons/2.png',
                whoCall: true,
                callOrVideo: false),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 4, right: 10),
              child: const Divider(),
            ),
            const Calls(
                name: 'Mina Magdy',
                time: 'July 18,11:46 AM',
                imageName: 'assets/icons/4.png',
                whoCall: true,
                callOrVideo: true),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 4, right: 10),
              child: const Divider(),
            ),
            const Calls(
                name: 'Mina Magdy',
                time: 'July 18,11:46 AM',
                imageName: 'assets/icons/1.png',
                whoCall: false,
                callOrVideo: false),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 4, right: 10),
              child: const Divider(),
            ),
            const Calls(
                name: 'Mina Magdy',
                time: 'July 18,11:46 AM',
                imageName: 'assets/icons/2.png',
                whoCall: false,
                callOrVideo: true),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 4, right: 10),
              child: const Divider(),
            ),
            const Calls(
                name: 'Mina Magdy',
                time: 'July 18,11:46 AM',
                imageName: 'assets/icons/3.png',
                whoCall: false,
                callOrVideo: true),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 4, right: 10),
              child: const Divider(),
            ),
            const Calls(
                name: 'Mina Magdy',
                time: 'July 18,11:46 AM',
                imageName: 'assets/icons/4.png',
                whoCall: false,
                callOrVideo: true),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 4, right: 10),
              child: const Divider(),
            ),
            const Calls(
                name: 'Mina Magdy',
                time: 'July 18,11:46 AM',
                imageName: 'assets/icons/1.png',
                whoCall: false,
                callOrVideo: true),
          ],
        ),
      ),
    );
  }
}

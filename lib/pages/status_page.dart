import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whosapp/customUI/statusPage/other_status.dart';
import 'package:whosapp/customUI/statusPage/own_status.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const OwnStatus(),
            label('Recent updates'),
            const OtherStatus(
              name: 'Ebram Magdy',
              time: '01:21',
              imageName: 'assets/icons/3.png',
              isSeen: false,
              statusNum: 8,
            ),
            const OtherStatus(
              name: 'Mina Magdy',
              time: '01:16',
              imageName: 'assets/icons/4.png',
              isSeen: false,
              statusNum: 2,
            ),
            const OtherStatus(
              name: 'Ebram Samir',
              time: '01:10',
              imageName: 'assets/icons/1.png',
              isSeen: false,
              statusNum: 3,
            ),
            const SizedBox(height: 10),
            label('Viewed updates'),
            const OtherStatus(
              name: 'Ebram Magdy',
              time: '01:21',
              imageName: 'assets/icons/3.png',
              isSeen: true,
              statusNum: 4,
            ),
            const OtherStatus(
              name: 'Mina Magdy',
              time: '01:16',
              imageName: 'assets/icons/4.png',
              isSeen: true,
              statusNum: 5,
            ),
            const OtherStatus(
              name: 'Ebram Samir',
              time: '01:10',
              imageName: 'assets/icons/1.png',
              isSeen: true,
              statusNum: 6,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 48,
            child: FloatingActionButton(
              backgroundColor: Colors.blueGrey[100],
              elevation: 8,
              onPressed: () {},
              child: Icon(
                Icons.edit,
                color: Colors.blueGrey[900],
              ),
            ),
          ),
          const SizedBox(height: 13),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.greenAccent[700],
            elevation: 5,
            child: const Icon(Icons.camera_alt),
          )
        ],
      ),
    );
  }

  Widget label(String labelName) {
    return Container(
      height: 33,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
        child: Text(
          labelName,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

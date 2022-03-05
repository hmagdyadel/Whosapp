import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonCard extends StatelessWidget {
  const ButtonCard({Key? key, this.name, this.icon}) : super(key: key);
  final String? name;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.teal[300],
        radius: 23,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      title: Text(
        name!,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }
}

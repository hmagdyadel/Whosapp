import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whosapp/screens/individual_page.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({Key? key, required this.contact}) : super(key: key);
  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (builder)=>IndividualPage()));
      },
      child: ListTile(
        leading: SizedBox(
          height: 53,
          width: 50,
          child: Stack(
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
            ],
          ),
        ),
        title: Text(
          contact.displayName.toString(),
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Hey there! Iam using WhosApp',
          style: TextStyle(fontSize: 13),
        ),
      ),
    );
  }
}

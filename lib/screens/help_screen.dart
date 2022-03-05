import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF075E54),
        title: const Text(
          'Contact support',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: screenHeight / 75),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              minLines: 4,
              maxLines: 10,
              decoration: InputDecoration(
                focusColor: Colors.grey,
                filled: true,
                hintText: 'Describe your problem',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF075E54)),
                ),
              ),
            ),
          ),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {},
                  child: const Text(
                    'Visit our Help Center',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF075E54),
                    ),
                    height: screenHeight / 18.75,
                    width: screenHeight / 10.71,
                    child: const Center(
                      child: Text(
                        'NEXT',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:whosapp/services/auth_service.dart';
import 'help_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key, this.number, this.countryCode}) : super(key: key);
  final String? number;
  final String? countryCode;

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  int start = 59;
  TextEditingController phoneController = TextEditingController();
  AuthClass authClass = AuthClass();
  String verificationId = "";
  String smsCode = "";

  @override
  void didChangeDependencies() async {
    await authClass.verifyPhoneNumber(
        '${widget.countryCode}${widget.number}', context, setData);
    startTimer();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Verify ${widget.countryCode} ${widget.number}',
          style: TextStyle(
              color: Colors.teal[800],
              fontSize: 16.5,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onSelected: (value) {
              if (value == 'Help') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => const HelpScreen(),
                  ),
                );
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  height: MediaQuery.of(context).size.height / 22,
                  onTap: () {},
                  child: const Text('Help'),
                  value: 'Help',
                ),
              ];
            },
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Waiting to automatically detect an SMS sent to ',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14.5,
                    ),
                  ),
                  TextSpan(
                    text: widget.countryCode! + " " + widget.number!,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ' Wrong number?',
                    style: TextStyle(
                      color: Colors.blue[300],
                      fontSize: 14.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width / 1.5,
              fieldWidth: 20,
              style: const TextStyle(
                fontSize: 15,
              ),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) async {
                setState(() {
                  smsCode = pin;
                });
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString("id", widget.countryCode! + widget.number!);
                authClass.signInWithPhoneNumber(
                    verificationId, smsCode, context);
              },
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 44),
              child: Divider(
                color: Colors.teal,
                thickness: 2,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Enter 6-digit code',
              style: TextStyle(
                fontSize: 14.5,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 30),
            bottomButton('Resend SMS', Icons.message),
            const SizedBox(height: 12),
            const Divider(thickness: 1.5),
            const SizedBox(height: 12),
            bottomButton('Call Me', Icons.call),
          ],
        ),
      ),
    );
  }

  Widget bottomButton(String text, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: start == 0 ? Colors.teal : Colors.grey,
          size: 24,
        ),
        const SizedBox(width: 25),
        Text(
          text,
          style: TextStyle(
            fontSize: 17,
            color: start == 0 ? Colors.teal : Colors.grey,
          ),
        ),
        Expanded(child: Container()),
        Text(
          '00:$start',
          style: TextStyle(
            fontSize: 17,
            color: start == 0 ? Colors.grey : Colors.teal,
          ),
        )
      ],
    );
  }

  void startTimer() {
    const onSec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onSec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  void setData(id) {
    setState(() {
      verificationId = id;
    });
    startTimer();
  }
}

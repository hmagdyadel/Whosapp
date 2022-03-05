import 'package:flutter/material.dart';
import 'package:whosapp/model/country_model.dart';
import 'package:whosapp/screens/country_page.dart';
import 'package:whosapp/screens/help_screen.dart';

import 'otp_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String countryName = 'Egypt';
  String countryCode = '+2';
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Enter your phone number',
          style: TextStyle(
            color: Colors.teal,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            wordSpacing: 1,
          ),
        ),
        centerTitle: true,
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
                  height: screenHeight / 22,
                  onTap: () {},
                  child: const Text('Help'),
                  value: 'Help',
                ),
              ];
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Column(
            children: [
              SizedBox(height: screenHeight / 75),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: const TextStyle(
                          color: Colors.black, fontSize: 14, height: 1.5),
                      children: [
                        const TextSpan(
                            text:
                                'WhosApp will send an SMS message to verify your phone number. ',
                            style: TextStyle(
                              color: Colors.black,
                            )),
                        TextSpan(
                          text: "What's my number?",
                          style: TextStyle(color: Colors.blue[300]),
                        ),
                      ]),
                ),
              ),
              SizedBox(height: screenHeight / 150),
              countryCard(screenWidth),
              SizedBox(height: screenHeight / 150),
              number(screenWidth, screenHeight),
              SizedBox(height: screenHeight / 75),
              Text(
                'Carrier SMS charges may apply',
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
              Expanded(child: Container()),
              InkWell(
                onTap: () {
                  if (_controller.text.length > 10) {
                    dialogShow();
                  } else {
                    dialogShowNoNumber();
                  }
                },
                child: Container(
                  color: Colors.greenAccent[700],
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
              SizedBox(height: screenHeight / 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget countryCard(double screenWidth) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) => CountryPage(
              setCountryData: setCountryData,
            ),
          ),
        );
      },
      child: Container(
        width: screenWidth / 1.5,
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.teal,
              width: 1.2,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                child: Center(
                  child: Text(
                    countryName,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: Colors.teal,
              size: 25,
            )
          ],
        ),
      ),
    );
  }

  void setCountryData(CountryModel countryModel) {
    setState(() {
      countryName = countryModel.name!;
      countryCode = countryModel.code!;
    });
    Navigator.pop(context);
  }

  Widget number(double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth / 1.5,
      height: screenHeight / 19.73,
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            width: screenHeight / 15.8,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.teal,
                  width: 1.2,
                ),
              ),
            ),
            child: Row(
              children: [
                SizedBox(width: screenHeight / 75),
                const Text(
                  '+',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(width: screenHeight / 93.75),
                Text(
                  countryCode.substring(1),
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          SizedBox(width: screenHeight / 50),
          Container(
            width: screenWidth / 1.5 - 65,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.teal,
                  width: 1.8,
                ),
              ),
            ),
            child: TextFormField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8),
                  hintText: 'phone number'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> dialogShow() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'We will be verifying your phone number',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 75),
                  Text(
                    countryCode + " " + _controller.text,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 75),
                  const Text(
                    'Is this ok, or would you like edit the number?',
                    style: TextStyle(fontSize: 13.5),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Edit'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => OTPScreen(
                                countryCode: countryCode,
                                number: _controller.text,
                              )));
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  Future<void> dialogShowNoNumber() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'There is no number you entered',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
  }
}

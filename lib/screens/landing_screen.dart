import 'package:flutter/material.dart';
import 'package:whosapp/screens/login_page.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 12.7),
                const Text(
                  'Welcome to WhosApp',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 29,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 9,
                ),
                Image.asset(
                  'assets/icons/bg.png',
                  color: Colors.greenAccent[700],
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width / 1.29,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                              text: 'Read our ',
                              style: TextStyle(
                                color: Colors.grey[500],
                              )),
                          const TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(color: Colors.blue),
                          ),
                          TextSpan(
                              text: '. Tab "Agree and Continue" to accept the ',
                              style: TextStyle(
                                color: Colors.grey[500],
                              )),
                          const TextSpan(
                            text: 'Terms of service',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ]),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/37.5),
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(

                        context,
                        MaterialPageRoute(
                          builder: (builder) => const LoginPage(),
                        ),
                        (route) => false);
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 18.90,
                    width: MediaQuery.of(context).size.width - 90,
                    child: Card(
                      margin: const EdgeInsets.all(0),
                      elevation: 8,
                      color: Colors.greenAccent[700],
                      child: const Center(
                        child: Text(
                          'AGREE AND CONTINUE',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 13,
                ),
                const Text(
                  'from',
                  style: TextStyle(color: Colors.grey),
                ),
                 SizedBox(height: MediaQuery.of(context).size.height/150),
                Text(
                  'HAITHAM',
                  style: TextStyle(
                    color: Colors.greenAccent[700],
                    fontSize: 17,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

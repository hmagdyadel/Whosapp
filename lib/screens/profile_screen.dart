import 'dart:convert';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whosapp/model/chat_model.dart';
import 'package:whosapp/model/utility.dart';
import 'package:whosapp/screens/camera_screen.dart';
import 'package:whosapp/screens/home_screen.dart';
import 'package:whosapp/screens/select_gallery_image.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({Key? key}) : super(key: key);

  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  final ImagePicker _picker = ImagePicker();
  XFile? file;
  int popTime = 0;
  bool show = false;
  FocusNode focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  Widget? imageFromPreferences;
  String? image;

  loadImageFromPreferences(double height) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    image = (await Utility.getDetails('image_key'))!;
    setState(() {
      imageFromPreferences = CircleAvatar(
        backgroundColor: Colors.white,
        radius: height / 11,
        child: Container(
          height: height / 5,
          width: height / 5,
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

  @override
  void didChangeDependencies() {
    loadImageFromPreferences(MediaQuery.of(context).size.height);
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Profile info',
          style: TextStyle(
              color: Colors.teal, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: screenHeight / 75),
            Text(
              'Please provide your name and an optional profile photo',
              style: TextStyle(color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight / 25),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Colors.white,
                    context: context,
                    builder: (builder) => bottomSheet());
              },
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Colors.transparent,
                ),
                child: image == null
                    ? CircleAvatar(
                        radius: screenWidth / 6,
                        backgroundColor: Colors.grey[200],
                        child: Icon(
                          Icons.add_a_photo,
                          size: 50,
                          color: Colors.grey[500],
                        ),
                      )
                    : imageFromPreferences,
              ),
            ),
            SizedBox(height: screenHeight / 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenHeight / 65),
              child: Column(
                children: [
                  TextFormField(
                    controller: _controller,
                    focusNode: focusNode,
                    cursorColor: Colors.teal,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type your name here',
                      suffixIcon: IconButton(
                          onPressed: () {
                            focusNode.unfocus();
                            focusNode.canRequestFocus = false;
                            setState(() {
                              show = !show;
                            });
                          },
                          icon: Icon(
                            Icons.emoji_emotions_outlined,
                            color: show ? Colors.teal : Colors.grey[500],
                            size: 35,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: screenHeight / 50, right: screenHeight / 13.6),
              child: const Divider(
                color: Colors.teal,
                thickness: 2,
              ),
            ),
            Expanded(
              child: Container(),
            ),
            InkWell(
              onTap: () async {
                if (_controller.text.isNotEmpty) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => HomeScreen(
                        sourceChat: ChatModel(isGroup: false),
                        chatModel: [],
                      ),
                    ),
                  );
                  Utility.saveDetails('name', _controller.text);
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Enter your name')));
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
            show
                ? SizedBox(height: screenHeight / 50)
                : SizedBox(height: screenHeight / 25),
            show ? emojiSelect() : Container(),
          ],
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return SizedBox(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    iconCreation(Icons.camera_alt, Colors.pink, 'Camera', () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => CameraScreen(
                                    onImageSend: () {},
                                    message: 'profile',
                                    id: '2',
                                  )));
                    }),
                    SizedBox(width: 25),
                    iconCreation(Icons.insert_photo, Colors.purple, 'Gallery',
                        () async {
                      setState(() {});
                      file =
                          await _picker.pickImage(source: ImageSource.gallery);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => SelectGalleryImage(
                            path: file!.path,
                            id: '1',
                          ),
                        ),
                      );

                      //   print(imageFile.toString());
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onImageSend(String path, String message) async {}

  Widget iconCreation(IconData icon, Color color, String text, onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 33,
            backgroundColor: color,
            child: Icon(
              icon,
              size: 30,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            text,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          )
        ],
      ),
    );
  }

  Widget emojiSelect() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: EmojiPicker(
          indicatorColor: Colors.red,
          rows: 4,
          columns: 6,
          onEmojiSelected: (emoji, category) {
            setState(() {
              _controller.text = _controller.text + emoji.emoji;
            });
          }),
    );
  }
}

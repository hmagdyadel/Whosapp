import 'dart:convert';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/utility.dart';
import '../screens/camera_screen.dart';
import '../screens/select_gallery_image.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key? key}) : super(key: key);

  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  String name = '';
  String phone = '';
  String about = '';
  bool delete = false;
  final ImagePicker _picker = ImagePicker();
  XFile? file;
  Widget? imageFromPreferences;
  String? image;
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool showKey = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getName();
    loadImageFromPreferences(MediaQuery.of(context).size.height);
  }

  @override
  initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  getName() async {
    name = (await Utility.getDetails('name'))!;
    about = (await Utility.getDetails('about'))!;
    phone = (await Utility.getDetails('id'))!;
    (await Utility.getDetails('image_key'))!;
    image = (await Utility.getDetails('image_key'))!;
  }

  loadImageFromPreferences(double height) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    image = (await Utility.getDetails('image_key'))!;

    setState(() {
      imageFromPreferences = CircleAvatar(
        backgroundColor: Colors.white,
        radius: height / 10,
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF075E54),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Center(
                  child: Stack(
                    children: [
                      Hero(
                        tag: 'profile',
                        child: image == null
                            ? CircleAvatar(
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 90,
                                ),
                                radius: 75,
                                backgroundColor: Colors.grey[400],
                              )
                            : imageFromPreferences!,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.white,
                                context: context,
                                builder: (builder) => bottomSheet());
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.teal[700],
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  size: 25,
                  color: Colors.teal[300],
                ),
                title: Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                subtitle: Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.white,
                        context: context,
                        isScrollControlled: true,
                        builder: (builder) =>
                            bottomSheetEdit('Enter your name', name, 'name',1));
                  },
                  icon: Icon(Icons.edit),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 5,
                ),
                child: Text(
                  'This is not your username or pin. This name will be'
                  ' visible to your WhosApp contacts',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 5,
                ),
                child: Divider(
                  thickness: 0.5,
                  color: Colors.grey[300],
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.info_outline,
                  size: 25,
                  color: Colors.teal[300],
                ),
                title: Text(
                  'About',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                subtitle: Text(
                  about,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.white,
                        context: context,
                        isScrollControlled: true,
                        builder: (builder) =>
                            bottomSheetEdit('Add About', about, 'about',2));
                  },
                  icon: Icon(Icons.edit),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 5,
                ),
                child: Divider(
                  thickness: 0.5,
                  color: Colors.grey[300],
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.call,
                  size: 25,
                  color: Colors.teal[300],
                ),
                title: Text(
                  'Phone',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                subtitle: Text(
                  phone,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomSheetEdit(String title, String hint, String key,int num) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        child: SizedBox(
          height: show ? 450 : 200,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  controller: _controller,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: TextStyle(
                        color: Colors.black, backgroundColor: Colors.teal[200]),
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
                          color: Colors.grey[500],
                          size: 35,
                        )),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 10, right: MediaQuery.of(context).size.height / 13.6),
                child: const Divider(
                  color: Colors.teal,
                  thickness: 2,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      child: Text(
                        'CANCEL',
                        style: TextStyle(
                            color: Colors.teal,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 30),
                    InkWell(
                      onTap: () {
                        try {
                          Utility.saveDetails(key, _controller.text);
                          setState(() {
                            if(num==1){
                              name=_controller.text;
                            }
                            if(num==2){
                              about=_controller.text;
                            }
                          });
                          Navigator.pop(context);
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Text('SAVE',
                          style: TextStyle(
                              color: Colors.teal,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                    )
                  ],
                ),
              ),
              show ? emojiSelect() : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return SizedBox(
      height: 140,
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                children: [
                  iconCreation(Icons.delete, Colors.red, 'Remove photo',
                      () async {
                    final SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    preferences.remove('image_key');
                    setState(() {
                      image = null;
                    });
                    for (int i = 0; i < 2; i++) {
                      Navigator.pop(context);
                    }
                  }),
                  SizedBox(width: 10),
                  iconCreation(Icons.insert_photo, Colors.purple, 'Gallery',
                      () async {
                    file = await _picker.pickImage(source: ImageSource.gallery);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => SelectGalleryImage(
                          path: file!.path,
                          id: '3',
                        ),
                      ),
                    );
                  }),
                  SizedBox(width: 20),
                  iconCreation(Icons.camera_alt, Colors.pink, 'Camera', () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => CameraScreen(
                                  onImageSend: () {},
                                  message: 'profile',
                                  id: '3',
                                )));
                  }),
                ],
              ),
            ],
          ),
        ),
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

  Widget iconCreation(IconData icon, Color color, String text, onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
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
            style: const TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}

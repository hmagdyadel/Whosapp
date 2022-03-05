import 'dart:convert';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whosapp/customUI/own_file_card.dart';
import 'package:whosapp/customUI/own_message_cart.dart';
import 'package:whosapp/customUI/reply_message_card.dart';
import 'package:whosapp/model/message_model.dart';
import 'package:whosapp/model/utility.dart';
import 'package:whosapp/screens/camera_screen.dart';
import 'package:whosapp/screens/camera_view.dart';
import '../model/chat_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:http/http.dart' as http;

class IndividualPage extends StatefulWidget {
  const IndividualPage({Key? key, this.chatModel}) : super(key: key);
  final ChatModel? chatModel;

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  getID() async {
    id = await Utility.getDetails('id');
  }

  String? id;
  bool show = false;
  FocusNode focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  io.Socket? socket;
  bool sendButton = false;
  List<MessageModel> messages = [];
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  XFile? file;
  int popTime = 0;

  @override
  void initState() {
    getID();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
    connect();
    super.initState();
  }

  void connect() {
    socket = io.io("http://192.168.8.130:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket!.connect();
    socket!.emit("signIn", id);
    socket!.onConnect((data) {
      socket!.on("message", (msg) {
        setMessage("destination", msg["message"], msg["path"]);
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
  }

  void sendMessage(String message, String sourceId, int targetId, String path) {
    setMessage("source", message, path);
    socket!.emit("message", {
      "message": message,
      "sourceId": sourceId,
      "targetId": targetId,
      "path": path,
    });
  }

  void setMessage(String type, String message, String path) {
    MessageModel messageModel = MessageModel(
        type: type,
        message: message,
        time: DateTime.now().toString().substring(10, 16),
        path: path);
    setState(() {
      messages.add(messageModel);
    });
  }

  void onImageSend(String path, String message) async {
    for (int i = 0; i < popTime; i++) {
      Navigator.pop(context);
    }
    setState(() {
      popTime = 0;
    });
    var request = http.MultipartRequest(
        "POST", Uri.parse("http://192.168.8.130:5000/routes/addImage"));
    request.files.add(await http.MultipartFile.fromPath('img', path));
    request.headers.addAll({"Content-type": "multipart/form-data"});
    http.StreamedResponse response = await request.send();
    var httpResponse = await http.Response.fromStream(response);
    var data = json.decode(httpResponse.body);
    setMessage("Source", message, path);
    socket!.emit("message", {
      "message": message,
      "sourceId": id,
      "targetId": widget.chatModel!.id,
      "path": data['path'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/icons/whatsapp_Back.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              titleSpacing: 0,
              backgroundColor: const Color(0xFF075E54),
              leadingWidth: 70,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                    CircleAvatar(
                      child: SvgPicture.asset(
                        widget.chatModel!.isGroup
                            ? 'assets/icons/groups.svg'
                            : 'assets/icons/person.svg',
                        color: Colors.white,
                        height: 32,
                        width: 32,
                      ),
                      radius: 20,
                      backgroundColor: Colors.blueGrey,
                    )
                  ],
                ),
              ),
              title: InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chatModel!.name.toString(),
                        style: const TextStyle(
                          fontSize: 18.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Last Seen today at 11:13 AM',
                        style: TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.videocam),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.call),
                  onPressed: () {},
                ),
                PopupMenuButton(
                  onSelected: (value) {},
                  itemBuilder: (context) {
                    return const [
                      PopupMenuItem(
                        child: Text('View Context'),
                        value: 'View Context',
                      ),
                      PopupMenuItem(
                        child: Text('Media, links, and docs'),
                        value: 'Media, links, and docs',
                      ),
                      PopupMenuItem(
                        child: Text('Search'),
                        value: 'Search',
                      ),
                      PopupMenuItem(
                        child: Text('Mute notifications'),
                        value: 'Mute notifications',
                      ),
                      PopupMenuItem(
                        child: Text('Wallpaper'),
                        value: 'Wallpaper',
                      ),
                    ];
                  },
                )
              ],
            ),
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              onWillPop: () {
                if (show) {
                  setState(() {
                    show = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
              child: Column(
                children: [
                  Expanded(
                    // height: MediaQuery.of(context).size.height - 150,
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return Container(height: 70);
                        }
                        if (messages[index].path != "") {
                          if (messages[index].type != "source") {
                            return OwnFileCard(
                              path: messages[index].path,
                              message: messages[index].message,
                              time: messages[index].time,
                            );
                          } else {
                            return ReplyMessageCard(
                              message: messages[index].message,
                              time: messages[index].time,
                            );
                          }
                        } else {
                          return OwnMessageCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        }
                        // if (messages[index].type == "source") {
                        //   if (messages[index].path!="") {
                        //     return OwnFileCard(
                        //       path: messages[index].path,
                        //       message:messages[index].message,
                        //       time: messages[index].time,
                        //     );
                        //   } else {
                        //     return OwnMessageCard(
                        //       message: messages[index].message,
                        //       time: messages[index].time,
                        //     );
                        //   }
                        // } else {
                        //   return ReplyMessageCard(
                        //     message: messages[index].message,
                        //     time: messages[index].time,
                        //   );
                        // }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 60,
                                child: Card(
                                  margin: const EdgeInsets.only(
                                      left: 2, right: 2, bottom: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: TextFormField(
                                    controller: _controller,
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    focusNode: focusNode,
                                    maxLines: 5,
                                    minLines: 1,
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        setState(() {
                                          sendButton = true;
                                        });
                                      } else {
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Type a message',
                                        prefixIcon: IconButton(
                                            onPressed: () {
                                              focusNode.unfocus();
                                              focusNode.canRequestFocus = false;
                                              setState(() {
                                                show = !show;
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.emoji_emotions,
                                              color: Color(0xFF075E54),
                                            )),
                                        suffixIcon: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                showModalBottomSheet(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    context: context,
                                                    builder: (builder) =>
                                                        bottomSheet());
                                              },
                                              icon: const Icon(
                                                Icons.attach_file,
                                                color: Color(0xFF075E54),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  popTime = 2;
                                                });
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (builder) =>
                                                        CameraScreen(
                                                      onImageSend: onImageSend,
                                                      id: '3',
                                                    ),
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.camera_alt,
                                                color: Color(0xFF075E54),
                                              ),
                                            ),
                                          ],
                                        ),
                                        contentPadding:
                                            const EdgeInsets.all(5)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8.0, right: 5, left: 2),
                                child: CircleAvatar(
                                  backgroundColor: const Color(0xFF075E54),
                                  radius: 25,
                                  child: IconButton(
                                    icon: Icon(
                                      sendButton ? Icons.send : Icons.mic,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      if (sendButton) {
                                        _scrollController.animateTo(
                                          _scrollController
                                              .position.maxScrollExtent,
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeOut,
                                        );
                                        sendMessage(
                                          _controller.text,
                                          id!,
                                          widget.chatModel!.id!,
                                          "",
                                        );
                                        _controller.clear();
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          show ? emojiSelect() : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget emojiSelect() {
    return EmojiPicker(
        rows: 4,
        columns: 7,
        onEmojiSelected: (emoji, category) {
          setState(() {
            _controller.text = _controller.text + emoji.emoji;
          });
        });
  }

  Widget bottomSheet() {
    return SizedBox(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  iconCreation(Icons.insert_drive_file, Colors.indigo,
                      'Document', () {}),
                  iconCreation(Icons.camera_alt, Colors.pink, 'Camera', () {
                    setState(() {
                      popTime = 3;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => CameraScreen(
                          onImageSend: onImageSend,
                          id: '3',
                        ),
                      ),
                    );
                  }),
                  iconCreation(Icons.insert_photo, Colors.purple, 'Gallery',
                      () async {
                    setState(() {
                      popTime = 2;
                    });
                    file = await _picker.pickImage(source: ImageSource.gallery);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => CameraViewPage(
                          path: file!.path,
                          onImageSend: onImageSend,
                        ),
                      ),
                    );

                    //   print(imageFile.toString());
                  }),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  iconCreation(Icons.headset, Colors.orange, 'Audio', () {}),
                  iconCreation(
                      Icons.location_pin, Colors.teal, 'Location', () {}),
                  iconCreation(Icons.person, Colors.blue, 'Contact', () {}),
                ],
              ),
            ],
          ),
        ),
      ),
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
              size: 29,
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

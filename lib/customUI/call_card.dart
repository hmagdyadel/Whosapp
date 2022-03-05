import 'package:flutter/material.dart';

class Calls extends StatelessWidget {
  const Calls({
    Key? key,
    this.name,
    this.time,
    this.imageName,
    required this.whoCall,
    required this.callOrVideo,
  }) : super(key: key);
  final String? name;
  final String? time;
  final String? imageName;
  final bool whoCall;
  final bool callOrVideo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 26,
        backgroundImage: AssetImage(imageName!),
      ),
      title: Text(
        name!,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      subtitle: Row(
        children: [
          whoCall
              ? const Icon(Icons.call_made, color: Colors.green, size: 17)
              : const Icon(Icons.call_received, color: Colors.red, size: 17),
          const SizedBox(width: 5),
          Text(
            time!,
          ),
        ],
      ),
      trailing: callOrVideo
          ? const Icon(Icons.call, color: Colors.teal, size: 25)
          : const Icon(Icons.videocam, color: Colors.teal, size: 25),
    );
  }
}

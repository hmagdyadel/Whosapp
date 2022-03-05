import 'dart:io';

import 'package:flutter/material.dart';

class OwnFileCard extends StatelessWidget {
  const OwnFileCard({Key? key, this.path, this.message, this.time})
      : super(key: key);
  final String? path;
  final String? message;
  final String? time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Material(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Container(
            // height: message!.isNotEmpty
            //     ? MediaQuery.of(context).size.height / 2.4
            //     : MediaQuery.of(context).size.height / 2.85,
            width: MediaQuery.of(context).size.width / 1.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xFFdcf8c6),
            ),
            child: Card(
              elevation: 0,
              margin: const EdgeInsets.all(3),
              color: const Color(0xFFdcf8c6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.file(
                      File(path!),
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width / 1.8,
                      height: MediaQuery.of(context).size.height / 2.92,
                    ),
                  ),
                  message!.isNotEmpty
                      ? Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 60, top: 5, bottom: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  message!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 4,
                              right: 2,
                              child: Text(
                                time!,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                            )
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

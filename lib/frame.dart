import 'dart:io';
import 'package:clickframes/preview_remove.dart';
import 'package:flutter/material.dart';
import 'package:clickframes/global.dart';

class ClickedFrame extends StatelessWidget {
  const ClickedFrame({super.key, required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clicked Frame",),
        leading: IconButton(
            onPressed: () async {
              await Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context)=> PreviewScreen(camera: selectCamera,)
              )
              );
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Image.file(File(imagePath)),
    );
  }
}

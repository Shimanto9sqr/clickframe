import 'package:clickframes/preview_remove.dart';
import 'package:flutter/material.dart';
import 'package:clickframes/global.dart';
import 'package:camera/camera.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   cameras = await availableCameras();
   selectCamera = cameras.first;
  runApp(MaterialApp(
    theme: ThemeData.dark(),
    home: PreviewScreen(camera: selectCamera),
  )
  );

}




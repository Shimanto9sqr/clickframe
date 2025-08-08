import 'package:clickframes/frame.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({super.key, required this.camera});

  final CameraDescription camera;

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState(){
    super.initState();
    _controller= CameraController(
        widget.camera,
        ResolutionPreset.medium);

    _initializeControllerFuture = _controller.initialize();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Frame Preview"),),
      body: FutureBuilder(
          future: _initializeControllerFuture,
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              return CameraPreview(_controller);
            } else {
              return const Center(child: CircularProgressIndicator(),);
            }
          },
          ),
      floatingActionButton: FloatingActionButton(

          onPressed: () async {
            try {
              await _initializeControllerFuture;
              final image = await _controller.takePicture();
              _controller.stopImageStream();
              if(!context.mounted)return;
              await Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context)=> ClickedFrame(
                      imagePath: image.path)
              )
              );
            } catch(e){
              print(e);
            }
          },
        child: const Icon(Icons.camera_alt),
          ),
    );
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
}

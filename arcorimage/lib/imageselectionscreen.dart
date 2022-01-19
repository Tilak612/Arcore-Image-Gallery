import 'dart:io';
import 'package:arcorimage/3Dmodelload.dart';
import 'package:arcorimage/3dmodel.dart';
import 'package:arcorimage/home.dart';
import 'package:arcorimage/imag.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelectionScreen extends StatefulWidget {
  @override
  _ImageSelectionScreenState createState() => _ImageSelectionScreenState();
}

class _ImageSelectionScreenState extends State<ImageSelectionScreen> {
  PickedFile _imageFile;
  String _status;
  bool _imgLoading;
  File send_file;
  ImagePicker _imagePicker;
  @override
  void initState() {
    super.initState();
    _status = "";
    _imgLoading = false;
    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Image"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            // ignore: sdk_version_ui_as_code
            if (null == _imageFile)
              Container()
            else
              Expanded(
                child: Image.file(
                  File(_imageFile.path),
                  filterQuality: FilterQuality.high,
                ),
              ),
            SizedBox(
              height: 20,
            ),
            Text(_status),
            SizedBox(
              height: 20,
            ),
            _select(),
          ],
        ),
      ),
    );
  }

  _select() {
    return Container(
      padding: EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width,
      color: Colors.black12,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _button("Gallery", ImageSource.gallery),
            FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ImageObjectScreen(selectedModel:_imageFile),
                    ),
                  );
                },
                child: Text("Camera")),
                FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                        HomeScreen(),
                    ),
                  );
                },
                child: Text("Camera1")),
          ]),
    );
  }

  _button(String text, ImageSource imageSource) {
    return FlatButton(
        onPressed: () async {
          setState(() {
            _imgLoading = true;
            _imageFile = null;
          });
          PickedFile file = await _loadImage(imageSource);
          if (null != file) {
            setState(() {
              _imgLoading = false;
              _imageFile = file;
              send_file= File(_imageFile.path);
              _status = "loaded";
            });
            return;
          }
          setState(() {
            _imageFile = null;
            _imgLoading = false;
            _status = "error";
          });
        },
        child: Text(text));
  }

  Future<PickedFile> _loadImage(ImageSource imageSource) async {
    PickedFile file = await _imagePicker.getImage(source: ImageSource.gallery);
    if (null != file) {
      //
    }
    return file;
  }
}

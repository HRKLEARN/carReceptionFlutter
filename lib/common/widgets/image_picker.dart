import 'dart:async';
import 'dart:io';

import 'package:car_reception_flutter/src/reception/controller/reception_controller.dart';
import 'package:car_reception_flutter/src/reception/model/res_reception_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class ImagePickerWidget extends StatefulWidget {
   const ImagePickerWidget({Key? key, }) : super(key: key);

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  List<XFile>? _imageFileList;

  Map<int,XFile> images = {};

  dynamic _pickImageError;

  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();


  late Reception reception;

  final ReceptionController controller = Get.find<ReceptionController>();

  void _setImageFileListFromFile(XFile? value) {
    if (value != null) {
      _imageFileList?.addAll(<XFile>[value]);

    } else {
      _imageFileList = value == null ? null : <XFile>[value];
    }
  }

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false,}) async {
    if (isMultiImage) {
      try {
        final List<XFile> pickedFileList = await _picker.pickMultiImage();
        setState(() {
          if (_imageFileList == null) {
            _imageFileList = pickedFileList;
          } else {
            _imageFileList!.addAll(pickedFileList);
          }
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    }else{
      try {
        final XFile? pickedFile = (await _picker.pickImage(
          source: source,
        ));
        setState(() => _setImageFileListFromFile(pickedFile));
      } catch (e) {
        setState(() => _pickImageError = e);
      }
    }
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          key: UniqueKey(),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black54)),
              margin: const EdgeInsets.all(8),
              child: Stack(
                alignment: Alignment.topRight,
                fit: StackFit.loose,
                clipBehavior: Clip.hardEdge,
                children: [

                  Image.file(
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                    File(_imageFileList![index].path),
                    errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) =>
                        const Center(
                            child: Text('This image type is not supported')),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.highlight_remove,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _imageFileList!.removeAt(index);
                        images.removeWhere((key, value) => value == _imageFileList![index]);
                      });
                    },
                  ),
                ],
              ),
            );
          },
          itemCount: _imageFileList!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
        ),
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() async {
        if (response.files == null) {
          _setImageFileListFromFile(response.file);
        } else {
          for(int i=0;  i<= response.files!.length;i++ ){

            final encoded = await response.files![i].readAsBytes();
            debugPrint(encoded.toString());
            controller.createSignatureImage(data: encoded.toString());
            controller.attachImageToReception(
                id: reception.id_ordre!,
                signature: controller.result.value);
          }
          _imageFileList = response.files;
        }
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  @override
  void initState()  {
    reception = controller.currentReception.value;
    if (reception.image_signature != null && reception.image_signature!.isNotEmpty) {
      for (int id in reception.image_signature!) {
         controller.readSignatureImage( id: id);
      }
    }
    if(controller.images != null && controller.images!.isNotEmpty) {
      setState(() {
        if (_imageFileList == null) {
          _imageFileList = controller.images?.entries.cast<XFile>().toList();
        } else {
          _imageFileList!.addAll(
              controller.images!.entries.cast<XFile>().toList());
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: defaultTargetPlatform == TargetPlatform.android
          ? Center(
            child: FutureBuilder<void>(
                future: retrieveLostData(),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const Text(
                        'You have not yet picked an image.',
                        textAlign: TextAlign.center,
                      );
                    case ConnectionState.done:
                      return _previewImages();
                    case ConnectionState.active:
                      if (snapshot.hasError) {
                        return Text(
                          'Pick image error: ${snapshot.error}}',
                          textAlign: TextAlign.center,
                        );
                      } else {
                        return const Text(
                          'You have not yet picked an image.',
                          textAlign: TextAlign.center,
                        );
                      }
                  }
                },
              ),
          )
          : _previewImages(),
      floatingActionButton: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: FloatingActionButton(
                backgroundColor: Colors.red.withOpacity(0.9),
                onPressed: () {
                  _onImageButtonPressed(
                    ImageSource.gallery,
                    context: context,
                    isMultiImage: true,
                  );
                },
                heroTag: 'MultipleImage',
                tooltip: 'Pick Multiple Image from gallery',
                child: const Icon(Icons.photo_library),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: FloatingActionButton(
                backgroundColor: Colors.red.withOpacity(0.9),
                onPressed: () {
                  _onImageButtonPressed(ImageSource.camera, context: context);
                },
                heroTag: 'Camera',
                tooltip: 'Take a Photo',
                child: const Icon(Icons.camera_alt),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
}

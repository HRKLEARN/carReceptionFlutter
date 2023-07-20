import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:car_reception_flutter/src/reception/controller/reception_controller.dart';
import 'package:car_reception_flutter/src/reception/model/res_reception_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignaturePadWidget extends StatefulWidget {
  final Reception reception;

  const SignaturePadWidget({Key? key, required this.reception})
      : super(key: key);

  @override
  State<SignaturePadWidget> createState() => _SignaturePadWidgetState();
}

class _SignaturePadWidgetState extends State<SignaturePadWidget> {
  var color = Colors.black;
  var strokeWidth = 3.0;
  final _sign = GlobalKey<SignatureState>();
  final ReceptionController controller = Get.find<ReceptionController>();





  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: GetX<ReceptionController>(
        init: ReceptionController(),
        builder: (_) => Column(
          children: [
            Text("${controller.result.value}"),
            Text("List of images signature : ${controller.currentReception.value.image_signature}"),
            AspectRatio(
              aspectRatio: 1.2,
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Signature(
                  color: color,
                  key: _sign,
                  onSign: () {
                    //final sign = _sign.currentState;
                    /*debugPrint(
                            '${sign!.points.length} points in the signature');*/
                  },
                  strokeWidth: strokeWidth,
                ),
              ),
            ),
            controller.img.value.buffer.lengthInBytes == 0
                ? Container()
                : LimitedBox(
                    maxHeight: 200.0,
                    child: Image.memory(controller.img.value.buffer.asUint8List())),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () async {
                    final sign = _sign.currentState;
                    //retrieve image data, do whatever you want with it (send to server, save locally...)
                    final image = await sign!.getData();
                    ByteData? data =
                        await image.toByteData(format: ui.ImageByteFormat.png);
                    final encoded = base64.encode(data!.buffer.asUint8List());
                    await controller.createSignatureImage(data: encoded);
                    debugPrint("onPressed $encoded");
                    debugPrint(controller.currentReception.value.image_signature.toString());

                    controller.attachImageToReception(
                        id: controller.currentReception.value.id_ordre!,
                        signature: controller.result.value);
                   /* if(controller.currentReception.value.image_signature!.isNotEmpty ){
                    }*/
                    controller.readSignatureImage(id:controller.result.value);
                    sign.clear();

                    controller.img.value = data;
                  },
                  child: Text(
                    "Save",
                    style: GoogleFonts.roboto(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(color: Colors.black, width: 2)),
                    color: Colors.white,
                    onPressed: () {
                      final sign = _sign.currentState;
                      sign!.clear();
                        controller.img.value = ByteData(0);
                      debugPrint("cleared");
                    },
                    child: Text(
                      "Clear",
                      style: GoogleFonts.roboto(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

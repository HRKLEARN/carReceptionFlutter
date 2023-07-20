import 'dart:convert';

import 'package:car_reception_flutter/common/config/prefs/pref_utils.dart';
import 'package:car_reception_flutter/src/reception/view/reception_details.dart';
import 'package:car_reception_flutter/src/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ReceptionScreen extends StatefulWidget {
  const ReceptionScreen({Key? key}) : super(key: key);

  @override
  State<ReceptionScreen> createState() => _ReceptionScreenState();
}

class _ReceptionScreenState extends State<ReceptionScreen> {
  final _receptionsController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    _receptionsController.getOrdres();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red,
        title: Text(
          "Receptions",
          style: GoogleFonts.roboto(
              color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(
        () {
          return ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemCount: _receptionsController.listOfOrdres.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              final  reception = _receptionsController.listOfOrdres[index];
              return Card(
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Num Matricule : ",
                        style: GoogleFonts.roboto(
                            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 3.2,
                        child: Text(
                          reception.num_serie!.toString(),
                          style: GoogleFonts.notoSansMath(
                              fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
                        ),
                      ),
                    ],
                  ) ,
                  subtitle:Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Client: ",
                        style: GoogleFonts.roboto(
                            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: Text(
                          reception.nom_client!,
                          style: GoogleFonts.notoSansMath(
                              fontWeight: FontWeight.bold, fontSize: 15,color: Colors.black87 ),
                          overflow: TextOverflow.fade,
                          softWrap: true,

                        ),
                      ),
                    ],
                  ) ,
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    onPressed: () {
                      final receptionData = reception;
                      PrefUtils.setReception(jsonEncode(receptionData));
                      Get.to(() => const ReceptionDetails(), arguments: receptionData);
                    },
                    child: const Text('Update'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }


}

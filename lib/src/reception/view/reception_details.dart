import 'package:car_reception_flutter/common/config/prefs/pref_utils.dart';
import 'package:car_reception_flutter/common/widgets/image_picker.dart';
import 'package:car_reception_flutter/common/widgets/list_checkbox_tile.dart';
import 'package:car_reception_flutter/common/widgets/signature_pad.dart';
import 'package:car_reception_flutter/src/reception/controller/reception_controller.dart';
import 'package:car_reception_flutter/src/reception/model/res_reception_model.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReceptionDetails extends StatefulWidget {
  const ReceptionDetails({super.key});

  @override
  State<ReceptionDetails> createState() => _ReceptionDetailsState();
}

class _ReceptionDetailsState extends State<ReceptionDetails> {
  final reception = Get.arguments as Reception;

  int activeStep = 0;
  late TextEditingController _distanceController;
  late TextEditingController _diagnosticController;
  final ReceptionController _receptionController =
      Get.find<ReceptionController>();

  @override
  void initState() {
    super.initState();
    _distanceController = TextEditingController(text: reception.compteur ?? "");
    _diagnosticController =
        TextEditingController(text: reception.diagnostic_description ?? "");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.red,
        title: Text(
          "Reception details",
          style: GoogleFonts.roboto(
              color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Card(
            color: Colors.grey.shade50,
            elevation: 2,
            child: EasyStepper(
              activeStep: activeStep,
              lineLength: 30,
              defaultStepBorderType: BorderType.normal,
              activeStepBorderColor: Colors.red,
              showLoadingAnimation: false,
              activeStepIconColor: Colors.red,
              activeStepTextColor: Colors.red,
              finishedStepBackgroundColor: Colors.red,
              lineSpace: 1,
              lineType: LineType.normal,
              finishedLineColor: Colors.red,
              finishedStepTextColor: Colors.red,
              unreachedLineColor: Colors.grey,
              unreachedStepBorderColor: Colors.grey,
              unreachedStepIconColor: Colors.grey,
              unreachedStepTextColor: Colors.grey,
              defaultLineColor: Colors.grey,
              borderThickness: 4,
              internalPadding: 10,
              padding: const EdgeInsetsDirectional.only(
                  top: 25, start: 10, end: 10, bottom: 10),
              steps: [
                EasyStep(
                  icon: const Icon(Icons.speed),
                  customTitle: Text(
                    'Compteur',
                    style: GoogleFonts.roboto(
                        fontWeight: activeStep == 0
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: activeStep >= 0 ? Colors.red : Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
                EasyStep(
                  icon: const Icon(Icons.checklist_sharp),
                  customTitle: Text(
                    "Equipements",
                    style: GoogleFonts.roboto(
                        fontWeight: activeStep == 1
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: activeStep >= 1 ? Colors.red : Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
                EasyStep(
                  icon: const Icon(Icons.taxi_alert),
                  customTitle: Text(
                    "Diagnostics",
                    style: GoogleFonts.roboto(
                        fontWeight: activeStep == 2
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: activeStep >= 2 ? Colors.red : Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
                EasyStep(
                  icon: const Icon(Icons.insert_photo_sharp),
                  customTitle: Text(
                    "Images",
                    style: GoogleFonts.roboto(
                        fontWeight: activeStep == 3
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: activeStep >= 3 ? Colors.red : Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
                EasyStep(
                  icon: const Icon(Icons.fingerprint),
                  customTitle: Text(
                    "signature",
                    style: GoogleFonts.roboto(
                        fontWeight: activeStep == 4
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: activeStep >= 4 ? Colors.red : Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
                EasyStep(
                  icon: const Icon(Icons.check),
                  customTitle: Text(
                    'Valider',
                    style: GoogleFonts.roboto(
                        fontWeight: activeStep == 5
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: activeStep >= 5 ? Colors.red : Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              onStepReached: (index) => setState(() => activeStep = index),
            ),
          ),
          activeStep == 0
              ? Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        color: Colors.white,
                        child: TextFormField(
                          controller: _distanceController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            suffix: Text(
                              'Km/h',
                              style: GoogleFonts.roboto(color: Colors.black54),
                            ),
                            label: const Text('Compteur kilométrique'),
                            labelStyle: const TextStyle(color: Colors.black54),
                            hintText: 'distance en kilometre par heure',
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                color: Colors.black54,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ),
                )
              : activeStep == 1
                  ? Expanded(
                      child: ListCheckBoxWidget(reception: reception),
                    )
                  : activeStep == 2
                      ? Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              color: Colors.white,
                              child: TextFormField(
                                controller: _diagnosticController,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  label: Text('Diagnostic description'),
                                  labelStyle: TextStyle(color: Colors.black54),
                                  hintText: 'Diagnostic description',
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(
                                      color: Colors.black54,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.multiline,
                                maxLines: 6,
                              ),
                            ),
                          ),
                        )
                      : activeStep == 3
                          ?  const Expanded(child: ImagePickerWidget())
                          : activeStep == 4
                              ? Expanded(
                                  child: SignaturePadWidget(
                                  reception: reception,
                                ))
                              : Expanded(child: Container()),
          Container(
            color: Colors.grey.shade50,
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() {
                    if (activeStep != 0) {
                      activeStep--;
                    }
                  }),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.roboto(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () => setState(() async{
                    if (activeStep < 5) {
                      activeStep++;
                    }
                    if (activeStep == 5) {
                      // NB: cette comentaire on va modifier apres l'appel updateReception on a ajoutant un dialog de confirmation
                     /* Reception receptiontest = Reception(
                        id_ordre: 4659,
                        compteur: "272984",
                        allume_cigares: "oui",
                        cles: "oui",
                        cric: "oui",
                        diagnostic_description:
                        "VIDANGE ET FILTRES\nFIXATION PAR A CHOC AV ET AR",
                        nom_client: "ATTT",
                        num_serie: "15-346118",
                        radio_cassette: "oui",
                        roue_secours: "oui",
                        image_signature: [2072],
                      );
                      _receptionController.updateReception(receptiontest);*/

                      _receptionController.updateReception(_receptionController.currentReception.value);

                    }
                  }),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Text(
                    activeStep != 5 ? "Next" : "Save",
                    style: GoogleFonts.roboto(color: Colors.white),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );


  }



}

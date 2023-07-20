import 'package:car_reception_flutter/src/reception/controller/reception_controller.dart';
import 'package:car_reception_flutter/src/reception/model/res_reception_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListCheckBoxWidget extends StatefulWidget {
  final Reception reception;

  const ListCheckBoxWidget({Key? key, required this.reception})
      : super(key: key);

  @override
  State<ListCheckBoxWidget> createState() => _ListCheckBoxWidgetState();
}

class _ListCheckBoxWidgetState extends State<ListCheckBoxWidget> {
  late Map<String, bool> checkBoxList;
  late List<String> checkBoxListTitle;
  late List<bool> checkBoxListValue;
  final ReceptionController receptionController = Get.find<ReceptionController>();
  @override
  void initState() {
    super.initState();
    checkBoxList = {

      "roue secours": receptionController.currentReception.value.roue_secours != null
          ? receptionController.currentReception.value.roue_secours == "oui"
              ? true
              : false
          : false,
      "cric": receptionController.currentReception.value.cric != null
          ? receptionController.currentReception.value.cric == "oui"
          ? true
          : false
          : false,
      "allume cigares": receptionController.currentReception.value.allume_cigares != null
          ? receptionController.currentReception.value.allume_cigares == "oui"
          ? true
          : false
          : false,
      "radio cassette": receptionController.currentReception.value.radio_cassette != null
          ? receptionController.currentReception.value.radio_cassette == "oui"
          ? true
          : false
          : false,
      "cles": receptionController.currentReception.value.cles != null
          ? receptionController.currentReception.value.cles == "oui"
          ? true
          : false
          : false,
    };
    checkBoxListTitle = checkBoxList.entries.map((e) => e.key).toList();
    checkBoxListValue = checkBoxList.entries.map((e) => e.value).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: checkBoxList.length,
        itemBuilder: (context, index) => CheckboxListTile(
          value: checkBoxListValue[index],
          onChanged: (value) {
            setState(() {
              final key = checkBoxList.keys.elementAt(index);
              checkBoxList[key] = value!;
              checkBoxListValue[index] = value;
              receptionController.currentReception.value.roue_secours = checkBoxList["roue secours"] == true ? "oui" : "non";
              receptionController.currentReception.value.cric = checkBoxList["cric"] == true ? "oui" : "non";
              receptionController.currentReception.value.allume_cigares = checkBoxList["allume cigares"] == true ? "oui" : "non";
              receptionController.currentReception.value.radio_cassette = checkBoxList["radio cassette"] == true ? "oui" : "non";
              receptionController.currentReception.value.cles = checkBoxList["cles"] == true ? "oui" : "non";
            });
          },
          title: Text(checkBoxListTitle[index]),
          controlAffinity: ListTileControlAffinity.platform,
        ),
      ),
    );
  }
}

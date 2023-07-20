import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_reception_flutter/common/utils/utils.dart';
import 'package:car_reception_flutter/common/widgets/main_container.dart';
import 'package:car_reception_flutter/src/reception/controller/reception_controller.dart';

class Receptions extends StatefulWidget {
  const Receptions({super.key});

  @override
  State<Receptions> createState() => _ReceptionsState();
}

class _ReceptionsState extends State<Receptions> {
  final _receptionsController = Get.put(ReceptionController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      isAppBar: true,
      appBarTitle: "Receptions",
      padding: 20.0,
      actions: [
        IconButton(
          onPressed: () {
            showLogoutDialog();
          },
          icon: const Icon(Icons.exit_to_app),
        )
      ],
      child: Obx(
            () {
          return ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: _receptionsController.listOfReceptions.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child:
                    _receptionsController.listOfReceptions[index].id_ordre != null
                        ? Text(
                      "${_receptionsController.listOfReceptions[index].id_ordre!}",
                    )
                        : const Text(
                      "empty",
                    )
                ),
                title: Text(_receptionsController.listOfReceptions[index].radio_cassette!),
                subtitle: Text(_receptionsController.listOfReceptions[index].diagnostic_description!),
              );
            },
          );
        },
      ),
    );
  }
}

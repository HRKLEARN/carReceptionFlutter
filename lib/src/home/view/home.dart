import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_reception_flutter/common/utils/utils.dart';
import 'package:car_reception_flutter/common/widgets/main_container.dart';
import 'package:car_reception_flutter/src/home/controller/home_controller.dart';
import 'package:car_reception_flutter/src/reception/view/receptions.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    _homeController.getOrdres();
  }

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      isAppBar: true,
      appBarTitle: "Home",
      padding: 20.0,
      actions: [
        IconButton(
          onPressed: () => Get.to(const Receptions()),
          icon: const Icon(
            Icons.list_alt_outlined,
          ),
        ),
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
            itemCount: _homeController.listOfOrdres.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: _homeController.listOfOrdres[index].id_ordre != null
                        ? Text(
                            "${_homeController.listOfOrdres[index].id_ordre!}",
                          )
                        : const Text(
                            "nom client is empty",
                          )),
                title: Text(_homeController.listOfOrdres[index].num_serie!),
                subtitle: Text(_homeController
                    .listOfOrdres[index].diagnostic_description!),
              );
            },
          );
        },
      ),
    );
  }
}

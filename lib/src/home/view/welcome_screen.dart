import 'package:car_reception_flutter/common/utils/utils.dart';
import 'package:car_reception_flutter/src/reception/view/reception_screen.dart';
import 'package:car_reception_flutter/src/reception/view/reparation_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final SnackBar _snackBar =  SnackBar(
    clipBehavior: Clip.hardEdge,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.white,
    closeIconColor: Colors.black,
    showCloseIcon: true,
    elevation: 5,
    shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.black)),
    content: Text('This feature will be soon active', style: GoogleFonts.roboto(color: Colors.black),),

    duration: const Duration(seconds: 3),
  );
  List<String> services = ["Receptions", "Reparations", "Dark Mode", "SignOut"];

  List<String> images = [
    "assets/images/car-repair.png",
    "assets/images/maintenance.png",
    "assets/images/dark-mode.png",
    "assets/images/signout.png",
  ];

  void _navigationList(int index) {
      switch (index) {
        case 0:
          Get.to(() => const ReceptionScreen());
        case 1:
          Get.to(() => const ReparationScreen());
        case 2:
          ScaffoldMessenger.of(context).showSnackBar(_snackBar);
         // Navigator.pushNamed(context, );
        case 3:
          showLogoutDialog();
      }
    }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(
            "Poly Garage",
            style: GoogleFonts.roboto(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: OrientationBuilder(
            builder: (context, orientation) { return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: services.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    crossAxisCount:  orientation == Orientation.portrait ? 2 : 4,
                    childAspectRatio: orientation == Orientation.portrait ? MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 2) : MediaQuery.of(context).size.height /
                        (MediaQuery.of(context).size.width /2.5) ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _navigationList(index),
                    child: Card(
                      shadowColor: Colors.black,
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      elevation: 10,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Image.asset(
                            images[index],
                            height: 50,
                            width: 50,
                          ),
                          const Padding(padding: EdgeInsets.all(15)),
                          Text(
                            services[index],
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );}
          ),
        ),
      ),
    );
  }
}

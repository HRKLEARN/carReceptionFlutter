import 'package:car_reception_flutter/models/reparation.dart';
import 'package:car_reception_flutter/common/widgets/reparation_list_expanded.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReparationScreen extends StatefulWidget {
  const ReparationScreen({Key? key}) : super(key: key);

  @override
  State<ReparationScreen> createState() => _ReparationScreenState();
}

class _ReparationScreenState extends State<ReparationScreen> {
  List<Reparation> reparations = [
    Reparation(
      registerNumber: "9080 Tunis 55",
      clientName: "Mohamed Souissi",
      isExpanded: false,
    ),
    Reparation(
      registerNumber: "4215 Tunis 55",
      clientName: "Ahmed Souissi",
      customerIntervention: "car repaired one time",
      isExpanded: false,
    ),
    Reparation(
      registerNumber: "888 Tunis 88",
      clientName: "Oussama Ben Feyza",
      customerIntervention: "car repaired one time",
      isExpanded: false,
      reparations: ["intervention client ","intervention tech ","intervention tech ",]
    )
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 5,
        backgroundColor: Colors.red,
        title: Text(
          "Reparation Page",
          style: GoogleFonts.roboto(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: ReparationListExpanded(reparations: reparations),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

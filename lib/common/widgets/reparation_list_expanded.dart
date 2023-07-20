import 'package:car_reception_flutter/models/reparation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReparationListExpanded extends StatefulWidget {
  const ReparationListExpanded({
    super.key,
    required this.reparations,
  });

  final List<Reparation> reparations;

  @override
  State<ReparationListExpanded> createState() => _ReparationListExpandedState();
}

class _ReparationListExpandedState extends State<ReparationListExpanded> {
  @override
  Widget build(BuildContext context) {
    var reparations = widget.reparations;

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      itemCount: reparations.length,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 10,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        var interventions = reparations[index].reparations;
        return Card(
          color: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Register Number : ",
                        style: GoogleFonts.roboto(
                            color: Colors.red, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        reparations[index].registerNumber,
                        style: GoogleFonts.notoSansMath(
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Client Name : ",
                        style: GoogleFonts.roboto(
                            color: Colors.red, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        reparations[index].clientName,
                        style: GoogleFonts.roboto(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text('Update'),
                  ),
                ),
                interventions != null || reparations[index].customerIntervention != null ?
                ExpansionTile(
                    title: Text(
                      "List of interventions",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    iconColor: Colors.red,
                    initiallyExpanded: reparations[index].isExpanded,
                    childrenPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    expandedAlignment: Alignment.centerLeft,

                    children: [
                      reparations[index].customerIntervention != null ?Text(
                        " Intervention client :",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                        ),
                      ) : Container(),
                      const SizedBox(
                        height: 8,
                      ),
                      reparations[index].customerIntervention != null
                          ? Text(
                              " - ${reparations[index].customerIntervention} ")
                          : Container(),
                      const SizedBox(
                        height: 8,
                      ),
                      interventions != null
                          ? Text(
                              "Interventions Technicians : ",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold),
                            )
                          : Container(),
                      const SizedBox(
                        height: 8,
                      ),
                      ...interventions != null
                          ? interventions.map<Container>((String item) {
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: Text(" - $item"),
                              );
                            }).toList()
                          : List.empty(),
                    ]) : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}

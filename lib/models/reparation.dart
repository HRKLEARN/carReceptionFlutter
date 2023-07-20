class Reparation {
  String registerNumber;
  String clientName;
  String? customerIntervention;
  List<String>? reparations;
  bool isExpanded = false;


  Reparation({
    required this.registerNumber,
    required this.clientName,
    this.customerIntervention,
    this.reparations,
    required this.isExpanded,
  });

  Map<String, dynamic> toMap() {
    return {
      'registerName': registerNumber,
      'clientName': clientName,
      'customerIntervention': customerIntervention,
      'reparations': reparations,
    };
  }

  factory Reparation.fromMap(Map<String, dynamic> map) {
    return Reparation(
      registerNumber: map['registerName'] as String,
      clientName: map['clientName'] as String,
      customerIntervention: map['customerIntervention'] as String,
      reparations: map['reparations'] as List<String>,
      isExpanded: map['isExpanded'] as bool,
    );
  }

}
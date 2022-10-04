class PharmacyViewModel {
  final int id;
  final String name;
  final String address;
  final String doctorName;
  final String dateOfEstablishment;
  final String? base64Image;

  PharmacyViewModel({
    required this.id,
    required this.name,
    required this.address,
    required this.doctorName,
    required this.dateOfEstablishment,
    required this.base64Image,
  });

  factory PharmacyViewModel.fromJson(final Map<String, dynamic> json) {
    return PharmacyViewModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      doctorName: json['doctorName'],
      dateOfEstablishment: json['dateOfEstablishment'],
      base64Image: json['base64Image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'doctorName': doctorName,
      'dateOfEstablishment': dateOfEstablishment,
      'base64Image': base64Image,
    };
  }
}

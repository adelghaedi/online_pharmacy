import '../../shared/models/drug_pharmacy_view_model.dart';

class PharmacyUpdateDto {
  final String name;
  final String address;
  final String doctorName;
  final String dateOfEstablishment;
  final String? base64Image;
  final List<DrugPharmacyViewModel> drugs;

  PharmacyUpdateDto({
    required this.name,
    required this.address,
    required this.doctorName,
    required this.dateOfEstablishment,
    this.base64Image,
    required this.drugs,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'doctorName': doctorName,
      'dateOfEstablishment': dateOfEstablishment,
      'base64Image': base64Image,
      'drugs': drugs.map((drugPharmacy) => drugPharmacy.toJson()).toList(),
    };
  }
}

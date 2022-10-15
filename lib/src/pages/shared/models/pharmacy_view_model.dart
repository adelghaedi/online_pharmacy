import 'pharmacy_drug_view_model.dart';
import 'drug_view_model.dart';

class PharmacyViewModel {
  final int id;
  final String name;
  final String address;
  final String doctorName;
  final String dateOfEstablishment;
  final String? base64Image;
  final List<PharmacyDrugViewModel> drugs;

  PharmacyViewModel({
    required this.id,
    required this.name,
    required this.address,
    required this.doctorName,
    required this.dateOfEstablishment,
    required this.base64Image,
    required this.drugs,
  });

  factory PharmacyViewModel.fromJson(final Map<String, dynamic> json) {
    return PharmacyViewModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      doctorName: json['doctorName'],
      dateOfEstablishment: json['dateOfEstablishment'],
      base64Image: json['base64Image'],
      drugs: (json['drugs'] as List)
          .map(
            (json) => PharmacyDrugViewModel(
                drug: DrugViewModel.fromJson(json['drug']),
                price: json['price'],
                showPharmacyDrug: json['showPharmacyDrug']),
          )
          .toList(),
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
      'drugs': drugs
          .map(
            (drug) => drug.toJson(),
          )
          .toList(),
    };
  }
}

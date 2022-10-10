import '../../shared/models/drug_pharmacy_view_model.dart';

class PharmacyDrugsUpdateDto {
  final List<DrugPharmacyViewModel> drugs;

  PharmacyDrugsUpdateDto({required this.drugs});

  Map<String, dynamic> toJson() {
    return {
      'drugs': drugs.map((drugPharmacy) => drugPharmacy.toJson()).toList(),
    };
  }
}

import '../../shared/models/pharmacy_drug_view_model.dart';

class PharmacyDrugsUpdateDto {
  final List<PharmacyDrugViewModel> drugs;

  PharmacyDrugsUpdateDto({required this.drugs});

  Map<String, dynamic> toJson() {
    return {
      'drugs': drugs.map((pharmacyDrug) => pharmacyDrug.toJson()).toList(),
    };
  }
}

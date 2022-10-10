import 'drug_view_model.dart';

class DrugPharmacyViewModel {
  final DrugViewModel drug;
  final String price;
  bool showDrugPharmacy;

  DrugPharmacyViewModel({
    required this.drug,
    required this.price,
    this.showDrugPharmacy = true,
  });

  factory DrugPharmacyViewModel.fromJson(final Map<String, dynamic> json) {
    return DrugPharmacyViewModel(
      drug: DrugViewModel.fromJson(json['drug']),
      price: json['price'],
      showDrugPharmacy: json['showDrugPharmacy']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'drug': drug.toJson(),
      'price': price,
      'showDrugPharmacy':showDrugPharmacy
    };
  }
}

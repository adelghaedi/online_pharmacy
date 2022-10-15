import 'drug_view_model.dart';

class PharmacyDrugViewModel {
  final DrugViewModel drug;
  final String price;
  bool showPharmacyDrug;

  PharmacyDrugViewModel({
    required this.drug,
    required this.price,
    required this.showPharmacyDrug,
  });

  factory PharmacyDrugViewModel.fromJson(final Map<String, dynamic> json) {
    return PharmacyDrugViewModel(
        drug: DrugViewModel.fromJson(json['drug']),
        price: json['price'],
        showPharmacyDrug: json['showPharmacyDrug']);
  }

  Map<String, dynamic> toJson() {
    return {
      'drug': drug.toJson(),
      'price': price,
      'showPharmacyDrug': showPharmacyDrug
    };
  }
}

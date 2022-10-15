import 'pharmacy_drug_view_model.dart';

class UserDrugViewModel {
  final PharmacyDrugViewModel pharmacyDrug;
  final int pharmacyId;
  int count;

  UserDrugViewModel({
    required this.pharmacyDrug,
    required this.pharmacyId,
    required this.count,
  });

  factory UserDrugViewModel.fromJson(final Map<String, dynamic> json) {
    return UserDrugViewModel(
      pharmacyDrug: PharmacyDrugViewModel.fromJson(json['pharmacyDrug']),
      pharmacyId: json['pharmacyId'],
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pharmacyDrug': pharmacyDrug.toJson(),
      'pharmacyId': pharmacyId,
      'count': count,
    };
  }
}

import 'user_drug_view_model.dart';

class UserDrugsUpdateDto {
  final List<UserDrugViewModel> drugsUser;

  UserDrugsUpdateDto({required this.drugsUser});

  Map<String, dynamic> toJson() {
    return {'drugs': drugsUser.map((drugUser) => drugUser.toJson()).toList()};
  }
}

import 'package:get/get.dart';

import 'user_drug_view_model.dart';

class UserProfileModel {
  final int id;
  final String firstName;
  final String mobile;
  final String? base64Image;
  List<UserDrugViewModel> drugs;

  UserProfileModel({
    required this.id,
    required this.firstName,
    required this.mobile,
    required this.base64Image,
    required this.drugs,
  });
}

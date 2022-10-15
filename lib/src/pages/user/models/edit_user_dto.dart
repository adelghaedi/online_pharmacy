import '../../shared/models/user_drug_view_model.dart';

class EditUserDto {
  final String firstName, lastName, mobile, birthDate, userName;
  final bool isAdmin;
  final String? base64Image;
  final List<UserDrugViewModel> drugs;

  EditUserDto({
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.birthDate,
    required this.userName,
    required this.isAdmin,
    this.base64Image,
    required this.drugs,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'birthDate': birthDate,
      'userName': userName,
      'isAdmin': isAdmin,
      'base64Image': base64Image,
      'drugs': drugs.map((drug) => drug.toJson()).toList(),
    };
  }
}

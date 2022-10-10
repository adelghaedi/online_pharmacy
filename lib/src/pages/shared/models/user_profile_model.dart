class UserProfileModel {
  final int id;
  final String firstName;
  final String mobile;
  final String? base64Image;

  UserProfileModel({
    required this.id,
    required this.firstName,
    required this.mobile,
    required this.base64Image,
  });
}

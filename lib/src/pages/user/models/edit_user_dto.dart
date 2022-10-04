class EditUserDto {
  final String firstName, lastName, mobile, birthDate, userName;
  final bool isAdmin;
  final String? base64Image;

  EditUserDto({
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.birthDate,
    required this.userName,
    required this.isAdmin,
    this.base64Image,
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
    };
  }
}

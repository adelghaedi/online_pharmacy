class InsertUserDto {
  final String firstName, lastName, mobile, birthDate, userName, password;
  final bool isAdmin;
  final String? base64Image;

  InsertUserDto({
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.birthDate,
    required this.userName,
    required this.password,
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
      'password': password,
      'isAdmin': isAdmin,
      'base64Image': base64Image,
    };
  }
}

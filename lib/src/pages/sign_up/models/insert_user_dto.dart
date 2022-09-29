class InsertUserDto {
  final String firstName, lastName, mobile, birthDate, userName, password;
  final bool isAdmin;
  final List? imageBytes;

  InsertUserDto({
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.birthDate,
    required this.userName,
    required this.password,
    required this.isAdmin,
    this.imageBytes,
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
      'imageBytes': imageBytes,
    };
  }
}

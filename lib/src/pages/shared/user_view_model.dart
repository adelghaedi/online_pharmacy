class UserViewModel {
  final int id;
  final String firstName, lastName, mobile, birthDate, userName, password;
  final bool isAdmin;
  final String? base64Image;

  UserViewModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.birthDate,
    required this.userName,
    required this.password,
    required this.isAdmin,
    required this.base64Image,
  });

  factory UserViewModel.fromJson(Map<String, dynamic> json) {
    return UserViewModel(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        mobile: json['mobile'],
        birthDate: json['birthDate'],
        userName: json['userName'],
        password: json['password'],
        isAdmin: json['isAdmin'],
        base64Image: json['base64Image']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
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

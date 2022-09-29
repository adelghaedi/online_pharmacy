class UserViewModel {
  final int id;
  final String firstName, lastName, mobile, birthDate, userName, password;
  final bool isAdmin;
  final List? imageBytes;

  UserViewModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.birthDate,
    required this.userName,
    required this.password,
    required this.isAdmin,
    required this.imageBytes,
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
        imageBytes: json['imageBytes']);
  }
}

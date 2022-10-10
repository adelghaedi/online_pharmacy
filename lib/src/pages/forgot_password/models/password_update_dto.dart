class PasswordUpdateDto {
  final String newPassword;

  PasswordUpdateDto(this.newPassword);

  Map<String, dynamic> toJson() {
    return {'password': newPassword};
  }
}

class EditPasswordDto {
  final String newPassword;

  EditPasswordDto(this.newPassword);

  Map<String, dynamic> toJson() {
    return {'password': newPassword};
  }
}

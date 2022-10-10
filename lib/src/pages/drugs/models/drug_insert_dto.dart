class DrugInsertDto {
  final String name, manufacturingCompanyName;
  final String? base64Image;

  DrugInsertDto({
    required this.name,
    required this.manufacturingCompanyName,
    this.base64Image,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'manufacturingCompanyName': manufacturingCompanyName,
      'base64Image': base64Image,
    };
  }
}

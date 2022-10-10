class DrugViewModel {

  final int id;
  final String name, manufacturingCompanyName;
  final String? base64Image;

  DrugViewModel({
    required this.id,
    required this.name,
    required this.manufacturingCompanyName,
    required this.base64Image,
  });

  factory DrugViewModel.fromJson(Map<String, dynamic> json) {
    return DrugViewModel(
      id: json['id'],
      name: json['name'],
      manufacturingCompanyName: json['manufacturingCompanyName'],
      base64Image: json['base64Image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'manufacturingCompanyName': manufacturingCompanyName,
      'base64Image': base64Image,
    };
  }
}

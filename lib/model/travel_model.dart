class TravelModel {
  String id;
  String name;
  String description;
  String speciality;
  String imageUrl;
  double review;
  bool isFavourite = false;

  TravelModel({
    this.id,
    this.name,
    this.description,
    this.speciality,
    this.imageUrl,
    this.review,
    this.isFavourite = false,
  });

  factory TravelModel.fromJson(Map<String, dynamic> json) {
    return TravelModel(
      id: json['id'],
      description: json['description'],
      name: json['name'],
      speciality: json['speciality'],
      imageUrl: json['imageurl'],
      review: double.tryParse(json['review'].toString())
    );
  }
}

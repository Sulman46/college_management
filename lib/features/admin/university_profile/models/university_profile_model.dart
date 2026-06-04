class UniversityProfileModel {
  String name;
  String logo;
  String campusId;
  String phone;
  String email;
  String website;
  String address;
  String location;

  UniversityProfileModel({
    required this.name,
    required this.logo,
    required this.campusId,
    required this.phone,
    required this.email,
    required this.website,
    required this.address,
    required this.location,
  });

  factory UniversityProfileModel.fromMap(
      Map<String, dynamic> map) {
    return UniversityProfileModel(
      name: map['name'] ?? '',
      logo: map['logo'] ?? '',
      campusId: map['campusId'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      website: map['website'] ?? '',
      address: map['address'] ?? '',
      location: map['location'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'logo': logo,
      'campusId': campusId,
      'phone': phone,
      'email': email,
      'website': website,
      'address': address,
      'location': location,
    };
  }


  UniversityProfileModel copyWith({
    String? name,
    String? logo,
    String? campusId,
    String? phone,
    String? email,
    String? website,
    String? address,
    String? location,
  }) {
    return UniversityProfileModel(
      name: name ?? this.name,
      logo: logo ?? this.logo,
      campusId: campusId ?? this.campusId,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      website: website ?? this.website,
      address: address ?? this.address,
      location: location ?? this.location,
    );
  }
}
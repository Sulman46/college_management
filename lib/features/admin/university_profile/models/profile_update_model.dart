import 'dart:io';

class ProfileImageUpdateModel {

  String userId;
  File image;

  ProfileImageUpdateModel({
    required this.userId,
    required this.image,
  });

  factory ProfileImageUpdateModel.fromMap(
      Map<String, dynamic> map) {

    return ProfileImageUpdateModel(
      userId: map['userId'] ?? '',
      image: File(map['image'] ?? ''),
    );
  }

  Map<String, dynamic> toMap() {

    return {
      'userId': userId,
      'image': image.path,
    };
  }
}
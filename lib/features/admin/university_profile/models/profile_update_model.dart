
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImageUpdateModel {

  String userId;
  XFile image;

  ProfileImageUpdateModel({
    required this.userId,
    required this.image,
  });

  factory ProfileImageUpdateModel.fromMap(
      Map<String, dynamic> map) {

    return ProfileImageUpdateModel(
      userId: map['userId'] ?? '',


      image: XFile(map['image'] ?? ''),
    );
  }

  Map<String, dynamic> toMap() {

    return {
      'userId': userId,
      'image': image.path,
    };
  }
}
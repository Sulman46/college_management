import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class StudentModel {
  final String? id;
  final String? registrationNumber;
  final String? rollNo;
  final String? name;
  final String? fatherName;
  final String? semesterId;
  final String? image;
  final XFile? userImage;
  final String? gender;
  final String? affiliation;
  final String? contact;
  final String? email;
  final String? address;
  final String? department;
  final String? programName;
  final String? session;
  final String? section;
  final String? degree;
  final String? semester;
  final String? status;

  StudentModel({
    this.id,
    this.registrationNumber,
    this.rollNo,
    this.name,
    this.fatherName,
    this.image,
    this.semesterId,
    this.userImage,
    this.gender,
    this.affiliation,
    this.contact,
    this.email,
    this.address,
    this.department,
    this.programName,
    this.session,
    this.section,
    this.degree,
    this.semester,
    this.status,
  });

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      id: map['_id'] ?? "",
      registrationNumber: map['registrationNumber'] ?? "",
      rollNo: map['rollNo'] ?? "",
      name: map['name'] ?? "",
      fatherName: map['fatherName'] ?? "",
      image: map['image'] ?? "",
      semesterId: map['semesterId'] ?? "",
      gender: map['gender'] ?? "Male",
      affiliation: map['affiliation'] ?? "",
      contact: map['contact'] ?? "",
      email: map['email'] ?? "",
      address: map['address'] ?? "",
      department: map['department'] ?? "",
      programName: map['programName'] ?? "",
      session: map['session'] ?? "",
      section: map['section'] ?? "",
      degree: map['degree'] ?? "",
      semester: map['semester'] ?? "1",
      status: map['status'] ?? "Active",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null && id!.isNotEmpty) '_id': id,
      if (registrationNumber != null) 'registrationNumber': registrationNumber,
      if (rollNo != null) 'rollNo': rollNo,
      if (name != null) 'name': name,
      if (fatherName != null) 'fatherName': fatherName,
      if (image != null) 'image': image,
      if (gender != null) 'gender': gender,
      // if (affiliation != null) 'affiliation': affiliation,
      if (contact != null) 'contact': contact,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      // if (department != null) 'department': department,
      // if (programName != null) 'programName': programName,
      // if (session != null) 'session': session,
      // if (section != null) 'section': section,
      // if (degree != null) 'degree': degree,
      // if (semester != null) 'semester': semester,
      if (semesterId != null) 'semesterId': semesterId,
      if (status != null) 'status': status,
    };
  }

  StudentModel copyWith({
    String? id,
    String? registrationNumber,
    String? rollNo,
    String? name,
    String? fatherName,
    String? image,
    XFile? userImage,
    String? gender,
    String? affiliation,
    String? contact,
    String? email,
    String? address,
    String? department,
    String? semesterId,
    String? programName,
    String? session,
    String? section,
    String? degree,
    String? semester,
    String? status,
  }) {
    return StudentModel(
      id: id ?? this.id,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      rollNo: rollNo ?? this.rollNo,
      name: name ?? this.name,
      fatherName: fatherName ?? this.fatherName,
      image: image ?? this.image,
      semesterId: semesterId ?? this.semesterId,
      userImage: userImage ?? this.userImage,
      gender: gender ?? this.gender,
      affiliation: affiliation ?? this.affiliation,
      contact: contact ?? this.contact,
      email: email ?? this.email,
      address: address ?? this.address,
      department: department ?? this.department,
      programName: programName ?? this.programName,
      session: session ?? this.session,
      section: section ?? this.section,
      degree: degree ?? this.degree,
      semester: semester ?? this.semester,
      status: status ?? this.status,
    );
  }


  Future<FormData> toFormData() async {
    final map = <String, dynamic>{
      if (id != null && id!.isNotEmpty) '_id': id,
      if (registrationNumber != null) 'registrationNumber': registrationNumber,
      if (rollNo != null) 'rollNo': rollNo,
      if (name != null) 'name': name,
      if (fatherName != null) 'fatherName': fatherName,
      if (gender != null) 'gender': gender,
      if (semesterId != null) 'semesterId': semesterId,
      if (contact != null) 'contact': contact,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (status != null) 'status': status,
    };

    if (userImage != null) {
      if (kIsWeb) {
        map['image'] = MultipartFile.fromBytes(
          await userImage!.readAsBytes(),
          filename: "${userImage!.name}-${DateTime.now()}-${DateTime.now().hour}-${DateTime.now().minute}-${DateTime.now().second}-${DateTime.now().millisecond}",
        );
      } else {
        map['image'] = await MultipartFile.fromFile(
          userImage!.path,
          filename: "${userImage!.name}-${DateTime.now()}-${DateTime.now().hour}-${DateTime.now().minute}-${DateTime.now().second}-${DateTime.now().millisecond}",
        );
      }
    } else if (image != null && image!.isNotEmpty) {
      map['image'] = image;
    }

    return FormData.fromMap(map);
  }

  bool get hasNullFields =>
      registrationNumber == null ||
          rollNo == null ||
          name == null ||
          fatherName == null ||
          affiliation == null ||
          contact == null ||
          address == null ||
          department == null ||
          programName == null ||
          session == null ||
          section == null ||
          degree == null;
}
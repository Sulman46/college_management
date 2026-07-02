import 'dart:developer';

import 'package:cross_file/cross_file.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AnnouncementModel {
  final String? id;
  final String? title;
  final String? content;
  final String? category;
  final String? priority;
  final String? feeInfo;
  final String? postedBy;
  final bool? isArchived;
  final String? date;
  final String? attachment;
  final XFile? attFile;

  AnnouncementModel({
    this.id,
    this.title,
    this.content,
    this.category,
    this.priority,
    this.feeInfo,
    this.postedBy,
    this.isArchived,
    this.date,
    this.attachment,
    this.attFile,
  });

  factory AnnouncementModel.fromMap(Map<String, dynamic> map) {
    return AnnouncementModel(
      id: map['_id'] ?? "",
      title: map['title'] ?? "",
      content: map['content'] ?? "",
      category: map['category'] ?? "Academic",
      priority: map['priority'] ?? "Medium",
      feeInfo: map['feeInfo'] ?? "",
      postedBy: map['postedBy'] ?? "",
      isArchived: map['isArchived'] ?? false,
      date: map['date']??"",
      attachment: map['attachment'] ?? "",
    );
  }

  Future<FormData> toMultipart() async {
    final Map<String, dynamic> data = {
      if (id != null && id!.isNotEmpty) '_id': id,
      if (title != null && title!.isNotEmpty) 'title': title,
      if (content != null && content!.isNotEmpty) 'content': content,
      if (category != null && category!.isNotEmpty) 'category': category,
      if (priority != null && priority!.isNotEmpty) 'priority': priority,
      if (feeInfo != null && feeInfo!.isNotEmpty) 'feeInfo': feeInfo,
      if (postedBy != null && postedBy!.isNotEmpty) 'postedBy': postedBy,
      if (isArchived != null) 'isArchived': isArchived,
      if (date != null && date!.isNotEmpty) 'date': date,
    };

    if (attFile != null) {
      if (kIsWeb) {
        data['attachment'] = MultipartFile.fromBytes(
          await attFile!.readAsBytes(),
          filename: "${attFile!.name}-${DateTime.now()}-${DateTime.now().hour}-${DateTime.now().minute}-${DateTime.now().second}-${DateTime.now().millisecond}",
        );
      } else {
        data['attachment'] = await MultipartFile.fromFile(
          attFile!.path,
          filename: "${attFile!.name}-${DateTime.now()}-${DateTime.now().hour}-${DateTime.now().minute}-${DateTime.now().second}-${DateTime.now().millisecond}",
        );
      }
    } else if (attachment != null && attachment!.isNotEmpty) {
      data['attachment'] = attachment;
    }

    return FormData.fromMap(data);
  }

  AnnouncementModel copyWith({
    String? id,
    String? title,
    String? content,
    String? category,
    String? priority,
    String? feeInfo,
    String? postedBy,
    bool? isArchived,
    String? date,
    String? attachment,
    XFile? attFile,
  }) {
    return AnnouncementModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      feeInfo: feeInfo ?? this.feeInfo,
      postedBy: postedBy ?? this.postedBy,
      isArchived: isArchived ?? this.isArchived,
      date: date ?? this.date,
      attachment: attachment ?? this.attachment,
      attFile: attFile ?? this.attFile,
    );
  }
}
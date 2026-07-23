import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class StudentFreezeRequestModel {
  String? studentId;
  String? semesterId;
  String? requestType;
  String? reason;
   XFile? attFile;

  StudentFreezeRequestModel({ this.semesterId, this.studentId, this.requestType, this.reason, this.attFile});

  Future<FormData> toMultipart() async {
    final data = <String, dynamic>{
      if (studentId?.isNotEmpty ?? false) 'studentId': studentId,
      if (semesterId?.isNotEmpty ?? false) 'semesterId': semesterId,
      if (requestType?.isNotEmpty ?? false) 'requestType': requestType,
      if (reason?.isNotEmpty ?? false) 'reason': reason,
    };

    if (attFile != null) {
      final fileName =
          "${attFile!.name}-${DateTime.now().millisecondsSinceEpoch}";

      data['statusAttachment'] = kIsWeb
          ? MultipartFile.fromBytes(
        await attFile!.readAsBytes(),
        filename: fileName,
      )
          : await MultipartFile.fromFile(
        attFile!.path,
        filename: fileName,
      );
    }

    return FormData.fromMap(data);
  }


}
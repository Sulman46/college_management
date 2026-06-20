import 'dart:io';

import 'package:college_management/features/admin/student_registrations/presentation/controller/cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';

class PickStudentImageWidget extends StatelessWidget {
   PickStudentImageWidget({super.key,required this.studentRegisterCubit});
  StudentRegistrationCubit studentRegisterCubit;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async{
        await studentRegisterCubit.pickImage();
      } ,
      child: Container(
        height: 140,
        width: 140,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.white,
          boxShadow: AppColor.shadowBlack,
          image:studentRegisterCubit.userImage != null
              ? DecorationImage(
            image:kIsWeb?  NetworkImage(studentRegisterCubit.userImage!.path): FileImage(File(studentRegisterCubit.userImage!.path)),
            fit: BoxFit.cover,
          ):studentRegisterCubit.updateStudentModel!=null && studentRegisterCubit.updateStudentModel!.image !=""?DecorationImage(
            image: NetworkImage(studentRegisterCubit.updateStudentModel?.image??""),
            fit: BoxFit.cover,
          )
              : null,
        ),
        child: studentRegisterCubit.userImage == null
            ? Icon(Icons.camera_alt, size: 40, color: AppColor.grey)
            : null,
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import '../../../../../core/app/di_container.dart';
import '../../../../../core/helper/image_picker_class.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/custom_image_cache.dart';
import '../controller/cubit.dart';

class UniversityProfileImage extends StatefulWidget {
  const UniversityProfileImage({super.key});

  @override
  State<UniversityProfileImage> createState() => _UniversityProfileImageState();
}

class _UniversityProfileImageState extends State<UniversityProfileImage> {
  var universityProfileCubit=DiContainer().sl<UniversityProfileCubit>();
  Future<void> pickImage() async {
    final picked = await ImagePickerClass.pickImage();
    if (picked != null) {
      universityProfileCubit.pickUniversityImage(picked);
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: universityProfileCubit.editUniversityProfile ? ()async{await pickImage();} : null,
      child: Container(
        height: 140,
        width: 140,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1,color: AppColor.primary),
          color: AppColor.white,
          boxShadow: AppColor.shadowBlack,
          image: universityProfileCubit.pickedUniversityImage != null
              ? DecorationImage(
            image: FileImage(File(universityProfileCubit.pickedUniversityImage!.path)),
            fit: BoxFit.cover,
          )
              : null,
        ),
        child:!universityProfileCubit.editUniversityProfile?
        universityProfileCubit.universityModel!=null && universityProfileCubit.universityModel!.universityProfileModel!.logo !=""? CustomImageCache(url: universityProfileCubit.universityModel?.universityProfileModel?.logo??"",width: 140,height: 140,radius: 500,):Icon(Icons.camera_alt, size: 40, color: AppColor.grey):universityProfileCubit.universityModel!=null && universityProfileCubit.universityModel!.universityProfileModel!.logo !=""? CustomImageCache(url: universityProfileCubit.universityModel?.universityProfileModel?.logo??"",width: 140,height: 140,radius: 500,)
            :universityProfileCubit.editUniversityProfile? universityProfileCubit.pickedUniversityImage == null?Icon(Icons.camera_alt, size: 40, color: AppColor.grey):null: null,
      ),
    );
  }
}

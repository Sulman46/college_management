
import 'package:college_management/core/app/myapp.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toastification/toastification.dart';

void showMessage(String text,{String? title,bool? isError,Color? color}){
  toastification.show (
    alignment: Alignment.bottomCenter,
    title:title==null?null:  AppText(text: text,fontSize: 12,fontWeight: FontWeight.w600,color: AppColor.white,),
    description: AppText(text: text,fontSize: 11,color: AppColor.white,),
    icon: Icon(
      isError!=null&&  isError ? Icons.error_outline : Icons.check_circle_outline,
      color: Colors.white,
      size: 22,
    ),
    showIcon: true,

    closeButton: ToastCloseButton(
      showType: CloseButtonShowType.always,
      buttonBuilder: (context, onClose) {
        return IconButton(
          onPressed: onClose,
          icon: const Icon(
            Icons.close,
            color: Colors.white,
            size: 18,
          ),
        );
      },
    ),


    boxShadow: AppColor.shadowBlack,
    backgroundColor: AppColor.primaryDark.withOpacity(.8),
    borderSide: BorderSide( color:isError!=null&&  isError
        ? AppColor.red.withOpacity(0.7)
        : AppColor.primary.withOpacity(0.5),
      width: 0.5,),
    borderRadius:  BorderRadius.circular(15),

    autoCloseDuration: const Duration(seconds: 5),
  );
}


// Fluttertoast.showToast(
//     msg: text,
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: isError==true?2:1,
//     backgroundColor:isError==true? color??AppColor.red:color??AppColor.primary,
//     textColor: AppColor.white,
//     fontSize: 12.0
// );
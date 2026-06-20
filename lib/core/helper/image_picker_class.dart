import 'dart:io';
import 'package:college_management/core/helper/show_message.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class ImagePickerClass{
 static Future<XFile?> pickImage()async{
    var picker=ImagePicker();
    XFile? pickImage=await picker.pickImage(source: ImageSource.gallery);
    if(pickImage!=null){
      return XFile(pickImage.path);
    }else{
      return null;
    }

  }
}
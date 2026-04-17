import 'dart:io';
import 'package:college_management/core/helper/show_message.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class ImagePickerClass{
 static Future<File?> pickImage()async{
   // var status=await Permission.storage.status;
   // if(!status.isGranted){
   //  await Permission.storage.request();
   //  var status=await Permission.storage.status;
   //  if(!status.isGranted){
   //    showMessage("Storage permission denied.",isError: true);
   //    return null;
   //  }
   // }

    var picker=ImagePicker();
    XFile? pickImage=await picker.pickImage(source: ImageSource.gallery);
    if(pickImage!=null){
      return File(pickImage.path);
    }else{
      return null;
    }

  }
}
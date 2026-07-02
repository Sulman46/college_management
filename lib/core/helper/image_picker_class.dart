import 'dart:io';
import 'package:college_management/core/helper/show_message.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cross_file/cross_file.dart';
import 'package:file_picker/file_picker.dart';


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



 static Future<XFile?> pickFile() async {
   try {
     final result = await FilePicker.pickFiles(
       allowMultiple: false,
       withData: false,
       type: FileType.custom,
       allowedExtensions: [
         // Images
         'jpg',
         'jpeg',
         'png',
         'gif',
         'webp',
         'bmp',

         // Documents
         'pdf',
         'doc',
         'docx',
         'xls',
         'xlsx',
         'ppt',
         'pptx',
         'txt',
         'csv',
         'rtf',

         // Archives
         'zip',
         'rar',
         '7z',
       ],
     );

     if (result == null || result.files.isEmpty) {
       return null;
     }

     final file = result.files.first;

     // Android, iOS, Desktop
     if (file.path != null) {
       return XFile(file.path!);
     }

     // Web
     if (file.bytes != null) {
       return XFile.fromData(
         file.bytes!,
         name: file.name,
         mimeType: file.extension,
       );
     }

     return null;
   } catch (e) {
     print(e);
     return null;
   }
 }

}
// import 'dart:convert';
//
// import 'package:college_management/constants/app_apis.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class AuthSharePref{
//   Future<void> setUserData(UserModel model)async{
//     SharedPreferences pref=await SharedPreferences.getInstance();
//     String data=jsonEncode(model.toJson());
//     await pref.setString(AppApis.userModel, data);
//   }
//
//   Future<UserModel?> getUserData()async{
//     SharedPreferences pref=await SharedPreferences.getInstance();
//     String? data= pref.getString(AppApis.userModel);
//     if(data!=null){
//       var json=jsonDecode(data??"");
//       UserModel model=UserModel.fromJson(json);
//       return model;
//     }else{
//       return null;
//     }
//
//   }
// }
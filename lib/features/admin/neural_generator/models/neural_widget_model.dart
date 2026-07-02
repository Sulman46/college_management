import 'package:college_management/core/enums/user_enums.dart';

class NeuralWidgetModel{
  String id;
  String name;
  List<String> department;
  String email;
  String? userName;
  String status;
  UserRole role;
  bool canSelect;
  NeuralWidgetModel({required this.id,required this.name,required this.status,required this.email,required this.department,required this.role,required this.canSelect, this.userName});

}
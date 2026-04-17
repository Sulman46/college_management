import 'package:flutter/material.dart';

class AdminDrawerButtonModel{
  String title;
  IconData icon;
  VoidCallback? onTap;
  List<SubDrawerButtonModel>? subList;
  AdminDrawerButtonModel({required this.title,required this.icon,this.onTap,this.subList});
}
class SubDrawerButtonModel{
  String title;
  IconData icon;
  VoidCallback? onTap;
  SubDrawerButtonModel({required this.title,required this.icon,this.onTap});
}


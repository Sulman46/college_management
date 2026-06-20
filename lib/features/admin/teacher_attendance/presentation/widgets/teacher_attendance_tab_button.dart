import 'package:college_management/core/app/di_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_widgets_size.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../controller/cubit.dart';

class TeacherAttendanceTabButton extends StatefulWidget {
  const TeacherAttendanceTabButton({super.key});

  @override
  State<TeacherAttendanceTabButton> createState() => _TeacherAttendanceTabButtonState();
}

class _TeacherAttendanceTabButtonState extends State<TeacherAttendanceTabButton> {
  final _teacherAttendanceCubit=DiContainer().sl<TeacherAttendanceCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _teacherAttendanceCubit,
      builder: (context,stateslw) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: screenPaddingHori,vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 3,vertical: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColor.white.withOpacity(.3),
          ),
          child: Row(
            children: [
              Expanded(child: _tabButton(text: "Live Dashboard", isSelected: !_teacherAttendanceCubit.isHistory, onTap: () {
                _teacherAttendanceCubit.getTabVal(false);
              },)),
              Expanded(child: _tabButton(text: "History", isSelected: _teacherAttendanceCubit.isHistory, onTap: () {
                _teacherAttendanceCubit.getTabVal(true);
              },)),
            ],
          ),
        );
      }
    );
  }
}


Widget _tabButton({required String text,required bool isSelected,required VoidCallback? onTap}){
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal:8,vertical: 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:isSelected? AppColor.primary:AppColor.transparent),
      child: AppText(text: text,fontSize: 12,color: isSelected?AppColor.white:AppColor.white,),
    ),
  );
}

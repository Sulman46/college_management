import 'package:college_management/features/admin/teacher_attendance/presentation/page/get_semester_timetable_sheet_dialog.dart';
import 'package:college_management/features/admin/teacher_attendance/presentation/widgets/teacher_attendance_tab_button.dart';
import 'package:flutter/material.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../core/constants/app_widgets_size.dart';
import '../../../../../core/enums/user_enums.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../Authentication/presentation/controller/cubit.dart';

class TeacherAttendanceAdminHeader extends StatelessWidget {
  const TeacherAttendanceAdminHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,

      pinned: true,
      backgroundColor: AppColor.primary,
      leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_outlined,size: 25,color: AppColor.white,)),
      // title:,
      centerTitle: true,
      title:  AppText(text: "Teacher attendance",fontSize: 13,color: AppColor.white,),
      actionsPadding: EdgeInsets.only(right: screenPaddingHori),
      actions: [
        if(_authCubit.userModel!.role==UserRole.admin)
        InkWell(
          onTap: () {
            showDialog(context: context, builder: (context) => GetSemesterTimetableSheetDialog(),);
            // Navigator.push(context, MaterialPageRoute(builder: (context) => AddTeacherAttendanceScreen(),));
          },
          child: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1,color: AppColor.white)
              ),
              child: Icon(Icons.add,size: 20,color: AppColor.white,)),),
      ],
      expandedHeight:_authCubit.userModel!.role==UserRole.admin? 100:0,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Column(
          mainAxisSize: MainAxisSize.min,
          children:_authCubit.userModel!.role==UserRole.admin? [
            Spacer(),
            TeacherAttendanceTabButton(),
            SizedBox(height: 6,),
          ]:[],
        ),
      ),
    );
  }
}

final _authCubit=DiContainer().sl<AuthenticationCubit>();


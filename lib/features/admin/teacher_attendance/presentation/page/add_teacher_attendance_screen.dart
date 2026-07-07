import 'dart:developer';

import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/constants/constant_data.dart';
import 'package:college_management/core/constants/media_query.dart';
import 'package:college_management/core/helper/app_date_picker.dart';
import 'package:college_management/core/helper/date_to_string_helper.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/Authentication/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/teacher_attendance/models/teacher_attendance_model.dart';
import 'package:college_management/features/admin/teacher_attendance/models/teacher_attendance_time_table_model.dart';
import 'package:college_management/features/admin/teacher_attendance/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/teacher_attendance/presentation/widgets/add_teacher_attendance_widget.dart';
import 'package:college_management/features/admin/teacher_attendance/presentation/widgets/teacher_attendance_type_widget.dart';
import 'package:college_management/features/admin/timetable_manager/presentation/controller/cubit.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/custom_text_form.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/drop_down_field_widget.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';
import '../../../course_catalog/presentation/widgets/catalog_depart_widget.dart';
import '../../../timetable_manager/models/time_table_manger_model.dart';

class AddTeacherAttendanceScreen extends StatefulWidget {
  const AddTeacherAttendanceScreen({super.key});

  @override
  State<AddTeacherAttendanceScreen> createState() =>
      _AddTeacherAttendanceScreenState();
}

class _AddTeacherAttendanceScreenState
    extends State<AddTeacherAttendanceScreen> {
  final _timeTableCubit = DiContainer().sl<TimetableManagerCubit>();
  final _teacherAttendanceCubit = DiContainer().sl<TeacherAttendanceCubit>();
  final _authCubit = DiContainer().sl<AuthenticationCubit>();
  TextEditingController minuteLateController=TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(_timeTableCubit.dataList.isNotEmpty){
        _teacherAttendanceCubit.getTeacherDataList(_timeTableCubit.dataList);
      }
      // _teacherAttendanceCubit.getTeacherAttendanceModel(TeacherAttendanceModel());
    },);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        bloc: _teacherAttendanceCubit,
        builder: (context,staevhk) {
          return Column(
            children: [
              CustomTopBar(text: "Mark Attendance"),
              /// todo

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: screenPaddingHori,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),

                      AppText(text: "Dept. ${_teacherAttendanceCubit.teacherAttendanceModel.department??""}",fontSize: 11,color: AppColor.white,),
                      AppText(text: "Program. ${_teacherAttendanceCubit.teacherAttendanceModel.programName??""}",fontSize: 11,color: AppColor.white,),
                      AppText(text: "Sec. ${_teacherAttendanceCubit.teacherAttendanceModel.section??""} | Sess. ${_teacherAttendanceCubit.teacherAttendanceModel.session??""} | Sem. ${_teacherAttendanceCubit.teacherAttendanceModel.semesterLevel??""}",fontSize: 11,color: AppColor.white,),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Row(
                                children: [
                                  ...List.generate(ConstantData.teacherAttendanceStatus.length, (index) {
                                    String value=ConstantData.teacherAttendanceStatus[index];
                                    bool selected=value.toLowerCase()==_teacherAttendanceCubit.attendanceType.toLowerCase();
                                    return
                                      InkWell(
                                          onTap: () {
                                            _teacherAttendanceCubit.getAttendanceType(value);
                                          },
                                          child: TeacherAttendanceTypeWidget(text: value, isSelected: selected));
                                  },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          CustomElevatedButton(
                            width:80,
                            fontSize: 11,

                            height: 25,
                            onPressed: () async {

                              var response=await _teacherAttendanceCubit.uploadTeacherAttendance();
                              if(response){
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }
                              // TODO: Submit logic
                            },
                            text: "Save",
                          ),
                          ],
                      ),

                      ...List.generate(_teacherAttendanceCubit.teacherDataList.length, (index) => AddTeacherAttendanceWidget( index: index,teacherAttendanceTimeTableModel: _teacherAttendanceCubit.teacherDataList[index],),),

                      SafeArea(top: false, child: SizedBox(height: 30)),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}

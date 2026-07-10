import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/features/admin/teacher_records/presentation/page/add_teacher_record_screen.dart';
import 'package:college_management/features/admin/teacher_records/presentation/widgets/teacher_record_item_widget.dart';
import 'package:college_management/widgets/data_not_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:college_management/widgets/custom_text_form.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app/di_container.dart';
import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../core/enums/user_enums.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../Authentication/presentation/controller/cubit.dart';
import '../controller/cubit.dart';


class TeacherRecordsAdminScreen extends StatefulWidget {
  const TeacherRecordsAdminScreen({super.key});

  @override
  State<TeacherRecordsAdminScreen> createState() =>
      _TeacherRecordsAdminScreenState();
}

class _TeacherRecordsAdminScreenState extends State<TeacherRecordsAdminScreen> {

  final _teacherRecordCubit=DiContainer().sl<TeacherRecordsCubit>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
     await _teacherRecordCubit.getTeachers();
    },);
  }


  double top=mdHeight(navigatorKey.currentContext!)*.9;
  double left=mdWidth(navigatorKey.currentContext!)*.65;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder(
        bloc: _teacherRecordCubit,
        builder: (context,statesnll) {
          return Stack(
            children: [
              Column(
                children: [
                  /// 🔹 TOP BAR
                  CustomTopBar(text: "Teacher Record"),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal:screenPaddingHori),
                        child: Column(
                          children: [
                            SizedBox(height: 10,),

                            /// 🔹 SEARCH
                            CustomTextFormField(
                              controller: _teacherRecordCubit.searchController,
                              subTitle: "Search...",
                              isHintText: true,
                              onChanged: (p0) {
                                _teacherRecordCubit.filterData(p0);
                              },
                              borderSize: 1,
                              contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                            ),

                            SizedBox(height: 15,),

                            /// 🔹 LIST
                            if(_teacherRecordCubit.filterTeacher.isNotEmpty)
                            ...List.generate(_teacherRecordCubit.filterTeacher.length,
                                  (index) => TeacherRecordItemWidget(
                                    canEdit:_authCubit.userModel!.role==UserRole.admin,
                                    model: _teacherRecordCubit.filterTeacher[index],),)
                            else
                            DataNotFoundWidget(onTap: () async{
                            await  _teacherRecordCubit.getTeachers();
                            },),
                            SafeArea(
                                top: false,
                                child: SizedBox(height: 30,)),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              if(_authCubit.userModel!.role==UserRole.admin)
              AnimatedPositioned(
                duration: Duration(milliseconds: 100),
                top: _teacherRecordCubit.top,
                right: _teacherRecordCubit.right,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    _teacherRecordCubit.getButtonPosition(topVal: details.delta.dy, rightVal: details.delta.dx);
                  },
                  child: CustomElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddTeacherRecordScreen(),));
                    },
                    text: "Add New",
                    fontSize: 15,
                    width: 110,
                    height: 50,
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

final _authCubit=DiContainer().sl<AuthenticationCubit>();

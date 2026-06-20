import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/helper/data_extractor.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/student_enrollment/data/models/student_enrollment_filter_model.dart';
import 'package:college_management/features/admin/student_enrollment/presentation/widgets/move_next_dialog.dart';
import 'package:college_management/features/admin/student_enrollment/presentation/widgets/student_enrollment_filter_dialog.dart';
import 'package:college_management/features/admin/student_enrollment/presentation/widgets/student_enrollment_tabs.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/custom_button.dart';
import 'package:college_management/widgets/data_not_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app/di_container.dart';
import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../programs/presentation/controller/cubit.dart';
import '../controller/cubit.dart';
import '../widgets/enrolled_student_widget.dart';



class StudentEnrollmentScreen extends StatefulWidget {
  const StudentEnrollmentScreen({super.key});

  @override
  State<StudentEnrollmentScreen> createState() =>
      _StudentEnrollmentScreenState();
}

class _StudentEnrollmentScreenState extends State<StudentEnrollmentScreen> {

  final _programCubit=DiContainer().sl<AdminProgramsCubit>();
  final _studentEnrollCubit=DiContainer().sl<StudentEnrollmentCubit>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _studentEnrollCubit.getTabIndex(true);
      _studentEnrollCubit.getStudentEnrollmentFilter(StudentEnrollmentFilterModel());
      await _studentEnrollCubit.get(StudentEnrollmentFilterModel(semester: "1"));
      if(_programCubit.programsList.isEmpty){
        await _programCubit.getPrograms();
      }
    },);
    super.initState();
  }


  double top=mdHeight(navigatorKey.currentContext!)*.9;
  double left=mdWidth(navigatorKey.currentContext!)*.65;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: 10),
          child: SafeArea(
              top: false,
              child: CustomElevatedButton(onPressed: (){
                showDialog(context: context, builder: (context) => MoveNextDialog(),);
              }, text: "Move Next",width: 190,height: 40,))),
      body: BlocBuilder(
        bloc: _studentEnrollCubit,
        builder: (context,statebka) {
          return Column(
            children: [
              /// 🔹 TOP BAR
              CustomTopBar(text: "Student Enrollment",suffix: InkWell(
                  onTap: () {
                    showDialog(context: context, builder: (context) => StudentEnrollmentFilterDialog(),);
                  },
                  child: Icon(Icons.filter_list,size: 20,color: AppColor.white,)),),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal:screenPaddingHori),
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        StudentEnrollmentTabs(),

                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(text: "Student",fontSize: 12,color: AppColor.grey,),
                            AppText(text: "Select All",fontSize: 12,color: AppColor.grey,)
                          ],
                        ),
                        SizedBox(height: 10,),

                        /// 🔹 LIST
                        if(_studentEnrollCubit.dataList.where((e) => _studentEnrollCubit.isNewTab? DataExtractor.extractInt(e.semester)==1:true,).isNotEmpty)
                        ...List.generate(_studentEnrollCubit.dataList.length, (index) => EnrolledStudentWidget(studentEnrollmentModel: _studentEnrollCubit.dataList.where((element) =>_studentEnrollCubit.isNewTab? DataExtractor.extractInt(element.semester)==1:true,).toList()[index],),)
                        else
                          DataNotFoundWidget(onTap: () async {
                            if(_studentEnrollCubit.isNewTab){
                              await _studentEnrollCubit.get(StudentEnrollmentFilterModel(semester: "1"));
                            }else{
                              showDialog(context: context, builder: (context) => StudentEnrollmentFilterDialog(),);
                            }
                          }),
                        SafeArea(
                            top: false,
                            child: SizedBox(height: 40,)),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        }
      ),
    );
  }
}





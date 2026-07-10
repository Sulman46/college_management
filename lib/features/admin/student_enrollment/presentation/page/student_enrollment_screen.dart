import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/helper/data_extractor.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/semesters/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/student_enrollment/data/models/student_enrollment_filter_model.dart';
import 'package:college_management/features/admin/student_enrollment/presentation/widgets/student_enrolled_section.dart';
import 'package:college_management/features/admin/student_enrollment/presentation/widgets/student_enrollment_filter_dialog.dart';
import 'package:college_management/features/admin/student_enrollment/presentation/widgets/student_enrollment_history_section.dart';
import 'package:college_management/features/admin/student_enrollment/presentation/widgets/student_enrollment_tabs.dart';
import 'package:college_management/features/admin/student_enrollment/presentation/widgets/student_new_admission_section.dart';
import 'package:college_management/widgets/data_not_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app/di_container.dart';
import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../core/enums/user_enums.dart';
import '../../../../Authentication/presentation/controller/cubit.dart';
import '../../../programs/presentation/controller/cubit.dart';
import '../../../student_registrations/presentation/controller/cubit.dart';
import '../controller/cubit.dart';
import '../widgets/enrolled_student_widget.dart';



class StudentEnrollmentScreen extends StatefulWidget {
  const StudentEnrollmentScreen({super.key});

  @override
  State<StudentEnrollmentScreen> createState() =>
      _StudentEnrollmentScreenState();
}

class _StudentEnrollmentScreenState extends State<StudentEnrollmentScreen> {

  final _semesterCubit=DiContainer().sl<SemesterAdminCubit>();
  final _studentEnrollCubit=DiContainer().sl<StudentEnrollmentCubit>();
  final _studentRegisterCubit=DiContainer().sl<StudentRegistrationCubit>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _studentEnrollCubit.initDataList();
      _studentEnrollCubit.initFunction(StudentEnrollmentFilterModel());
      _studentEnrollCubit.getTabIndex(false);

      if(_authCubit.userModel!.role==UserRole.student){
      await  _studentEnrollCubit.get();
      }else{
        await _semesterCubit.getSemesterList();
        await _studentRegisterCubit.get();
        showDialog(context: context, builder: (context) => StudentEnrollmentFilterDialog(),);
      }
    },);
    super.initState();
  }


  double top=mdHeight(navigatorKey.currentContext!)*.9;
  double left=mdWidth(navigatorKey.currentContext!)*.65;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        _studentEnrollCubit.initFunction(StudentEnrollmentFilterModel());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocBuilder(
          bloc: _studentEnrollCubit,
          builder: (context,statebka) {
            return Column(
              children: [
                /// 🔹 TOP BAR
                CustomTopBar(text: "Student Enrollment",suffix:
            _authCubit.userModel!.role==UserRole.student?null:
                InkWell(
                    onTap: () {
                      showDialog(context: context, builder: (context) => StudentEnrollmentFilterDialog(),);
                    },
                    child: Stack(
                      children: [
                        Icon(Icons.filter_list,size: 20,color: AppColor.white,),
                        Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                          height: 5,
                          width: 5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.secondaryColor,
                          ),
                        ))
                      ],
                    )),),
                if(_studentRegisterCubit.dataList.isEmpty && _authCubit.userModel!.role!=UserRole.student)
                  Expanded(
                    child: DataNotFoundWidget(onTap: () async {
                      await _studentRegisterCubit.get();
                    },),
                  )
                else

                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal:screenPaddingHori),
                      child: Column(
                        children: [
                          if(_authCubit.userModel!.role==UserRole.admin || _authCubit.userModel!.role==UserRole.hod)
                          ...[SizedBox(height: 10,),
                          StudentEnrollmentTabs(),],
                          SizedBox(height: 10,),

                         if(!_studentEnrollCubit.isNewTab)
                          StudentEnrolledSection()
                          else if(_studentEnrollCubit.isNewTab &&DataExtractor.extractInt( _studentEnrollCubit.filterModel.semester)>1)
            StudentEnrollmentHistorySection()
                          else
            StudentNewAdmissionSection(),
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
      ),
    );
  }
}

final _authCubit=DiContainer().sl<AuthenticationCubit>();



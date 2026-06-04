import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/student_enrollment/presentation/widgets/move_next_dialog.dart';
import 'package:college_management/features/admin/student_enrollment/presentation/widgets/student_enrollment_filter_dialog.dart';
import 'package:college_management/features/admin/student_enrollment/presentation/widgets/student_enrollment_tabs.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../widgets/enrolled_student_widget.dart';



class StudentEnrollmentScreen extends StatefulWidget {
  const StudentEnrollmentScreen({super.key});

  @override
  State<StudentEnrollmentScreen> createState() =>
      _StudentEnrollmentScreenState();
}

class _StudentEnrollmentScreenState extends State<StudentEnrollmentScreen> {

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showDialog(context: context, builder: (context) => StudentEnrollmentFilterDialog(),);

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
      body: Column(
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
                    ...List.generate(5, (index) => EnrolledStudentWidget(),),
                    SafeArea(
                        top: false,
                        child: SizedBox(height: 40,)),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}





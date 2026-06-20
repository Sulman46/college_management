import 'package:college_management/core/helper/data_extractor.dart';
import 'package:college_management/core/helper/date_to_string_helper.dart';
import 'package:college_management/features/admin/semesters/models/semester_levels_model.dart';
import 'package:college_management/widgets/active_inactive_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/confirmation_dialog.dart';
import '../../../../../widgets/custom_animated_dialog.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';
import '../controller/cubit.dart';

class ProgramTimelineCard extends StatelessWidget {

 SemesterLevelsModel semesterLevelsModel;
   ProgramTimelineCard({
    super.key,
    required this.semesterLevelsModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      padding: EdgeInsets.all(15),
      decoration: AppColor.containerNeon,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ActiveInactiveStatusWidget(isActive:semesterLevelsModel.status=="Active"),
              CustomPopMenuButton(
                menus: ["Edit",semesterLevelsModel.status=="Active"?"Inactive":"Active","Delete"],
                onSelected: (value) async{
                  var semesterCubit=DiContainer().sl<SemesterAdminCubit>();
                  if(value==0){
                    context.push("/Admin-add-semester-screen",extra: semesterLevelsModel);
                  }else if(value==1){
                    var model=semesterLevelsModel;
                    model= model.copyWith(status: semesterLevelsModel.status=="Active"?"Inactive":"Active");
                    bool  val= await  semesterCubit.editSemester(model);
                  }else{
                    showDialog(context: context, builder: (context) => CustomAnimatedDialog(
                      child: ConfirmationDialog(
                        subText: "This Semester will be deleted permanently.",
                        onSubmit: () async {
                      bool val  =  await  semesterCubit.deleteSemester(semesterLevelsModel);
                          if(val){
                            Navigator.pop(context);
                          }
                        },),
                    ));
                  }
                },),
            ],
          ),
          SizedBox(height: 6),

          /// 🔹 TOP INFO ROW
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// LEFT SIDE
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    AppText(
                      text: semesterLevelsModel.programName??"",
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),

                    SizedBox(height: 4),

                    AppText(
                      text: "${semesterLevelsModel.department??""} •  ${semesterLevelsModel.degree??""} • ${semesterLevelsModel.section??""} • ${semesterLevelsModel.session}",
                      fontSize: 11,
                      color: AppColor.greyLight,
                    ),

                    SizedBox(height: 3),
                    AppText(
                      text: "${semesterLevelsModel.affiliation??""}",
                      fontSize: 11,
                      color: AppColor.greyLight,
                    ),

                    SizedBox(height: 3),

                  ],
                ),
              ),

            ],
          ),

          SizedBox(height: 8),

          /// 🔹 TIMELINE STEPPER
          StepperTimeline(currentStep:
          DataExtractor.extractInt(semesterLevelsModel.semesterName),
            totalSteps:8 ,),
          SizedBox(height: 5),
          Align(
            alignment: Alignment.center,
            child: AppText(
              text: "${DateToStringHelper.dateMonthYearConvert(semesterLevelsModel.startDate??DateTime.now())} - ${DateToStringHelper.dateMonthYearConvert(semesterLevelsModel.endDate??DateTime.now())}",
              fontSize: 11,
              color: AppColor.greyLight.withOpacity(.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class StepperTimeline extends StatelessWidget {
  final int currentStep;   // 🔥 active step
  final int totalSteps;    // 🔥 total steps

  const StepperTimeline({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(totalSteps * 2 - 1, (index) {

        // EVEN index → DOT
        if (index.isEven) {
          final stepIndex = index ~/ 2 + 1;

          final isActive = stepIndex == currentStep;
          final isCompleted = stepIndex < currentStep;

          return Column(
            children: [
              AppText(
                text: "S$stepIndex",
                fontSize: 8,
                color: AppColor.white,
              ),
              Container(
                width: isActive ? 14 : 10,
                height: isActive ? 14 : 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive
                      ? AppColor.primary
                      : isCompleted
                      ? AppColor.primary.withOpacity(.5)
                      : AppColor.greyLight1,
                  boxShadow: isActive
                      ? [
                    BoxShadow(
                      color: AppColor.primary.withOpacity(.4),
                      blurRadius: 6,
                    )
                  ]
                      : [],
                ),
              ),
            ],
          );
        }

        // ODD index → LINE
        final leftStep = (index ~/ 2) + 1;

        return Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            height: 2,
            color: leftStep < currentStep
                ? AppColor.primary.withOpacity(.5)
                : AppColor.greyLight1,
          ),
        );
      }),
    );
  }
}
import 'package:college_management/core/helper/date_to_string_helper.dart';
import 'package:college_management/features/admin/semesters/models/semester_levels_model.dart';
import 'package:college_management/widgets/active_inactive_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
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
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppColor.blackShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ActiveInactiveStatusWidget(isActive:semesterLevelsModel.status=="Active"),
              CustomPopMenuButton(
                menus: ["Edit","Delete"],
                onSelected: (value) async{
                  if(value==0){
                    context.push("/Admin-add-semester-screen",extra: semesterLevelsModel);
                  }else{
                    var _semesterCubit=DiContainer().sl<SemesterAdminCubit>();
                  await  _semesterCubit.deleteSemester(semesterLevelsModel);
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
                      color: AppColor.grey,
                    ),

                    SizedBox(height: 3),
                    AppText(
                      text: "${semesterLevelsModel.affiliation??""}",
                      fontSize: 11,
                      color: AppColor.grey,
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
          semesterLevelsModel.semesterName=="S1"?1:
          semesterLevelsModel.semesterName=="S2"?2:
          semesterLevelsModel.semesterName=="S3"?3:
          semesterLevelsModel.semesterName=="S4"?4:
          semesterLevelsModel.semesterName=="S5"?5:
          semesterLevelsModel.semesterName=="S6"?6:
          semesterLevelsModel.semesterName=="S7"?7:
          semesterLevelsModel.semesterName=="S8"?8:0,
            totalSteps:8 ,),
          SizedBox(height: 5),
          Align(
            alignment: Alignment.center,
            child: AppText(
              text: "${DateToStringHelper.dateMonthYearConvert(semesterLevelsModel.startDate??DateTime.now())} - ${DateToStringHelper.dateMonthYearConvert(semesterLevelsModel.endDate??DateTime.now())}",
              fontSize: 11,
              color: AppColor.grey.withOpacity(.8),
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
                color: AppColor.grey,
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
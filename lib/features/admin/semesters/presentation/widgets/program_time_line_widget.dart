import 'package:college_management/widgets/active_inactive_status_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';

class ProgramTimelineCard extends StatelessWidget {
  final String session;
  final String degree;
  final String university;
  final String program;
  final String faculty;
  final String section;
  final int currentStep; // 🔥 IMPORTANT (1 → 8)
  final int totalSteps;
  final String status;
  final String semesterTime;

  const ProgramTimelineCard({
    super.key,
    required this.session,
    required this.degree,
    required this.university,
    required this.program,
    required this.faculty,
    required this.section,
    required this.currentStep,
    required this.totalSteps,
    required this.status,
    required this.semesterTime,
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
              ActiveInactiveStatusWidget(isActive: true),
              CustomPopMenuButton(
                menus: ["Edit","Delete"],
                onSelected: (value) {

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
                      text: program,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),

                    SizedBox(height: 4),

                    AppText(
                      text: "$faculty •  $degree • $section • $session",
                      fontSize: 11,
                      color: AppColor.grey,
                    ),

                    SizedBox(height: 3),
                    AppText(
                      text: "$university",
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
          StepperTimeline(currentStep: currentStep,totalSteps:totalSteps ,),
          SizedBox(height: 5),
          Align(
            alignment: Alignment.center,
            child: AppText(
              text: semesterTime,
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
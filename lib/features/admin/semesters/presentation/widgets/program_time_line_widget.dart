import 'package:college_management/core/helper/data_extractor.dart';
import 'package:college_management/core/helper/date_to_string_helper.dart';
import 'package:college_management/features/admin/semesters/models/semester_levels_model.dart';
import 'package:college_management/features/admin/semesters/presentation/widgets/create_next_semester_dialog.dart';
import 'package:college_management/widgets/active_inactive_status_widget.dart';
import 'package:flutter/material.dart';
import '../../../../../core/app/di_container.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/confirmation_dialog.dart';
import '../../../../../widgets/custom_animated_dialog.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';
import '../controller/cubit.dart';

class ProgramTimelineCard extends StatelessWidget {

 List<SemesterLevelsModel> semesterLevelsModel;
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
              ActiveInactiveStatusWidget(isActive:semesterLevelsModel.last.status=="Active"),
              if(_semesterCubit.isEdit)
              CustomPopMenuButton(
                menus: [if(DataExtractor.extractInt(semesterLevelsModel.last.semesterName??"0")!=8) "Create Next",semesterLevelsModel.last.status=="Active"?"Inactive":"Active","Delete"],
                onSelected: (value) async{
                  var selectedVal=["Create Next",semesterLevelsModel.last.status=="Active"?"Inactive":"Active","Delete"][value];
                  var semesterCubit=DiContainer().sl<SemesterAdminCubit>();
                  if(selectedVal=="Create Next"){
                    showDialog(context: context, builder: (context) => CustomAnimatedDialog(
                      child: ConfirmationDialog(
                        title: "Are you sure you want to create the next semester?",
                        subText: "This action will automatically activate the new semester and set the current semester to inactive.",
                        submitText: "Confirm",
                        onSubmit: () async {
                          _semesterCubit.getNextSemesterModel(SemesterLevelsModel(semesterName: "${DataExtractor.extractInt(semesterLevelsModel.last.semesterName??"0")+1}",programModel: semesterLevelsModel.last.programModel,programId: semesterLevelsModel.last.programId,status: "Active",));
                          Navigator.pop(context);

                          showDialog(context: context, builder: (context) => CustomAnimatedDialog(child: CreateNextSemesterDialog(semesterList: semesterLevelsModel,)),);
                        },),
                    ));
                  }
                  else  if(selectedVal=="Active" || selectedVal=="Inactive"){
                    var model=semesterLevelsModel.last;
                    model= model.copyWith(status: semesterLevelsModel.last.status=="Active"?"Inactive":"Active");
                    bool  val= await  semesterCubit.editSemester(model);
                    if(val){
                     await semesterCubit.getSemesterList();
                    }
                  }
                    else if(selectedVal=="Delete"){
                    showDialog(context: context, builder: (context) => CustomAnimatedDialog(
                      child: ConfirmationDialog(
                        subText: "This Semester will be deleted permanently.",
                        onSubmit: () async {
                      bool val  =  await  semesterCubit.deleteSemester(semesterLevelsModel.last);
                          if(val){
                            Navigator.pop(context);
                              await semesterCubit.getSemesterList();
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

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    AppText(
                      text: semesterLevelsModel.last.programModel?.name??"",
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),

                    SizedBox(height: 4),

                    AppText(
                      text: "${semesterLevelsModel.last.programModel?.departmentName??""} •  ${semesterLevelsModel.last.programModel?.degree??""} • ${semesterLevelsModel.last.programModel?.section??""} • ${semesterLevelsModel.last.programModel?.session}",
                      fontSize: 11,
                      color: AppColor.greyLight,
                    ),

                    SizedBox(height: 3),
                    AppText(
                      text: semesterLevelsModel.last.programModel?.affiliationName??"",
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
          DataExtractor.extractInt(semesterLevelsModel.last.semesterName),
            totalSteps:8 ,semesterModel: semesterLevelsModel,),
          SizedBox(height: 5),
          if(semesterLevelsModel.where((element) => element.status=="Active",).isNotEmpty)
          Align(
            alignment: Alignment.center,
            child: AppText(
              text: "${DateToStringHelper.dateMonthYearConvert(semesterLevelsModel.where((element) => element.status=="Active",).first.startDate??DateTime.now())} - ${DateToStringHelper.dateMonthYearConvert(semesterLevelsModel.where((element) => element.status=="Active",).first.endDate??DateTime.now())}",
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
  List<SemesterLevelsModel> semesterModel;

   StepperTimeline({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.semesterModel,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(totalSteps * 2 - 1, (index) {

        // EVEN index → DOT
        if (index.isEven) {
          final stepIndex = index ~/ 2 + 1;

          final list=semesterModel.where(
                (e) => DataExtractor.extractInt(e.semesterName ?? "0") == stepIndex,
          );
          SemesterLevelsModel? semester = list.isNotEmpty?list.first:null;

          final bool isIncluded = semester!=null;
          final bool isActive = semester?.status == "Active";

          return InkWell(
            onTap:_semesterCubit.isEdit && stepIndex<=currentStep? () {

              if(semester!=null){
                _semesterCubit.getNextSemesterModel(semester);
                showDialog(context: context,
                  builder: (context) => CustomAnimatedDialog(
                      child: CreateNextSemesterDialog(
                          semesterList: semesterModel
                      )),);
              }else{

                // print('32432: // ${stepIndex}//');
                var dataModel=SemesterLevelsModel(semesterName: stepIndex.toString(),status: "Inactive",programId: semesterModel.first.programId,programModel: semesterModel.first.programModel);
                // print('32432: // ${stepIndex}// ${dataModel.toMap()}');
                // if(semester==null){
                //   return;
                // }
                _semesterCubit.getNextSemesterModel(dataModel);
                showDialog(context: context, builder: (context) => CustomAnimatedDialog(child: CreateNextSemesterDialog(semesterList: semesterModel)),);
              }
            }:null,
            child: Column(
              children: [
                AppText(
                  text:semester!=null? "S${DataExtractor.extractInt(semester.semesterName)}":"S$stepIndex",
                  fontSize: 8,
                  color: AppColor.white,
                ),
                Container(
                  width: isActive ? 14 : 10,
                  height: isActive ? 14 : 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:isActive? AppColor.blueLight: !isIncluded
                        ? AppColor.greyLight1 // Not created
                        : AppColor.primary,   // Created (Active/Inactive)
                    boxShadow: isActive
                        ? [
                      BoxShadow(
                        color: AppColor.blueLight.withOpacity(.8),
                        blurRadius: 6,
                      ),
                    ]
                        : [],
                  ),
                  child: _semesterCubit.isEdit  && stepIndex<=currentStep?Icon(Icons.edit,size:7,color:isIncluded? AppColor.white:AppColor.primary,):null,
                ),
              ],
            ),
          );
        }

// ODD index → LINE
        final rightStep = (index ~/ 2) + 2;

        final rightSemester = semesterModel.cast<SemesterLevelsModel?>().firstWhere(
              (e) => DataExtractor.extractInt(e?.semesterName ?? "0") == rightStep,
          orElse: () => null,
        );

        final bool isIncluded = rightSemester != null;
        final bool isActive = rightSemester?.status == "Active";

        return Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            height: 2,
            color: isActive
                ? AppColor.blueLight.withOpacity(.4)
                : isIncluded
                ? AppColor.primary.withOpacity(.6)
                : AppColor.greyLight1,
          ),
        );
      }),
    );
  }
}



final _semesterCubit=DiContainer().sl<SemesterAdminCubit>();

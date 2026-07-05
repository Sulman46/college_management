import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/exam_schedule/models/exam_schedule_widget_model.dart';
import 'package:college_management/features/admin/exam_schedule/presentation/widgets/exam_schedule_widget.dart';
import 'package:college_management/features/admin/student_result/presentation/widgets/student_result_widget.dart';
import 'package:college_management/widgets/custom_button.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:college_management/widgets/data_not_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app/di_container.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_text_form.dart';
import '../../../semesters/presentation/controller/cubit.dart';
import '../controller/cubit.dart';
import '../widgets/filter_exam_schedule_dialog.dart';


class ExamScheduleScreen extends StatefulWidget {
  const ExamScheduleScreen({super.key});

  @override
  State<ExamScheduleScreen> createState() => _ExamScheduleScreenState();
}

class _ExamScheduleScreenState extends State<ExamScheduleScreen> {
  final _semesterCubit=DiContainer().sl<SemesterAdminCubit>();

  final _examScheduleCubit=DiContainer().sl<ExamScheduleCubit>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      _examScheduleCubit.dataInit();

      await _semesterCubit.getSemesterList();
      showDialog(context: context, builder: (context) => FilterExamScheduleDialog(),);
    },);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
          bloc: _examScheduleCubit,
          builder: (context,stateMarking) {
            return Column(
              children: [
                CustomTopBar(text: "Exam Schedule",suffix: InkWell(
                    onTap: () {
                      showDialog(context: context, builder: (context) => FilterExamScheduleDialog(),);
                    },
                    child: Icon(Icons.filter_list,color: AppColor.white,size: 20,)),),
                Expanded(child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: screenPaddingHori),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(text: "Courses",fontSize: 12,color: AppColor.white,fontWeight: FontWeight.w500,),
                         _examScheduleCubit.examScheduleDataList.isEmpty? SizedBox()
                             :CustomElevatedButton(onPressed: ()async{
                               var response=await _examScheduleCubit.examScheduleUpdate();
                               if(response){
                                 await _examScheduleCubit.get();
                               }
                          },
                              width: 100,
                              height: 25,
                              fontSize: 11,
                              bgColor: AppColor.primary,
                              text: "Save"),
                        ],
                      ),
                      SizedBox(height: 5,),


                      if(_examScheduleCubit.examScheduleDataList.isNotEmpty)
                        ...List.generate(_examScheduleCubit.examScheduleDataList.length,
                              (index) =>ExamScheduleWidget(model: _examScheduleCubit.examScheduleDataList[index]),)

                      else if(_examScheduleCubit.submittedData.isAnyNull)
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppText(
                                text: "Try again",
                                color: AppColor.grey,
                              ),
                              SizedBox(height: 10,),
                              InkWell(
                                  onTap:(){
                                    showDialog(context: context, builder: (context) => FilterExamScheduleDialog(),);
                                  },
                                  child: Icon(Icons.refresh,size: 20,color: AppColor.primary,)),
                            ],
                          ),
                        )
                      else if(_examScheduleCubit.dataList.mappings.isEmpty)
                          DataNotFoundWidget(onTap: ()async{await _examScheduleCubit.get();}),

                      SafeArea(
                          top: false,
                          child: SizedBox(height: 20,)),


                    ],
                  ),
                ))
              ],
            );
          }
      ),
    );
  }
}

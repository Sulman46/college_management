import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/marking_student/models/marking_student_filter_model.dart';
import 'package:college_management/features/admin/marking_student/presentation/widgets/filter_marking_student_dialog.dart';
import 'package:college_management/features/admin/marking_student/presentation/widgets/marks_student_widget.dart';
import 'package:college_management/features/admin/programs/presentation/controller/cubit.dart';
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

class MarkingStudentScreen extends StatefulWidget {
  const MarkingStudentScreen({super.key});

  @override
  State<MarkingStudentScreen> createState() => _MarkingStudentScreenState();
}

class _MarkingStudentScreenState extends State<MarkingStudentScreen> {
  final _semesterCubit=DiContainer().sl<SemesterAdminCubit>();
  final _programCubit=DiContainer().sl<AdminProgramsCubit>();

  final _markingCubit=DiContainer().sl<MarkingStudentCubit>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      _markingCubit.dataInit();
      if(_programCubit.programsList.isEmpty){
        await _programCubit.getPrograms();
      }
      await _semesterCubit.getSemesterList();
      showDialog(context: context, builder: (context) => FilterMarkingStudentDialog(),);
    },);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        bloc: _markingCubit,
        builder: (context,stateMarking) {
          return BlocBuilder(
            bloc: _programCubit,
            builder: (context,styavkl) {
              return Column(
                children: [
                  CustomTopBar(text: "Marking",suffix: InkWell(
                      onTap: () {
                        showDialog(context: context, builder: (context) => FilterMarkingStudentDialog(),);
                      },
                      child: Icon(Icons.filter_list,color: AppColor.white,size: 20,)),),
                  Expanded(child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: screenPaddingHori),
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        CustomTextFormField(
                          controller: _markingCubit.searchController,
                          subTitle: "Search...",
                          isHintText: true,
                          onChanged: (p0) {
                            _markingCubit.getSearchText(p0.toLowerCase());
                          },
                          borderSize: 1,
                          contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                        ),
                        SizedBox(height: 10,),
                        if(_programCubit.programsList.isNotEmpty && _markingCubit.dataList.isNotEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomElevatedButton(
                              width: 100,
                              fontSize: 11,
                              onPressed: ()async{
                               var respo= await _markingCubit.lockStatus(lockVal: !_markingCubit.marksResponseModel.isLocked);
                               if(respo){
                                 await _markingCubit.getMarksStudent();
                               }
                              },
                              bgColor:_markingCubit.marksResponseModel.isLocked?AppColor.blueLight: AppColor.red,
                              text:_markingCubit.marksResponseModel.isLocked?"Unlock": "Lock Sheet",
                              height: 25,
                            ),

                            if(!_markingCubit.marksResponseModel.isLocked)
                            CustomElevatedButton(
                                onPressed: () async {
                                  var respo= await _markingCubit.saveBulk();
                                  if(respo){
                                    await _markingCubit.getMarksStudent();
                                  }
                                },
                                text: "Save All Marks",
                              fontSize: 11,
                              height: 25,
                              width: 100,
                            ),
                          ],
                        ),

                        if(_programCubit.programsList.isNotEmpty && _markingCubit.dataList.where((element) => element.name.toString().toLowerCase().contains(_markingCubit.filterName.toLowerCase()),).isNotEmpty)
                        ...List.generate(_markingCubit.dataList.where((element) => element.name.toString().toLowerCase().contains(_markingCubit.filterName.toLowerCase()),).length, (index) => MarksStudentWidget(model: _markingCubit.dataList.where((element) => element.name.toString().toLowerCase().contains(_markingCubit.filterName.toLowerCase()),).toList()[index],),)
                        else if(_programCubit.programsList.isEmpty)
                          DataNotFoundWidget(onTap: ()async{await _programCubit.getPrograms();})
                          else if(_markingCubit.submittedData.isAnyNull)
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
                                        showDialog(context: context, builder: (context) => FilterMarkingStudentDialog(),);
                                      },
                                      child: Icon(Icons.refresh,size: 20,color: AppColor.primary,)),
                                ],
                              ),
                            )
                         else if(_markingCubit.dataList.where((element) => element.name.toString().toLowerCase().contains(_markingCubit.filterName.toLowerCase()),).isEmpty)
                            DataNotFoundWidget(onTap: ()async{await _markingCubit.getMarksStudent();}),

                        SafeArea(
                            top: false,
                            child: SizedBox(height: 20,)),


                      ],
                    ),
                  ))
                ],
              );
            }
          );
        }
      ),
    );
  }
}

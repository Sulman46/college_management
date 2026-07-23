import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/student_result/presentation/widgets/student_result_widget.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:college_management/widgets/data_not_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app/di_container.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_text_form.dart';
import '../../../semesters/presentation/controller/cubit.dart';
import '../controller/cubit.dart';
import '../widgets/filter_result_dialog.dart';


class StudentResultScreen extends StatefulWidget {
  const StudentResultScreen({super.key});

  @override
  State<StudentResultScreen> createState() => _StudentResultScreenState();
}

class _StudentResultScreenState extends State<StudentResultScreen> {
  final _semesterCubit=DiContainer().sl<SemesterAdminCubit>();

  final _studentResultCubit=DiContainer().sl<StudentResultCubit>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      _studentResultCubit.dataInit();

      await _semesterCubit.getSemesterList();
      showDialog(context: context, builder: (context) => FilterResultDialog(),);
    },);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
          bloc: _studentResultCubit,
          builder: (context,stateMarking) {
            return Column(
              children: [
                CustomTopBar(text: "Result",suffix: InkWell(
                    onTap: () {
                      showDialog(context: context, builder: (context) => FilterResultDialog(),);
                    },
                    child: Icon(Icons.filter_list,color: AppColor.white,size: 20,)),),
                Expanded(child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: screenPaddingHori),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      CustomTextFormField(
                        controller: _studentResultCubit.searchController,
                        subTitle: "Search...",
                        isHintText: true,
                        onChanged: (p0) {
                          _studentResultCubit.getSearchText(p0.toLowerCase());
                        },
                        borderSize: 1,
                        contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                      ),
                      SizedBox(height: 10,),


                      if(_studentResultCubit.dataList.where((element) => element.studentName!.toLowerCase().contains(_studentResultCubit.filterName.toLowerCase())||element.rollNo!.toLowerCase().contains(_studentResultCubit.filterName.toLowerCase()),).toList().isNotEmpty)
                        ...List.generate(_studentResultCubit.dataList.where((element) => element.studentName!.toLowerCase().contains(_studentResultCubit.filterName.toLowerCase())||element.rollNo!.toLowerCase().contains(_studentResultCubit.filterName.toLowerCase()),).toList().length,
                              (index) => StudentResultWidget(model: _studentResultCubit.dataList.where((element) => element.studentName!.toLowerCase().contains(_studentResultCubit.filterName.toLowerCase())||element.rollNo!.toLowerCase().contains(_studentResultCubit.filterName.toLowerCase()),).toList()[index],),)

                      else if(_studentResultCubit.submittedData.isAnyNull)
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
                                      showDialog(context: context, builder: (context) => FilterResultDialog(),);
                                    },
                                    child: Icon(Icons.refresh,size: 20,color: AppColor.primary,)),
                              ],
                            ),
                          )
                        else if(_studentResultCubit.dataList.where((element) => element.studentName.toString().toLowerCase().contains(_studentResultCubit.filterName.toLowerCase()),).isEmpty)
                            DataNotFoundWidget(onTap: ()async{await _studentResultCubit.getResult();}),

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

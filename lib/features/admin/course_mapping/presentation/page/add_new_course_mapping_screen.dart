import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/constants/media_query.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/course_mapping/model/course_mapping_model.dart';
import 'package:college_management/features/admin/course_mapping/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/course_mapping/presentation/controller/mapping_helper.dart';
import 'package:college_management/features/admin/semesters/presentation/controller/cubit.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/app/di_container.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_top_bar.dart';
import '../../../course_catalog/presentation/controller/cubit.dart';

class AddNewCourseMappingScreen extends StatefulWidget {
   AddNewCourseMappingScreen({super.key,this.updateCourseMapping});
  CourseMappingModel? updateCourseMapping;

  @override
  State<AddNewCourseMappingScreen> createState() => _AddNewCourseMappingScreenState();
}

class _AddNewCourseMappingScreenState extends State<AddNewCourseMappingScreen> {
  final _courseCatalogCubit=DiContainer().sl<CourseCatalogAdminCubit>();
  final _semesterCubit=DiContainer().sl<SemesterAdminCubit>();
  final _courseMappingCubit=DiContainer().sl<CourseMappingCubit>();



  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(widget.updateCourseMapping!=null){
        _courseMappingCubit.updateModel(widget.updateCourseMapping!);
      }else{
        _courseMappingCubit.getCourseMappingModel(CourseMappingModel());
      }
    },);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgPrimary,
      body: BlocBuilder(
        bloc: _courseMappingCubit,
        builder: (context,statesbkl) {
          return Column(
            children: [
              CustomTopBar(text: "New Mapping"),


              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal:screenPaddingHori,vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// 🔹 HEADER TEXT
                      AppText(
                        text: "Create New Course Mapping",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),

                      SizedBox(height: 5),

                      AppText(
                        text: "Fill all required details to map course with program",
                        fontSize: 11,
                        color: AppColor.grey,
                      ),

                      SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: BlocBuilder(
                              bloc: _semesterCubit,
                              builder: (context,statesnkkl) {
                                return _semesterCubit.activeSemesterList.isNotEmpty?
                                CustomPopMenuButton(
                                  menus: List.from(_semesterCubit.activeSemesterList.map((e) => e.programModel?.departmentName??"").toSet().toList()),
                                  onSelected: (p0) {
                                    CourseMappingModel model=CourseMappingModel(departmentName: List.from(_semesterCubit.activeSemesterList.map((e) => e.programModel?.departmentName??"").toSet().toList())[p0]);
                                    _courseMappingCubit.getCourseMappingModel(model);
                                  },
                                  offset: Offset(0, 30),widget: SizedBox(
                                    width: mdWidth(context),
                                    child: DropDownFieldWidget(
                                        title:"Department :",
                                        text: _courseMappingCubit.courseMappingModel.departmentName??"Select..",maxLine: 1, isFilled: _courseMappingCubit.courseMappingModel.departmentName!=null)),):
                                InkWell(
                                  onTap: () async{
                                    await _semesterCubit.getSemesterList();
                                  },
                                  child: DropDownFieldWidget(
                                      title:"Department :",
                                      text: _courseMappingCubit.courseMappingModel.departmentName!=null? _courseMappingCubit.courseMappingModel.departmentName??"":"depart..",maxLine: 1, isFilled: _courseMappingCubit.courseMappingModel.departmentName!=null),
                                );
                              }
                            ),
                          ),

                          SizedBox(width: 15),
                          Expanded(
                            child: BlocBuilder(
                              bloc: _semesterCubit,
                              builder: (context,statesbklljw) {
                                return _semesterCubit.activeSemesterList.isNotEmpty?
                                CustomPopMenuButton(
                                  menus: List.from(_semesterCubit.activeSemesterList.where((element) => element.programModel?.departmentName ==_courseMappingCubit.courseMappingModel.departmentName,).map((e) => e.programModel?.name,).toSet().toList()),
                                  onSelected: (p0) {
                                   String value= List.from(_semesterCubit.activeSemesterList.where((element) => element.programModel?.departmentName ==_courseMappingCubit.courseMappingModel.departmentName,).map((e) => e.programModel?.name,).toSet().toList())[p0];
                                   CourseMappingModel model=CourseMappingModel(departmentName: _courseMappingCubit.courseMappingModel.departmentName,programName: value);
                                   _courseMappingCubit.getCourseMappingModel(model);
                                 },
                                  offset: Offset(0, 30),widget: SizedBox(
                                    width: mdWidth(context),
                                    child: DropDownFieldWidget(
                                        title: "Program :",
                                        text:_courseMappingCubit.courseMappingModel.programName??"Select..",
                                        maxLine: 1, isFilled: _courseMappingCubit.courseMappingModel.programName!=null)),)
                                    : InkWell(
                                  onTap: () async{
                                   await _semesterCubit.getSemesterList();
                                  },
                                      child: DropDownFieldWidget(
                                      title: "Program :",
                                          text: _courseMappingCubit.courseMappingModel.programName!=null? _courseMappingCubit.courseMappingModel.programName??"":"Select..",
                                          maxLine: 1, isFilled: _courseMappingCubit.courseMappingModel.programName!=null),
                                    );
                              }
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: BlocBuilder(
                                bloc: _semesterCubit,
                                builder: (context,statklljw) {
                                  return _semesterCubit.activeSemesterList.isNotEmpty?
                                 CustomPopMenuButton(
                                   menus: List.from(_semesterCubit.activeSemesterList.where((element) => element.programModel?.departmentName ==_courseMappingCubit.courseMappingModel.departmentName && element.programModel?.name==_courseMappingCubit.courseMappingModel.programName,).map((e) => e.programModel?.affiliationName,).toSet().toList()),
                                   onSelected: (p0) {
                                   String value=List.from(_semesterCubit.activeSemesterList.where((element) => element.programModel?.departmentName ==_courseMappingCubit.courseMappingModel.departmentName && element.programModel?.name==_courseMappingCubit.courseMappingModel.programName,).map((e) => e.programModel?.affiliationName,).toSet().toList())[p0];
                                   CourseMappingModel model=CourseMappingModel(departmentName: _courseMappingCubit.courseMappingModel.departmentName,programName:_courseMappingCubit.courseMappingModel.programName,affiliationName:  value);
                                   _courseMappingCubit.getCourseMappingModel(model);

                                 },
                                   offset: Offset(0, 30),widget: SizedBox(
                                    width: mdWidth(context),
                                    child: DropDownFieldWidget(
                                        title: "Affiliation :",
                                        text:_courseMappingCubit.courseMappingModel.affiliationName!=null? _courseMappingCubit.courseMappingModel.affiliationName??"":"Select..",maxLine: 1, isFilled: _courseMappingCubit.courseMappingModel.affiliationName!=null)),)
                                      :InkWell(
                                    onTap: () async {
                                      await _semesterCubit.getSemesterList();

                                    },
                                        child: DropDownFieldWidget(
                                        title: "Affiliation :",
                                        text:_courseMappingCubit.courseMappingModel.affiliationName!=null? _courseMappingCubit.courseMappingModel.affiliationName??"":"Select..",maxLine: 1, isFilled: _courseMappingCubit.courseMappingModel.affiliationName!=null
                                                                          ),
                                      );
                                }
                            ),
                          ),

                          SizedBox(width: 15),
                          Expanded(
                            child: BlocBuilder(
                                bloc: _semesterCubit,
                                builder: (context,statklljw) {
                                  return _semesterCubit.activeSemesterList.isNotEmpty?
                                  CustomPopMenuButton(
                                    menus: List.from(_semesterCubit.activeSemesterList.where((element) => element.programModel?.departmentName ==_courseMappingCubit.courseMappingModel.departmentName && element.programModel?.name==_courseMappingCubit.courseMappingModel.programName && element.programModel?.affiliationName==_courseMappingCubit.courseMappingModel.affiliationName,).map((e) => e.programModel?.degree,).toSet().toList()),
                                    onSelected: (p0) {
                                      String value=List.from(_semesterCubit.activeSemesterList.where((element) => element.programModel?.departmentName ==_courseMappingCubit.courseMappingModel.departmentName && element.programModel?.name==_courseMappingCubit.courseMappingModel.programName && element.programModel?.affiliationName==_courseMappingCubit.courseMappingModel.affiliationName,).map((e) => e.programModel?.degree,).toSet().toList())[p0];
                                      CourseMappingModel model=CourseMappingModel(departmentName: _courseMappingCubit.courseMappingModel.departmentName,programName:_courseMappingCubit.courseMappingModel.programName,affiliationName:  _courseMappingCubit.courseMappingModel.affiliationName,degree:value);
                                      _courseMappingCubit.getCourseMappingModel(model);

                                    },
                                    offset: Offset(0, 30),widget: SizedBox(
                                      width: mdWidth(context),
                                      child: DropDownFieldWidget(
                                          title: "Degree :",
                                          text:_courseMappingCubit.courseMappingModel.degree!=null? _courseMappingCubit.courseMappingModel.degree??"":"Select..",maxLine: 1, isFilled: _courseMappingCubit.courseMappingModel.degree!=null)),)
                                      :InkWell(
                                    onTap: () async {
                                      await _semesterCubit.getSemesterList();

                                    },
                                        child: DropDownFieldWidget(
                                        title: "Degree :",
                                        text:_courseMappingCubit.courseMappingModel.degree!=null? _courseMappingCubit.courseMappingModel.degree??"":"Select..",maxLine: 1, isFilled: _courseMappingCubit.courseMappingModel.degree!=null
                                                                          ),
                                      );
                                }
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 15),
                      BlocBuilder(
                          bloc: _semesterCubit,
                          builder: (context,statsklljw) {
                          return Row(
                            children: [
                              Expanded(
                                child: _semesterCubit.activeSemesterList.isNotEmpty?
                                CustomPopMenuButton(
                                  menus:List.from(_semesterCubit.activeSemesterList.where((element) => element.programModel?.departmentName ==_courseMappingCubit.courseMappingModel.departmentName && element.programModel?.name==_courseMappingCubit.courseMappingModel.programName && element.programModel?.affiliationName==_courseMappingCubit.courseMappingModel.affiliationName && element.programModel?.degree==_courseMappingCubit.courseMappingModel.degree,).map((e) => e.programModel?.session,).toSet().toList()),
                                  onSelected: (p0) {
                                    String value=List.from(_semesterCubit.activeSemesterList.where((element) => element.programModel?.departmentName ==_courseMappingCubit.courseMappingModel.departmentName && element.programModel?.name==_courseMappingCubit.courseMappingModel.programName && element.programModel?.affiliationName==_courseMappingCubit.courseMappingModel.affiliationName && element.programModel?.degree==_courseMappingCubit.courseMappingModel.degree,).map((e) => e.programModel?.session,).toSet().toList())[p0];
                                    CourseMappingModel model=CourseMappingModel(departmentName: _courseMappingCubit.courseMappingModel.departmentName,programName:_courseMappingCubit.courseMappingModel.programName,affiliationName:  _courseMappingCubit.courseMappingModel.affiliationName,degree:_courseMappingCubit.courseMappingModel.degree,session: value);
                                    _courseMappingCubit.getCourseMappingModel(model);

                                  },
                                  offset: Offset(0, 30),widget: SizedBox(
                                    width: mdWidth(context),
                                    child: DropDownFieldWidget(
                                        title: "Session :",
                                        text:_courseMappingCubit.courseMappingModel.session!=null? _courseMappingCubit.courseMappingModel.session??"":"Select..",maxLine: 1, isFilled: _courseMappingCubit.courseMappingModel.session!=null)),)
                                    :InkWell(
                                  onTap: () async {
                                    await _semesterCubit.getSemesterList();

                                  },
                                      child: DropDownFieldWidget(
                                      title: "Session :",
                                      text:_courseMappingCubit.courseMappingModel.session!=null? _courseMappingCubit.courseMappingModel.session??"":"Select..",maxLine: 1, isFilled: _courseMappingCubit.courseMappingModel.session!=null
                                                                      ),
                                    ),
                              ),

                              SizedBox(width: 15),
                              Expanded(
                                child:_semesterCubit.activeSemesterList.isNotEmpty?
                                CustomPopMenuButton(
                                  menus:List.from(_semesterCubit.activeSemesterList.where((element) => element.programModel?.departmentName ==_courseMappingCubit.courseMappingModel.departmentName && element.programModel?.name==_courseMappingCubit.courseMappingModel.programName && element.programModel?.affiliationName==_courseMappingCubit.courseMappingModel.affiliationName && element.programModel?.degree==_courseMappingCubit.courseMappingModel.degree && element.programModel?.session==_courseMappingCubit.courseMappingModel.session,).map((e) => e.programModel?.section,).toSet().toList()),
                                  onSelected: (p0) {
                                    String value=List.from(_semesterCubit.activeSemesterList.where((element) => element.programModel?.departmentName ==_courseMappingCubit.courseMappingModel.departmentName && element.programModel?.name==_courseMappingCubit.courseMappingModel.programName && element.programModel?.affiliationName==_courseMappingCubit.courseMappingModel.affiliationName && element.programModel?.degree==_courseMappingCubit.courseMappingModel.degree && element.programModel?.session==_courseMappingCubit.courseMappingModel.session,).map((e) => e.programModel?.section,).toSet().toList())[p0];
                                    CourseMappingModel model=CourseMappingModel(departmentName: _courseMappingCubit.courseMappingModel.departmentName,programName:_courseMappingCubit.courseMappingModel.programName,affiliationName:  _courseMappingCubit.courseMappingModel.affiliationName,degree:_courseMappingCubit.courseMappingModel.degree,session: _courseMappingCubit.courseMappingModel.session,section:value);
                                    _courseMappingCubit.getCourseMappingModel(model);

                                  },
                                  offset: Offset(0, 30),widget: SizedBox(
                                    width: mdWidth(context),
                                    child: DropDownFieldWidget(
                                        title: "Section :",
                                        text:_courseMappingCubit.courseMappingModel.section!=null? _courseMappingCubit.courseMappingModel.section??"":"Select..",maxLine: 1, isFilled: _courseMappingCubit.courseMappingModel.section!=null)),)
                                    :InkWell(
                                  onTap: () async {
                                    await _semesterCubit.getSemesterList();

                                  },
                                      child: DropDownFieldWidget(
                                      title: "Section :",
                                      text:_courseMappingCubit.courseMappingModel.section!=null? _courseMappingCubit.courseMappingModel.section??"":"Select..",maxLine: 1, isFilled: _courseMappingCubit.courseMappingModel.section!=null
                                                                      ),
                                    ),
                              ),
                            ],
                          );
                        }
                      ),

                      SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: BlocBuilder(
                              bloc: _semesterCubit,
                              builder: (context,statesbkl) {
                                return _semesterCubit.activeSemesterList.isNotEmpty? CustomPopMenuButton(menus:List.from(_semesterCubit.activeSemesterList.where((element) => element.programModel?.departmentName ==_courseMappingCubit.courseMappingModel.departmentName && element.programModel?.name==_courseMappingCubit.courseMappingModel.programName && element.programModel?.affiliationName==_courseMappingCubit.courseMappingModel.affiliationName && element.programModel?.degree==_courseMappingCubit.courseMappingModel.degree&& element.programModel?.session==_courseMappingCubit.courseMappingModel.session&& element.programModel?.section==_courseMappingCubit.courseMappingModel.section,).map((e) => e.semesterName,).toSet().toList()),
                                  onSelected: (p0) {
                                  String semesterName=List.from(_semesterCubit.activeSemesterList.where((element) => element.programModel?.departmentName ==_courseMappingCubit.courseMappingModel.departmentName && element.programModel?.name==_courseMappingCubit.courseMappingModel.programName && element.programModel?.affiliationName==_courseMappingCubit.courseMappingModel.affiliationName && element.programModel?.degree==_courseMappingCubit.courseMappingModel.degree&& element.programModel?.session==_courseMappingCubit.courseMappingModel.session&& element.programModel?.section==_courseMappingCubit.courseMappingModel.section,).map((e) => e.semesterName,).toSet().toList())[p0];
                                  String semesterId=List.from(_semesterCubit.activeSemesterList.where((element) => element.programModel?.departmentName ==_courseMappingCubit.courseMappingModel.departmentName && element.programModel?.name==_courseMappingCubit.courseMappingModel.programName && element.programModel?.affiliationName==_courseMappingCubit.courseMappingModel.affiliationName && element.programModel?.degree==_courseMappingCubit.courseMappingModel.degree&& element.programModel?.session==_courseMappingCubit.courseMappingModel.session&& element.programModel?.section==_courseMappingCubit.courseMappingModel.section&& element.semesterName==semesterName,).map((e) => e.id,).toSet().toList())[p0];
                                  CourseMappingModel model=CourseMappingModel(departmentName: _courseMappingCubit.courseMappingModel.departmentName,programName:_courseMappingCubit.courseMappingModel.programName,affiliationName:  _courseMappingCubit.courseMappingModel.affiliationName,degree:_courseMappingCubit.courseMappingModel.degree,session: _courseMappingCubit.courseMappingModel.session,section:_courseMappingCubit.courseMappingModel.section,
                                  semesterName: semesterName,semesterId: semesterId);
                                    _courseMappingCubit.getCourseMappingModel(model);
                                  },
                                  offset: Offset(0, 30),widget: SizedBox(
                                    width: mdWidth(context),
                                    child: DropDownFieldWidget(
                                        title: "Semester :",
                                        text: _courseMappingCubit.courseMappingModel.semesterName??"Select..",maxLine: 1, isFilled: _courseMappingCubit.courseMappingModel.semesterName!=null)),):
                                InkWell(
                                  onTap: () async {
                                    await _semesterCubit.getSemesterList();

                                  },
                                  child: DropDownFieldWidget(
                                      title: "Semester :",
                                      text: _courseMappingCubit.courseMappingModel.semesterName??"Select..",maxLine: 1, isFilled: _courseMappingCubit.courseMappingModel.semesterName!=null),
                                );
                              }
                            ),
                          ),

                          SizedBox(width: 15),
                          Expanded(
                            child: BlocBuilder(
                              bloc: _courseCatalogCubit,
                              builder: (context,statesbks) {
                                return _courseCatalogCubit.activeCourseCatalogList.isNotEmpty? CustomPopMenuButton(
                                  onSelected: (p0) {
                                    String name=_courseCatalogCubit.activeCourseCatalogList.map((e) => e.courseTitle??"",).toSet().toList()[p0];
                                    CourseMappingModel model=CourseMappingModel(semesterId: _courseMappingCubit.courseMappingModel.semesterId,departmentName: _courseMappingCubit.courseMappingModel.departmentName,programName:_courseMappingCubit.courseMappingModel.programName,affiliationName:  _courseMappingCubit.courseMappingModel.affiliationName,degree:_courseMappingCubit.courseMappingModel.degree,session: _courseMappingCubit.courseMappingModel.session,section:_courseMappingCubit.courseMappingModel.section,semesterName: _courseMappingCubit.courseMappingModel.semesterName,courseTitle:name,);
                                    _courseMappingCubit.getCourseMappingModel(model);
                                  },
                                  menus: _courseCatalogCubit.activeCourseCatalogList.map((e) => e.courseTitle??"",).toSet().toList(),
                                  offset: Offset(0, 30),widget: SizedBox(width: mdWidth(context),
                                    child: DropDownFieldWidget(
                                        title: "Course Name:",
                                        text:_courseMappingCubit.courseMappingModel.courseTitle?? "Select..",maxLine: 1, isFilled: _courseMappingCubit.courseMappingModel.courseTitle!=null)),):
                                InkWell(
                                  onTap: () async{
                                   await _courseCatalogCubit.getCourseCatalogList();
                                  },
                                  child: DropDownFieldWidget(
                                      title: "Course Name:",
                                      text:_courseMappingCubit.courseMappingModel.courseTitle?? "Select..",maxLine: 1, isFilled: _courseMappingCubit.courseMappingModel.courseTitle!=null),
                                );
                              }
                            ),
                          ),
                        ],
                      ),


                      SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: BlocBuilder(
                                bloc: _courseCatalogCubit,
                                builder: (context,statesbks) {
                                  return _courseCatalogCubit.activeCourseCatalogList.isNotEmpty? CustomPopMenuButton(
                                    onSelected: (p0) {
                                      String code=_courseCatalogCubit.activeCourseCatalogList.where((element) => element.courseTitle==_courseMappingCubit.courseMappingModel.courseTitle,).map((e) => e.courseCode??"",).toSet().toList()[p0];
                                      CourseMappingModel model=CourseMappingModel(semesterId: _courseMappingCubit.courseMappingModel.semesterId,courseCode: code,departmentName: _courseMappingCubit.courseMappingModel.departmentName,programName:_courseMappingCubit.courseMappingModel.programName,affiliationName:  _courseMappingCubit.courseMappingModel.affiliationName,degree:_courseMappingCubit.courseMappingModel.degree,session: _courseMappingCubit.courseMappingModel.session,section:_courseMappingCubit.courseMappingModel.section,semesterName: _courseMappingCubit.courseMappingModel.semesterName,courseTitle:_courseMappingCubit.courseMappingModel.courseTitle,);
                                      _courseMappingCubit.getCourseMappingModel(model);
                                    },
                                    menus: _courseCatalogCubit.activeCourseCatalogList.where((element) => element.courseTitle==_courseMappingCubit.courseMappingModel.courseTitle,).map((e) => e.courseCode??"",).toSet().toList(),
                                    offset: Offset(0, 30),widget: SizedBox(width: mdWidth(context),
                                      child: DropDownFieldWidget(
                                          title: "Course Code:",
                                          text:_courseMappingCubit.courseMappingModel.courseCode?? "Select..",maxLine: 1, isFilled: _courseMappingCubit.courseMappingModel.courseCode!=null)),):
                                  InkWell(
                                    onTap: () async{
                                      await _courseCatalogCubit.getCourseCatalogList();
                                    },
                                    child: DropDownFieldWidget(
                                        title: "Course Code:",
                                        text:_courseMappingCubit.courseMappingModel.courseCode?? "Select..",maxLine: 1, isFilled: _courseMappingCubit.courseMappingModel.courseCode!=null),
                                  );
                                }
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: BlocBuilder(
                                bloc: _courseCatalogCubit,
                                builder: (context,statesbks) {
                                  return _courseCatalogCubit.activeCourseCatalogList.isNotEmpty? CustomPopMenuButton(
                                    onSelected: (p0) {
                                      String type=_courseCatalogCubit.activeCourseCatalogList.where((element) => element.courseTitle==_courseMappingCubit.courseMappingModel.courseTitle && element.courseCode==_courseMappingCubit.courseMappingModel.courseCode,).map((e) => e.type??"",).toSet().toList()[p0];
                                      CourseMappingModel model=CourseMappingModel(semesterId: _courseMappingCubit.courseMappingModel.semesterId,courseCode: _courseMappingCubit.courseMappingModel.courseCode,courseType: type,departmentName: _courseMappingCubit.courseMappingModel.departmentName,programName:_courseMappingCubit.courseMappingModel.programName,affiliationName:  _courseMappingCubit.courseMappingModel.affiliationName,degree:_courseMappingCubit.courseMappingModel.degree,session: _courseMappingCubit.courseMappingModel.session,section:_courseMappingCubit.courseMappingModel.section,semesterName: _courseMappingCubit.courseMappingModel.semesterName,courseTitle:_courseMappingCubit.courseMappingModel.courseTitle,);
                                      _courseMappingCubit.getCourseMappingModel(model);
                                    },
                                    menus: _courseCatalogCubit.activeCourseCatalogList.where((element) => element.courseTitle==_courseMappingCubit.courseMappingModel.courseTitle && element.courseCode==_courseMappingCubit.courseMappingModel.courseCode,).map((e) => e.type??"",).toSet().toList(),
                                    offset: Offset(0, 30),widget: SizedBox(width: mdWidth(context),
                                      child: DropDownFieldWidget(
                                          title: "Course Type:",
                                          text:_courseMappingCubit.courseMappingModel.courseType?? "Select..",maxLine: 1, isFilled: _courseMappingCubit.courseMappingModel.courseType!=null)),):
                                  InkWell(
                                    onTap: () async{
                                      await _courseCatalogCubit.getCourseCatalogList();
                                    },
                                    child: DropDownFieldWidget(
                                        title: "Course Type:",
                                        text:_courseMappingCubit.courseMappingModel.courseType?? "Select..",maxLine: 1, isFilled: _courseMappingCubit.courseMappingModel.courseType!=null),
                                  );
                                }
                            ),
                          ),
                        ],
                      ),


                      SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: BlocBuilder(
                                bloc: _courseCatalogCubit,
                                builder: (context,statesbks) {
                                  return _courseCatalogCubit.activeCourseCatalogList.isNotEmpty? CustomPopMenuButton(
                                    onSelected: (p0) {
                                      String category=_courseCatalogCubit.activeCourseCatalogList.where((element) => element.courseTitle==_courseMappingCubit.courseMappingModel.courseTitle && element.courseCode==_courseMappingCubit.courseMappingModel.courseCode && element.type==_courseMappingCubit.courseMappingModel.courseType,).map((e) => e.category??"",).toSet().toList()[p0];
                                      CourseMappingModel model=CourseMappingModel(semesterId: _courseMappingCubit.courseMappingModel.semesterId,courseCategory: category,courseCode: _courseMappingCubit.courseMappingModel.courseCode,courseType: _courseMappingCubit.courseMappingModel.courseType,departmentName: _courseMappingCubit.courseMappingModel.departmentName,programName:_courseMappingCubit.courseMappingModel.programName,affiliationName:  _courseMappingCubit.courseMappingModel.affiliationName,degree:_courseMappingCubit.courseMappingModel.degree,session: _courseMappingCubit.courseMappingModel.session,section:_courseMappingCubit.courseMappingModel.section,semesterName: _courseMappingCubit.courseMappingModel.semesterName,courseTitle:_courseMappingCubit.courseMappingModel.courseTitle,);
                                      _courseMappingCubit.getCourseMappingModel(model);
                                    },
                                    menus: _courseCatalogCubit.activeCourseCatalogList.where((element) => element.courseTitle==_courseMappingCubit.courseMappingModel.courseTitle && element.courseCode==_courseMappingCubit.courseMappingModel.courseCode && element.type==_courseMappingCubit.courseMappingModel.courseType,).map((e) => e.category??"",).toSet().toList(),
                                    offset: Offset(0, 30),widget: SizedBox(width: mdWidth(context),
                                      child: DropDownFieldWidget(
                                          title: "Course Category:",
                                          text:_courseMappingCubit.courseMappingModel.courseCategory?? "Select..",maxLine: 1, isFilled: _courseMappingCubit.courseMappingModel.courseCategory!=null)),):
                                  InkWell(
                                    onTap: () async{
                                      await _courseCatalogCubit.getCourseCatalogList();
                                    },
                                    child: DropDownFieldWidget(
                                        title: "Course Category:",
                                        text:_courseMappingCubit.courseMappingModel.courseCategory?? "Select..",maxLine: 1, isFilled: _courseMappingCubit.courseMappingModel.courseCategory!=null),
                                  );
                                }
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: BlocBuilder(
                                bloc: _courseCatalogCubit,
                                builder: (context,statesbks) {
                                  return _courseCatalogCubit.activeCourseCatalogList.isNotEmpty? CustomPopMenuButton(
                                    onSelected: (p0) {
                                      double val=_courseCatalogCubit.activeCourseCatalogList.where((element) => element.courseTitle==_courseMappingCubit.courseMappingModel.courseTitle && element.courseCode==_courseMappingCubit.courseMappingModel.courseCode && element.type==_courseMappingCubit.courseMappingModel.courseType&& element.category==_courseMappingCubit.courseMappingModel.courseCategory,).map((e) => e.creditHours??0,).toSet().toList()[p0];
                                      String id=_courseCatalogCubit.activeCourseCatalogList.where((element) => element.courseTitle==_courseMappingCubit.courseMappingModel.courseTitle && element.courseCode==_courseMappingCubit.courseMappingModel.courseCode && element.type==_courseMappingCubit.courseMappingModel.courseType&& element.category==_courseMappingCubit.courseMappingModel.courseCategory&& element.creditHours==val,).map((e) => e.id??"",).toSet().toList()[p0];
                                      CourseMappingModel model=CourseMappingModel(semesterId: _courseMappingCubit.courseMappingModel.semesterId,status: "Active",courseId: id,creditHours: val,courseCategory: _courseMappingCubit.courseMappingModel.courseCategory,courseCode: _courseMappingCubit.courseMappingModel.courseCode,courseType: _courseMappingCubit.courseMappingModel.courseType,departmentName: _courseMappingCubit.courseMappingModel.departmentName,programName:_courseMappingCubit.courseMappingModel.programName,affiliationName:  _courseMappingCubit.courseMappingModel.affiliationName,degree:_courseMappingCubit.courseMappingModel.degree,session: _courseMappingCubit.courseMappingModel.session,section:_courseMappingCubit.courseMappingModel.section,semesterName: _courseMappingCubit.courseMappingModel.semesterName,courseTitle:_courseMappingCubit.courseMappingModel.courseTitle,);

                                      _courseMappingCubit.getCourseMappingModel(model);
                                    },
                                    menus: _courseCatalogCubit.activeCourseCatalogList.where((element) => element.courseTitle==_courseMappingCubit.courseMappingModel.courseTitle && element.courseCode==_courseMappingCubit.courseMappingModel.courseCode && element.type==_courseMappingCubit.courseMappingModel.courseType&& element.category==_courseMappingCubit.courseMappingModel.courseCategory,).map((e) => "${e.creditHours??""}",).toSet().toList(),
                                    offset: Offset(0, 30),widget: SizedBox(width: mdWidth(context),
                                      child: DropDownFieldWidget(
                                          title: "Credit Hours:",
                                          text:"${_courseMappingCubit.courseMappingModel.creditHours?? "Select.."}",maxLine: 1, isFilled: _courseMappingCubit.courseMappingModel.creditHours!=null)),):
                                  InkWell(
                                    onTap: () async{
                                      await _courseCatalogCubit.getCourseCatalogList();
                                    },
                                    child: DropDownFieldWidget(
                                        title: "Credit Hours:",
                                        text:"${_courseMappingCubit.courseMappingModel.creditHours?? "Select.."}",maxLine: 1, isFilled: _courseMappingCubit.courseMappingModel.creditHours!=null),
                                  );
                                }
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),

                      /// 🔹 BUTTON
                      Center(
                        child: CustomElevatedButton(
                          width: mdWidth(context)*.6,
                          onPressed: () async {
                            var dataModel=_courseMappingCubit.courseMappingModel;


                            if (
                            dataModel.departmentName == null ||
                                dataModel.programName == null ||
                                dataModel.degree == null ||
                                dataModel.affiliationName == null ||
                                dataModel.session == null ||
                                dataModel.section == null ||
                                dataModel.semesterName == null ||
                                dataModel.courseId == null ||
                                dataModel.courseTitle == null ||
                                dataModel.courseCode == null ||
                                dataModel.courseCategory == null ||
                                dataModel.courseType == null ||
                                dataModel.creditHours == null || dataModel.semesterId==null) {
                              showMessage("Please fill all fields",isError: true);
                              return;
                            }

                         var response=
                             widget.updateCourseMapping!=null?
                             await  _courseMappingCubit.update(dataModel)
                                 :
                         await  _courseMappingCubit.addMapping(dataModel);

                            if(response){
                              context.pop();
                              await _courseMappingCubit.getMappingData();

                            }
                          },
                          text:widget.updateCourseMapping!=null? "Update":"Save",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }

}
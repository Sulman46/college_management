import 'dart:developer';

import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/constants/media_query.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/course_mapping/model/course_mapping_model.dart';
import 'package:college_management/features/admin/course_mapping/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/semesters/presentation/controller/cubit.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../core/constants/constant_data.dart';
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
                                return _semesterCubit.semesterList.isNotEmpty?
                                CustomPopMenuButton(
                                  menus: List.from(_semesterCubit.semesterList.map((e) => e.department)),
                                  onSelected: (p0) {
                                    CourseMappingModel model=CourseMappingModel(department: List.from(_semesterCubit.semesterList.map((e) => e.department))[p0]);
                                    _courseMappingCubit.getCourseMappingModel(model);
                                  },
                                  offset: Offset(0, 30),widget: SizedBox(
                                    width: mdWidth(context),
                                    child: DropDownFieldWidget(
                                        title:"Department :",
                                        text: _courseMappingCubit.courseMappingModel.department??"Select..",maxLine: 1, isFilled: false)),):
                                InkWell(
                                  onTap: () async{
                                    await _semesterCubit.getSemesterList();
                                  },
                                  child: DropDownFieldWidget(
                                      title:"Department :",
                                      text: _courseMappingCubit.courseMappingModel.department!=null? _courseMappingCubit.courseMappingModel.department??"":"depart..",maxLine: 1, isFilled: false),
                                );
                              }
                            ),
                          ),

                          SizedBox(width: 15),
                          Expanded(
                            child: BlocBuilder(
                              bloc: _semesterCubit,
                              builder: (context,statesbklljw) {
                                return _semesterCubit.semesterList.isNotEmpty?
                                CustomPopMenuButton(
                                  menus: List.from(_semesterCubit.semesterList.where((element) => element.department ==_courseMappingCubit.courseMappingModel.department,).map((e) => e.programName,)),
                                  onSelected: (p0) {
                                   String value= List.from(_semesterCubit.semesterList.where((element) => element.department ==_courseMappingCubit.courseMappingModel.department,).map((e) => e.programName,))[p0];
                                   CourseMappingModel model=CourseMappingModel(department: _courseMappingCubit.courseMappingModel.department,program: value);
                                   _courseMappingCubit.getCourseMappingModel(model);
                                 },
                                  offset: Offset(0, 30),widget: SizedBox(
                                    width: mdWidth(context),
                                    child: DropDownFieldWidget(
                                        title: "Program :",
                                        text:_courseMappingCubit.courseMappingModel.program??"Select..",
                                        maxLine: 1, isFilled: false)),)
                                    : InkWell(
                                  onTap: () async{
                                   await _semesterCubit.getSemesterList();
                                  },
                                      child: DropDownFieldWidget(
                                      title: "Program :",
                                          text: _courseMappingCubit.courseMappingModel.program!=null? _courseMappingCubit.courseMappingModel.program??"":"Select..",
                                          maxLine: 1, isFilled: false),
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
                                  return _semesterCubit.semesterList.isNotEmpty?
                                 CustomPopMenuButton(
                                   menus: List.from(_semesterCubit.semesterList.where((element) => element.department ==_courseMappingCubit.courseMappingModel.department && element.programName==_courseMappingCubit.courseMappingModel.program,).map((e) => e.affiliation,)),
                                   onSelected: (p0) {
                                   String value=List.from(_semesterCubit.semesterList.where((element) => element.department ==_courseMappingCubit.courseMappingModel.department && element.programName==_courseMappingCubit.courseMappingModel.program,).map((e) => e.affiliation,))[p0];
                                   CourseMappingModel model=CourseMappingModel(department: _courseMappingCubit.courseMappingModel.department,program:_courseMappingCubit.courseMappingModel.program,affiliation:  value);
                                   _courseMappingCubit.getCourseMappingModel(model);

                                 },
                                   offset: Offset(0, 30),widget: SizedBox(
                                    width: mdWidth(context),
                                    child: DropDownFieldWidget(
                                        title: "Affiliation :",
                                        text:_courseMappingCubit.courseMappingModel.affiliation!=null? _courseMappingCubit.courseMappingModel.affiliation??"":"Select..",maxLine: 1, isFilled: false)),)
                                      :DropDownFieldWidget(
                                      title: "Affiliation :",
                                      text:_courseMappingCubit.courseMappingModel.affiliation!=null? _courseMappingCubit.courseMappingModel.affiliation??"":"Select..",maxLine: 1, isFilled: false
                                  );
                                }
                            ),
                          ),

                          SizedBox(width: 15),
                          Expanded(
                            child: BlocBuilder(
                                bloc: _semesterCubit,
                                builder: (context,statklljw) {
                                  return _semesterCubit.semesterList.isNotEmpty?
                                  CustomPopMenuButton(
                                    menus: List.from(_semesterCubit.semesterList.where((element) => element.department ==_courseMappingCubit.courseMappingModel.department && element.programName==_courseMappingCubit.courseMappingModel.program && element.affiliation==_courseMappingCubit.courseMappingModel.affiliation,).map((e) => e.degree,)),
                                    onSelected: (p0) {
                                      String value=List.from(_semesterCubit.semesterList.where((element) => element.department ==_courseMappingCubit.courseMappingModel.department && element.programName==_courseMappingCubit.courseMappingModel.program && element.affiliation==_courseMappingCubit.courseMappingModel.affiliation,).map((e) => e.degree,))[p0];
                                      CourseMappingModel model=CourseMappingModel(department: _courseMappingCubit.courseMappingModel.department,program:_courseMappingCubit.courseMappingModel.program,affiliation:  _courseMappingCubit.courseMappingModel.affiliation,degree:value);
                                      _courseMappingCubit.getCourseMappingModel(model);

                                    },
                                    offset: Offset(0, 30),widget: SizedBox(
                                      width: mdWidth(context),
                                      child: DropDownFieldWidget(
                                          title: "Degree :",
                                          text:_courseMappingCubit.courseMappingModel.degree!=null? _courseMappingCubit.courseMappingModel.degree??"":"Select..",maxLine: 1, isFilled: false)),)
                                      :DropDownFieldWidget(
                                      title: "Degree :",
                                      text:_courseMappingCubit.courseMappingModel.degree!=null? _courseMappingCubit.courseMappingModel.degree??"":"Select..",maxLine: 1, isFilled: false
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
                                child: _semesterCubit.semesterList.isNotEmpty?
                                CustomPopMenuButton(
                                  menus:List.from(_semesterCubit.semesterList.where((element) => element.department ==_courseMappingCubit.courseMappingModel.department && element.programName==_courseMappingCubit.courseMappingModel.program && element.affiliation==_courseMappingCubit.courseMappingModel.affiliation && element.degree==_courseMappingCubit.courseMappingModel.degree,).map((e) => e.session,)),
                                  onSelected: (p0) {
                                    String value=List.from(_semesterCubit.semesterList.where((element) => element.department ==_courseMappingCubit.courseMappingModel.department && element.programName==_courseMappingCubit.courseMappingModel.program && element.affiliation==_courseMappingCubit.courseMappingModel.affiliation && element.degree==_courseMappingCubit.courseMappingModel.degree,).map((e) => e.session,))[p0];
                                    CourseMappingModel model=CourseMappingModel(department: _courseMappingCubit.courseMappingModel.department,program:_courseMappingCubit.courseMappingModel.program,affiliation:  _courseMappingCubit.courseMappingModel.affiliation,degree:_courseMappingCubit.courseMappingModel.degree,session: value);
                                    _courseMappingCubit.getCourseMappingModel(model);

                                  },
                                  offset: Offset(0, 30),widget: SizedBox(
                                    width: mdWidth(context),
                                    child: DropDownFieldWidget(
                                        title: "Session :",
                                        text:_courseMappingCubit.courseMappingModel.session!=null? _courseMappingCubit.courseMappingModel.session??"":"Select..",maxLine: 1, isFilled: false)),)
                                    :DropDownFieldWidget(
                                    title: "Session :",
                                    text:_courseMappingCubit.courseMappingModel.session!=null? _courseMappingCubit.courseMappingModel.session??"":"Select..",maxLine: 1, isFilled: false
                                ),
                              ),

                              SizedBox(width: 15),
                              Expanded(
                                child:_semesterCubit.semesterList.isNotEmpty?
                                CustomPopMenuButton(
                                  menus:List.from(_semesterCubit.semesterList.where((element) => element.department ==_courseMappingCubit.courseMappingModel.department && element.programName==_courseMappingCubit.courseMappingModel.program && element.affiliation==_courseMappingCubit.courseMappingModel.affiliation && element.degree==_courseMappingCubit.courseMappingModel.degree && element.session==_courseMappingCubit.courseMappingModel.session,).map((e) => e.section,)),
                                  onSelected: (p0) {
                                    String value=List.from(_semesterCubit.semesterList.where((element) => element.department ==_courseMappingCubit.courseMappingModel.department && element.programName==_courseMappingCubit.courseMappingModel.program && element.affiliation==_courseMappingCubit.courseMappingModel.affiliation && element.degree==_courseMappingCubit.courseMappingModel.degree && element.session==_courseMappingCubit.courseMappingModel.session,).map((e) => e.section,))[p0];
                                    CourseMappingModel model=CourseMappingModel(department: _courseMappingCubit.courseMappingModel.department,program:_courseMappingCubit.courseMappingModel.program,affiliation:  _courseMappingCubit.courseMappingModel.affiliation,degree:_courseMappingCubit.courseMappingModel.degree,session: _courseMappingCubit.courseMappingModel.session,section:value);
                                    _courseMappingCubit.getCourseMappingModel(model);

                                  },
                                  offset: Offset(0, 30),widget: SizedBox(
                                    width: mdWidth(context),
                                    child: DropDownFieldWidget(
                                        title: "Section :",
                                        text:_courseMappingCubit.courseMappingModel.section!=null? _courseMappingCubit.courseMappingModel.section??"":"Select..",maxLine: 1, isFilled: false)),)
                                    :DropDownFieldWidget(
                                    title: "Section :",
                                    text:_courseMappingCubit.courseMappingModel.section!=null? _courseMappingCubit.courseMappingModel.section??"":"Select..",maxLine: 1, isFilled: false
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
                                return CustomPopMenuButton(menus:List.from(_semesterCubit.semesterList.where((element) => element.department ==_courseMappingCubit.courseMappingModel.department && element.programName==_courseMappingCubit.courseMappingModel.program && element.affiliation==_courseMappingCubit.courseMappingModel.affiliation && element.degree==_courseMappingCubit.courseMappingModel.degree&& element.session==_courseMappingCubit.courseMappingModel.session&& element.section==_courseMappingCubit.courseMappingModel.section,).map((e) => e.semesterName,)),
                                  onSelected: (p0) {
                                  String semesterName=List.from(_semesterCubit.semesterList.where((element) => element.department ==_courseMappingCubit.courseMappingModel.department && element.programName==_courseMappingCubit.courseMappingModel.program && element.affiliation==_courseMappingCubit.courseMappingModel.affiliation && element.degree==_courseMappingCubit.courseMappingModel.degree&& element.session==_courseMappingCubit.courseMappingModel.session&& element.section==_courseMappingCubit.courseMappingModel.section,).map((e) => e.semesterName,))[p0];
                                  String semesterId=List.from(_semesterCubit.semesterList.where((element) => element.department ==_courseMappingCubit.courseMappingModel.department && element.programName==_courseMappingCubit.courseMappingModel.program && element.affiliation==_courseMappingCubit.courseMappingModel.affiliation && element.degree==_courseMappingCubit.courseMappingModel.degree&& element.session==_courseMappingCubit.courseMappingModel.session&& element.section==_courseMappingCubit.courseMappingModel.section&& element.semesterName==semesterName,).map((e) => e.id,))[p0];
                                  CourseMappingModel model=CourseMappingModel(department: _courseMappingCubit.courseMappingModel.department,program:_courseMappingCubit.courseMappingModel.program,affiliation:  _courseMappingCubit.courseMappingModel.affiliation,degree:_courseMappingCubit.courseMappingModel.degree,session: _courseMappingCubit.courseMappingModel.session,section:_courseMappingCubit.courseMappingModel.section,
                                  semesterName: semesterName,semesterId: semesterId);
                                    _courseMappingCubit.getCourseMappingModel(model);
                                  },
                                  offset: Offset(0, 30),widget: SizedBox(
                                    width: mdWidth(context),
                                    child: DropDownFieldWidget(
                                        title: "Semester :",
                                        text: _courseMappingCubit.courseMappingModel.semesterName??"Select..",maxLine: 1, isFilled: false)),);
                              }
                            ),
                          ),

                          SizedBox(width: 15),
                          Expanded(
                            child: BlocBuilder(
                              bloc: _courseCatalogCubit,
                              builder: (context,statesbks) {
                                return _courseCatalogCubit.courseCatalogList.isNotEmpty? CustomPopMenuButton(
                                  onSelected: (p0) {
                                    String name=_courseCatalogCubit.courseCatalogList.map((e) => e.courseTitle??"",).toList()[p0];
                                    CourseMappingModel model=CourseMappingModel(semesterId: _courseMappingCubit.courseMappingModel.semesterId,department: _courseMappingCubit.courseMappingModel.department,program:_courseMappingCubit.courseMappingModel.program,affiliation:  _courseMappingCubit.courseMappingModel.affiliation,degree:_courseMappingCubit.courseMappingModel.degree,session: _courseMappingCubit.courseMappingModel.session,section:_courseMappingCubit.courseMappingModel.section,semesterName: _courseMappingCubit.courseMappingModel.semesterName,courseTitle:name,);
                                    _courseMappingCubit.getCourseMappingModel(model);
                                  },
                                  menus: _courseCatalogCubit.courseCatalogList.map((e) => e.courseTitle??"",).toList(),
                                  offset: Offset(0, 30),widget: SizedBox(width: mdWidth(context),
                                    child: DropDownFieldWidget(
                                        title: "Course Name:",
                                        text:_courseMappingCubit.courseMappingModel.courseTitle?? "Select..",maxLine: 1, isFilled: false)),):
                                InkWell(
                                  onTap: () async{
                                   await _courseCatalogCubit.getCourseCatalogList();
                                  },
                                  child: DropDownFieldWidget(
                                      title: "Course Name:",
                                      text:_courseMappingCubit.courseMappingModel.courseTitle?? "Select..",maxLine: 1, isFilled: false),
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
                                  return _courseCatalogCubit.courseCatalogList.isNotEmpty? CustomPopMenuButton(
                                    onSelected: (p0) {
                                      String code=_courseCatalogCubit.courseCatalogList.where((element) => element.courseTitle==_courseMappingCubit.courseMappingModel.courseTitle,).map((e) => e.courseCode??"",).toList()[p0];
                                      CourseMappingModel model=CourseMappingModel(semesterId: _courseMappingCubit.courseMappingModel.semesterId,courseCode: code,department: _courseMappingCubit.courseMappingModel.department,program:_courseMappingCubit.courseMappingModel.program,affiliation:  _courseMappingCubit.courseMappingModel.affiliation,degree:_courseMappingCubit.courseMappingModel.degree,session: _courseMappingCubit.courseMappingModel.session,section:_courseMappingCubit.courseMappingModel.section,semesterName: _courseMappingCubit.courseMappingModel.semesterName,courseTitle:_courseMappingCubit.courseMappingModel.courseTitle,);
                                      _courseMappingCubit.getCourseMappingModel(model);
                                    },
                                    menus: _courseCatalogCubit.courseCatalogList.where((element) => element.courseTitle==_courseMappingCubit.courseMappingModel.courseTitle,).map((e) => e.courseCode??"",).toList(),
                                    offset: Offset(0, 30),widget: SizedBox(width: mdWidth(context),
                                      child: DropDownFieldWidget(
                                          title: "Course Code:",
                                          text:_courseMappingCubit.courseMappingModel.courseCode?? "Select..",maxLine: 1, isFilled: false)),):
                                  InkWell(
                                    onTap: () async{
                                      await _courseCatalogCubit.getCourseCatalogList();
                                    },
                                    child: DropDownFieldWidget(
                                        title: "Course Code:",
                                        text:_courseMappingCubit.courseMappingModel.courseCode?? "Select..",maxLine: 1, isFilled: false),
                                  );
                                }
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: BlocBuilder(
                                bloc: _courseCatalogCubit,
                                builder: (context,statesbks) {
                                  return _courseCatalogCubit.courseCatalogList.isNotEmpty? CustomPopMenuButton(
                                    onSelected: (p0) {
                                      String type=_courseCatalogCubit.courseCatalogList.where((element) => element.courseTitle==_courseMappingCubit.courseMappingModel.courseTitle && element.courseCode==_courseMappingCubit.courseMappingModel.courseCode,).map((e) => e.type??"",).toList()[p0];
                                      CourseMappingModel model=CourseMappingModel(semesterId: _courseMappingCubit.courseMappingModel.semesterId,courseCode: _courseMappingCubit.courseMappingModel.courseCode,courseType: type,department: _courseMappingCubit.courseMappingModel.department,program:_courseMappingCubit.courseMappingModel.program,affiliation:  _courseMappingCubit.courseMappingModel.affiliation,degree:_courseMappingCubit.courseMappingModel.degree,session: _courseMappingCubit.courseMappingModel.session,section:_courseMappingCubit.courseMappingModel.section,semesterName: _courseMappingCubit.courseMappingModel.semesterName,courseTitle:_courseMappingCubit.courseMappingModel.courseTitle,);
                                      _courseMappingCubit.getCourseMappingModel(model);
                                    },
                                    menus: _courseCatalogCubit.courseCatalogList.where((element) => element.courseTitle==_courseMappingCubit.courseMappingModel.courseTitle && element.courseCode==_courseMappingCubit.courseMappingModel.courseCode,).map((e) => e.type??"",).toList(),
                                    offset: Offset(0, 30),widget: SizedBox(width: mdWidth(context),
                                      child: DropDownFieldWidget(
                                          title: "Course Type:",
                                          text:_courseMappingCubit.courseMappingModel.courseType?? "Select..",maxLine: 1, isFilled: false)),):
                                  InkWell(
                                    onTap: () async{
                                      await _courseCatalogCubit.getCourseCatalogList();
                                    },
                                    child: DropDownFieldWidget(
                                        title: "Course Type:",
                                        text:_courseMappingCubit.courseMappingModel.courseType?? "Select..",maxLine: 1, isFilled: false),
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
                                  return _courseCatalogCubit.courseCatalogList.isNotEmpty? CustomPopMenuButton(
                                    onSelected: (p0) {
                                      String category=_courseCatalogCubit.courseCatalogList.where((element) => element.courseTitle==_courseMappingCubit.courseMappingModel.courseTitle && element.courseCode==_courseMappingCubit.courseMappingModel.courseCode && element.type==_courseMappingCubit.courseMappingModel.courseType,).map((e) => e.category??"",).toList()[p0];
                                      CourseMappingModel model=CourseMappingModel(semesterId: _courseMappingCubit.courseMappingModel.semesterId,courseCategory: category,courseCode: _courseMappingCubit.courseMappingModel.courseCode,courseType: _courseMappingCubit.courseMappingModel.courseType,department: _courseMappingCubit.courseMappingModel.department,program:_courseMappingCubit.courseMappingModel.program,affiliation:  _courseMappingCubit.courseMappingModel.affiliation,degree:_courseMappingCubit.courseMappingModel.degree,session: _courseMappingCubit.courseMappingModel.session,section:_courseMappingCubit.courseMappingModel.section,semesterName: _courseMappingCubit.courseMappingModel.semesterName,courseTitle:_courseMappingCubit.courseMappingModel.courseTitle,);
                                      _courseMappingCubit.getCourseMappingModel(model);
                                    },
                                    menus: _courseCatalogCubit.courseCatalogList.where((element) => element.courseTitle==_courseMappingCubit.courseMappingModel.courseTitle && element.courseCode==_courseMappingCubit.courseMappingModel.courseCode && element.type==_courseMappingCubit.courseMappingModel.courseType,).map((e) => e.category??"",).toList(),
                                    offset: Offset(0, 30),widget: SizedBox(width: mdWidth(context),
                                      child: DropDownFieldWidget(
                                          title: "Course Category:",
                                          text:_courseMappingCubit.courseMappingModel.courseCategory?? "Select..",maxLine: 1, isFilled: false)),):
                                  InkWell(
                                    onTap: () async{
                                      await _courseCatalogCubit.getCourseCatalogList();
                                    },
                                    child: DropDownFieldWidget(
                                        title: "Course Category:",
                                        text:_courseMappingCubit.courseMappingModel.courseCategory?? "Select..",maxLine: 1, isFilled: false),
                                  );
                                }
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: BlocBuilder(
                                bloc: _courseCatalogCubit,
                                builder: (context,statesbks) {
                                  return _courseCatalogCubit.courseCatalogList.isNotEmpty? CustomPopMenuButton(
                                    onSelected: (p0) {
                                      double val=_courseCatalogCubit.courseCatalogList.where((element) => element.courseTitle==_courseMappingCubit.courseMappingModel.courseTitle && element.courseCode==_courseMappingCubit.courseMappingModel.courseCode && element.type==_courseMappingCubit.courseMappingModel.courseType&& element.category==_courseMappingCubit.courseMappingModel.courseCategory,).map((e) => e.creditHours??0,).toList()[p0];
                                      String id=_courseCatalogCubit.courseCatalogList.where((element) => element.courseTitle==_courseMappingCubit.courseMappingModel.courseTitle && element.courseCode==_courseMappingCubit.courseMappingModel.courseCode && element.type==_courseMappingCubit.courseMappingModel.courseType&& element.category==_courseMappingCubit.courseMappingModel.courseCategory&& element.creditHours==val,).map((e) => e.id??"",).toList()[p0];
                                      CourseMappingModel model=CourseMappingModel(semesterId: _courseMappingCubit.courseMappingModel.semesterId,status: "Active",courseId: id,creditHours: val,courseCategory: _courseMappingCubit.courseMappingModel.courseCategory,courseCode: _courseMappingCubit.courseMappingModel.courseCode,courseType: _courseMappingCubit.courseMappingModel.courseType,department: _courseMappingCubit.courseMappingModel.department,program:_courseMappingCubit.courseMappingModel.program,affiliation:  _courseMappingCubit.courseMappingModel.affiliation,degree:_courseMappingCubit.courseMappingModel.degree,session: _courseMappingCubit.courseMappingModel.session,section:_courseMappingCubit.courseMappingModel.section,semesterName: _courseMappingCubit.courseMappingModel.semesterName,courseTitle:_courseMappingCubit.courseMappingModel.courseTitle,);

                                      _courseMappingCubit.getCourseMappingModel(model);
                                    },
                                    menus: _courseCatalogCubit.courseCatalogList.where((element) => element.courseTitle==_courseMappingCubit.courseMappingModel.courseTitle && element.courseCode==_courseMappingCubit.courseMappingModel.courseCode && element.type==_courseMappingCubit.courseMappingModel.courseType&& element.category==_courseMappingCubit.courseMappingModel.courseCategory,).map((e) => "${e.creditHours??""}",).toList(),
                                    offset: Offset(0, 30),widget: SizedBox(width: mdWidth(context),
                                      child: DropDownFieldWidget(
                                          title: "Credit Hours:",
                                          text:"${_courseMappingCubit.courseMappingModel.creditHours?? "Select.."}",maxLine: 1, isFilled: false)),):
                                  InkWell(
                                    onTap: () async{
                                      await _courseCatalogCubit.getCourseCatalogList();
                                    },
                                    child: DropDownFieldWidget(
                                        title: "Course Hours:",
                                        text:"${_courseMappingCubit.courseMappingModel.creditHours?? "Select.."}",maxLine: 1, isFilled: false),
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

                            if (dataModel.department == null ||
                                dataModel.program == null ||
                                dataModel.degree == null ||
                                dataModel.affiliation == null ||
                                dataModel.session == null ||
                                dataModel.section == null ||
                                dataModel.semesterName == null ||
                                dataModel.courseId == null ||
                                dataModel.courseTitle == null ||
                                dataModel.courseCode == null ||
                                dataModel.courseCategory == null ||
                                dataModel.courseType == null ||
                                dataModel.creditHours == null || dataModel.semesterId==null) {
                              showMessage("Please fill all fields");
                              return;
                            }

                         var response=
                             widget.updateCourseMapping!=null?
                             await  _courseMappingCubit.update(dataModel)
                                 :
                         await  _courseMappingCubit.addMapping(dataModel);

                            if(response){
                              showMessage(widget.updateCourseMapping!=null? "Data Updated":"Data Added");
                              context.pop();
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
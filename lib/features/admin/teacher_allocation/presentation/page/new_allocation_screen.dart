import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/constants/media_query.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/course_mapping/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/teacher_allocation/models/teacher_allocation_model.dart';
import 'package:college_management/features/admin/teacher_allocation/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/teacher_records/presentation/controller/cubit.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_top_bar.dart';
import '../../../course_catalog/presentation/widgets/catalog_depart_widget.dart';
import '../../../course_mapping/model/course_mapping_model.dart';



class NewAllocationScreen extends StatefulWidget {
   NewAllocationScreen({super.key,this.allocationModel});
  TeacherAllocationModel? allocationModel;
  @override
  State<NewAllocationScreen> createState() => _NewAllocationScreenState();
}

class _NewAllocationScreenState extends State<NewAllocationScreen> {
  // final _affiliationCubit=DiContainer().sl<UniversityProfileCubit>();
  // final _courseMappingCubit=DiContainer().sl<AdminProgramsCubit>();
  
  final _courseMappingCubit=DiContainer().sl<CourseMappingCubit>();
  final _teacherAllocationCubit=DiContainer().sl<TeacherAllocationCubit>();
  final _teacherRecordCubit=DiContainer().sl<TeacherRecordsCubit>();
  
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if(widget.allocationModel!=null){
        if(widget.allocationModel!.isCombinedClass!=null && widget.allocationModel!.isCombinedClass==false){
          var temp=widget.allocationModel;
          temp=widget.allocationModel!.copyWith(combinedPrograms: [widget.allocationModel?.programName??""]);
          _teacherAllocationCubit.getTeacherAllocationModel(temp);
        }else{
          _teacherAllocationCubit.getTeacherAllocationModel(widget.allocationModel!);
        }
      }else{
        _teacherAllocationCubit.getTeacherAllocationModel(TeacherAllocationModel());
      }
      await _courseMappingCubit.getMappingData();
    },);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgPrimary,
      body: BlocBuilder(
        bloc: _teacherAllocationCubit,
        builder: (context,statesblla) {
          return Column(
            children: [
              /// 🔷 TOP BAR (UPDATED)
              CustomTopBar(text:widget.allocationModel!=null? "Update Allocation":"New Allocation"),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenPaddingHori,
                    vertical: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      AppText(
                        text: "Assign Teacher to Course",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 5),
                      AppText(
                        text:
                        "Select details below to allocate a teacher to a specific course and class",
                        fontSize: 11,
                        color: AppColor.grey,
                      ),

                      SizedBox(height: 10),


                      /// 🔹 Affiliation
                      BlocBuilder(
                          bloc: _courseMappingCubit,
                          builder: (context,statesbk) {
                            return _buildField(
                              title: "Affiliation",
                              child: SizedBox(
                                width: mdWidth(context),
                                child:_courseMappingCubit.activeCourseMappingList.isNotEmpty? CustomPopMenuButton(
                                  menus:_courseMappingCubit.activeCourseMappingList.map((e) => e.affiliationName??"",).toSet().toList(),
                                 onSelected: (p0) {
                                   String affiliation=_courseMappingCubit.activeCourseMappingList.map((e) => e.affiliationName??"",).toSet().toList()[p0];
                                   _teacherAllocationCubit.getTeacherAllocationModel(TeacherAllocationModel(affiliation: affiliation));
                                 },
                                  offset: Offset(0, 30),
                                  widget: DropDownFieldWidget(
                                    text:_teacherAllocationCubit.teacherAllocationModel.affiliation?? 'Select..',
                                    maxLine: 1,
                                    isFilled: _teacherAllocationCubit.teacherAllocationModel.affiliation!=null,
                                  ),
                                ):InkWell(
                                  onTap: () async{
                                    await _courseMappingCubit.getMappingData();
                                  },
                                  child: DropDownFieldWidget(
                                    text: _teacherAllocationCubit.teacherAllocationModel.affiliation??'Select..',
                                    maxLine: 1,
                                    isFilled: _teacherAllocationCubit.teacherAllocationModel.affiliation!=null,
                                  ),
                                ),
                              ),
                            );
                          }
                      ),

                      SizedBox(height: 15),

                      /// 🔹 DEPARTMENT
                      BlocBuilder(
                        bloc: _courseMappingCubit,
                        builder: (context,statesbk) {
                          return _buildField(
                            title: "Department",
                            child: SizedBox(
                              width: mdWidth(context),
                              child:_courseMappingCubit.activeCourseMappingList.isNotEmpty && _teacherAllocationCubit.teacherAllocationModel.affiliation!=null ? CustomPopMenuButton(
                                menus:_courseMappingCubit.activeCourseMappingList.where((element) => element.affiliationName==_teacherAllocationCubit.teacherAllocationModel.affiliation,).map((e) => e.departmentName??"",).toSet().toList(),
                                offset: Offset(0, 30),
                                onSelected: (p0) {
                                  String department=_courseMappingCubit.activeCourseMappingList.where((element) => element.affiliationName==_teacherAllocationCubit.teacherAllocationModel.affiliation,).map((e) => e.departmentName??"",).toSet().toList()[p0];
                                  _teacherAllocationCubit.getTeacherAllocationModel(TeacherAllocationModel(affiliation: _teacherAllocationCubit.teacherAllocationModel.affiliation,department: department));
                                },
                                widget: DropDownFieldWidget(
                                  canTap: _teacherAllocationCubit.teacherAllocationModel.affiliation!=null,
                                  text: _teacherAllocationCubit.teacherAllocationModel.department??'Select..',
                                  maxLine: 1,
                                  isFilled: _teacherAllocationCubit.teacherAllocationModel.department!=null,
                                ),
                              ):InkWell(
                                onTap: () async{
                                   await _courseMappingCubit.getMappingData();
                                },
                                child: DropDownFieldWidget(
                                  canTap: _teacherAllocationCubit.teacherAllocationModel.affiliation!=null,
                                  text:_teacherAllocationCubit.teacherAllocationModel.department?? 'Select..',
                                  maxLine: 1,
                                  isFilled: _teacherAllocationCubit.teacherAllocationModel.department!=null,
                                ),
                              ),
                            ),
                          );
                        }
                      ),

                      SizedBox(height: 15),

                      /// 🔹 PROGRAM
                      _buildField(
                        title: "Program",
                        child:  BlocBuilder(
                            bloc: _courseMappingCubit,
                            builder: (context,statesbk) {
                            return SizedBox(
                              width: mdWidth(context),
                              child:_teacherAllocationCubit.teacherAllocationModel.department!=null?
                              CustomPopMenuButton(
                                menus:_courseMappingCubit.activeCourseMappingList.where((element) => element.affiliationName==_teacherAllocationCubit.teacherAllocationModel.affiliation && element.departmentName==_teacherAllocationCubit.teacherAllocationModel.department,).map((e) => e.programName??"",).toSet().toList(),
                                offset: Offset(0, 30),
                                onSelected: (p0) {
                                  List<CourseMappingModel> data=List.from(_courseMappingCubit.activeCourseMappingList.where((element) => element.affiliationName==_teacherAllocationCubit.teacherAllocationModel.affiliation && element.departmentName==_teacherAllocationCubit.teacherAllocationModel.department,).toList());
                                  String program=data.map((e) => e.programName??"",).toSet().toList()[p0];
                                  String id=data.firstWhere((element) => element.programName==program,).programId??"";

                                  List<String> list=_teacherAllocationCubit.teacherAllocationModel.combinedPrograms??[];
                                  list.add(program);
                                  list=list.toSet().toList();
                                  List<String> idsList=_teacherAllocationCubit.teacherAllocationModel.combinedProgramsIds??[];
                                  idsList.add(id);
                                  idsList=idsList.toSet().toList();
                                  _teacherAllocationCubit.getTeacherAllocationModel(TeacherAllocationModel(affiliation: _teacherAllocationCubit.teacherAllocationModel.affiliation,department: _teacherAllocationCubit.teacherAllocationModel.department,combinedPrograms:list,combinedProgramsIds: idsList));
                                },
                                widget: DropDownFieldWidget(
                                  canTap: _teacherAllocationCubit.teacherAllocationModel.department!=null,
                                  text: "Select..",
                                  maxLine: 1,
                                  isFilled: false,
                                ),
                              ):InkWell(
                                onTap: ()async {
                                  if(_teacherAllocationCubit.teacherAllocationModel.department!=null){
                                     await _courseMappingCubit.getMappingData();
                                  }
                                },
                                child: DropDownFieldWidget(
                                  canTap: _teacherAllocationCubit.teacherAllocationModel.department!=null,
                                  text:"Select..",
                                  maxLine: 1,
                                  isFilled: false,
                                ),
                              ),
                            );
                          }
                        ),
                      ),

                      if(_teacherAllocationCubit.teacherAllocationModel.combinedPrograms!=null && _teacherAllocationCubit.teacherAllocationModel.combinedPrograms!.isNotEmpty)
                        Wrap(
                          children: List.generate(_teacherAllocationCubit.teacherAllocationModel.combinedPrograms?.length??0, (index) => CatalogDepartWidget(text: _teacherAllocationCubit.teacherAllocationModel.combinedPrograms![index], onTap: () {
                            List<String> list=List.from(_teacherAllocationCubit.teacherAllocationModel.combinedPrograms??[]);
                            list.removeWhere((element) => element==_teacherAllocationCubit.teacherAllocationModel.combinedPrograms![index],);
                             List<String> ids=List.from(_teacherAllocationCubit.teacherAllocationModel.combinedProgramsIds??[]);
                            ids.removeWhere((element) => element==_teacherAllocationCubit.teacherAllocationModel.combinedProgramsIds![index],);
                            if(list.isEmpty){
                              _teacherAllocationCubit.getTeacherAllocationModel(TeacherAllocationModel(affiliation: _teacherAllocationCubit.teacherAllocationModel.affiliation,department: _teacherAllocationCubit.teacherAllocationModel.department,combinedPrograms: [],combinedProgramsIds: []));
                            }else{
                              _teacherAllocationCubit.getTeacherAllocationModel(_teacherAllocationCubit.teacherAllocationModel.copyWith(combinedPrograms: list,combinedProgramsIds: ids));
                            }
                          },),),
                        ),
                      SizedBox(height: 15),

                      /// 🔹 SESSION
                      _buildField(
                        title: "Batch/Session",
                        child:  BlocBuilder(
                            bloc: _courseMappingCubit,
                            builder: (context,statesbk) {
                              return SizedBox(
                                width: mdWidth(context),
                                child:_teacherAllocationCubit.teacherAllocationModel.combinedPrograms!=null && _teacherAllocationCubit.teacherAllocationModel.combinedPrograms!.isNotEmpty?
                               CustomPopMenuButton(
                                menus: _courseMappingCubit.activeCourseMappingList.where((element) => element.affiliationName==_teacherAllocationCubit.teacherAllocationModel.affiliation && element.departmentName==_teacherAllocationCubit.teacherAllocationModel.department && _teacherAllocationCubit.teacherAllocationModel.combinedPrograms!.contains(element.programName??"") ).map((e) => e.session??"",).toSet().toList(),
                                onSelected:  (p0) {
                                  String session=_courseMappingCubit.activeCourseMappingList.where((element) => element.affiliationName==_teacherAllocationCubit.teacherAllocationModel.affiliation && element.departmentName==_teacherAllocationCubit.teacherAllocationModel.department && _teacherAllocationCubit.teacherAllocationModel.combinedPrograms!.contains(element.programName??"") ).map((e) => e.session??"",).toSet().toList()[p0];
                                  _teacherAllocationCubit.getTeacherAllocationModel(TeacherAllocationModel(affiliation: _teacherAllocationCubit.teacherAllocationModel.affiliation,department: _teacherAllocationCubit.teacherAllocationModel.department,combinedPrograms:_teacherAllocationCubit.teacherAllocationModel.combinedPrograms,combinedProgramsIds:_teacherAllocationCubit.teacherAllocationModel.combinedProgramsIds,batch: session ));
                                },
                                 offset: Offset(0, 30),
                                widget: DropDownFieldWidget(
                                  canTap: _teacherAllocationCubit.teacherAllocationModel.combinedPrograms!=null && _teacherAllocationCubit.teacherAllocationModel.combinedPrograms!.isNotEmpty,
                                  text:_teacherAllocationCubit.teacherAllocationModel.batch?? "Select..",
                                  maxLine: 1,
                                  isFilled: _teacherAllocationCubit.teacherAllocationModel.batch!=null,
                                ),
                              ):InkWell(
                                  onTap: () async{
                                    if(_teacherAllocationCubit.teacherAllocationModel.combinedPrograms!=null && _teacherAllocationCubit.teacherAllocationModel.combinedPrograms!.isNotEmpty){
                                       await _courseMappingCubit.getMappingData();
                                    }
                                  },
                                child: DropDownFieldWidget(
                                    canTap: _teacherAllocationCubit.teacherAllocationModel.combinedPrograms!=null && _teacherAllocationCubit.teacherAllocationModel.combinedPrograms!.isNotEmpty,
                                    text:_teacherAllocationCubit.teacherAllocationModel.batch?? "Select..",
                                    maxLine: 1,
                                    isFilled: _teacherAllocationCubit.teacherAllocationModel.batch!=null,
                                  ),
                              ),
                            );
                          }
                        ),
                      ),

                      SizedBox(height: 15),
                      _buildField(
                        title: "Degree",
                        child:  BlocBuilder(
                            bloc: _courseMappingCubit,
                            builder: (context,statesbk) {
                              return SizedBox(
                                width: mdWidth(context),
                                child: _teacherAllocationCubit.teacherAllocationModel.batch!=null? CustomPopMenuButton(
                                  menus: _courseMappingCubit.activeCourseMappingList.where((element) => element.affiliationName==_teacherAllocationCubit.teacherAllocationModel.affiliation && element.departmentName==_teacherAllocationCubit.teacherAllocationModel.department && _teacherAllocationCubit.teacherAllocationModel.combinedPrograms!.contains(element.programName) && element.session== _teacherAllocationCubit.teacherAllocationModel.batch).map((e) => e.degree??"",).toSet().toList(),
                                  onSelected:  (p0) {
                                    String degree=_courseMappingCubit.activeCourseMappingList.where((element) => element.affiliationName==_teacherAllocationCubit.teacherAllocationModel.affiliation && element.departmentName==_teacherAllocationCubit.teacherAllocationModel.department && _teacherAllocationCubit.teacherAllocationModel.combinedPrograms!.contains(element.programName) && element.session== _teacherAllocationCubit.teacherAllocationModel.batch).map((e) => e.degree??"",).toSet().toList()[p0];
                                    var model=_teacherAllocationCubit.teacherAllocationModel;
                                    _teacherAllocationCubit.getTeacherAllocationModel(TeacherAllocationModel(affiliation: model.affiliation,department: model.department,programName:model.programName,combinedPrograms: model.combinedPrograms,combinedProgramsIds: model.combinedProgramsIds,batch: model.batch ,degree: degree,));
                                  },
                                  offset: Offset(0, 30),
                                  widget: DropDownFieldWidget(
                                    canTap: _teacherAllocationCubit.teacherAllocationModel.batch!=null,
                                    text:_teacherAllocationCubit.teacherAllocationModel.degree?? "Select..",
                                    maxLine: 1,
                                    isFilled: _teacherAllocationCubit.teacherAllocationModel.degree!=null,
                                  ),
                                ): InkWell(
                                  onTap: () async{
                                    if(_teacherAllocationCubit.teacherAllocationModel.batch!=null){
                                       await _courseMappingCubit.getMappingData();
                                    }
                                  },
                                  child: DropDownFieldWidget(
                                    canTap: _teacherAllocationCubit.teacherAllocationModel.batch!=null,
                                    text:_teacherAllocationCubit.teacherAllocationModel.degree?? "Select..",
                                    maxLine: 1,
                                    isFilled: _teacherAllocationCubit.teacherAllocationModel.degree!=null,
                                  ),
                                ),
                              );
                            }
                        ),
                      ),
                      SizedBox(height: 15),
                      /// 🔹 SEMESTER LEVEL
                      Row(
                        children: [
                          Expanded(
                            child: _buildField(
                              title: "Section",
                              child:  BlocBuilder(
                                  bloc: _courseMappingCubit,
                                  builder: (context,statesbk) {
                                  return SizedBox(
                                    width: mdWidth(context),
                                    child: _teacherAllocationCubit.teacherAllocationModel.degree!=null? CustomPopMenuButton(
                                      menus: _courseMappingCubit.activeCourseMappingList.where((element) => element.affiliationName==_teacherAllocationCubit.teacherAllocationModel.affiliation && element.departmentName==_teacherAllocationCubit.teacherAllocationModel.department && _teacherAllocationCubit.teacherAllocationModel.combinedPrograms!.contains(element.programName) && element.session== _teacherAllocationCubit.teacherAllocationModel.batch && element.degree == _teacherAllocationCubit.teacherAllocationModel.degree).map((e) => e.section??"",).toSet().toList(),
                                      onSelected:  (p0) {
                                        String section=_courseMappingCubit.activeCourseMappingList.where((element) => element.affiliationName==_teacherAllocationCubit.teacherAllocationModel.affiliation && element.departmentName==_teacherAllocationCubit.teacherAllocationModel.department && _teacherAllocationCubit.teacherAllocationModel.combinedPrograms!.contains(element.programName) && element.session== _teacherAllocationCubit.teacherAllocationModel.batch && element.degree == _teacherAllocationCubit.teacherAllocationModel.degree).map((e) => e.section??"",).toSet().toList()[p0];
                                        var model=_teacherAllocationCubit.teacherAllocationModel;
                                        _teacherAllocationCubit.getTeacherAllocationModel(TeacherAllocationModel(affiliation: model.affiliation,department: model.department,programName:model.programName,combinedPrograms: model.combinedPrograms,combinedProgramsIds:model.combinedProgramsIds,batch: model.batch ,degree: model.degree,section: section));
                                      },
                                      offset: Offset(0, 30),
                                      widget: DropDownFieldWidget(
                                        canTap: _teacherAllocationCubit.teacherAllocationModel.degree!=null,
                                        text:_teacherAllocationCubit.teacherAllocationModel.section?? "Select..",
                                        maxLine: 1,
                                        isFilled: _teacherAllocationCubit.teacherAllocationModel.section!=null,
                                      ),
                                    ):InkWell(
                                      onTap: () async{
                                        if(_teacherAllocationCubit.teacherAllocationModel.degree!=null){
                                           await _courseMappingCubit.getMappingData();
                                        }
                                      },
                                      child: DropDownFieldWidget(
                                        canTap: _teacherAllocationCubit.teacherAllocationModel.degree!=null,
                                        text:_teacherAllocationCubit.teacherAllocationModel.section?? "Select..",
                                        maxLine: 1,
                                        isFilled: _teacherAllocationCubit.teacherAllocationModel.section!=null,
                                      ),
                                    ),
                                  );
                                }
                              ),
                            ),
                          ),

                          SizedBox(width: 10),

                          /// 🔹 SECTION
                          Expanded(
                            child: _buildField(
                              title: "Semester",
                              child:  BlocBuilder(
                                bloc: _courseMappingCubit,
                                builder: (context,statesbknl) {
                                  return SizedBox(
                                    width: mdWidth(context),
                                    child:_courseMappingCubit.activeCourseMappingList.isNotEmpty && _teacherAllocationCubit.teacherAllocationModel.section!=null? CustomPopMenuButton(
                                      menus: _courseMappingCubit.activeCourseMappingList.where((element) => element.affiliationName==_teacherAllocationCubit.teacherAllocationModel.affiliation && element.departmentName==_teacherAllocationCubit.teacherAllocationModel.department && _teacherAllocationCubit.teacherAllocationModel.combinedPrograms!.contains(element.programName) && element.session== _teacherAllocationCubit.teacherAllocationModel.batch && element.degree == _teacherAllocationCubit.teacherAllocationModel.degree && element.section==_teacherAllocationCubit.teacherAllocationModel.section).map((e) => e.semesterName??"",).toSet().toList(),
                                      onSelected: (p0) {
                                        String semesterName= _courseMappingCubit.activeCourseMappingList.where((element) => element.affiliationName==_teacherAllocationCubit.teacherAllocationModel.affiliation && element.departmentName==_teacherAllocationCubit.teacherAllocationModel.department && _teacherAllocationCubit.teacherAllocationModel.combinedPrograms!.contains(element.programName) && element.session== _teacherAllocationCubit.teacherAllocationModel.batch && element.degree == _teacherAllocationCubit.teacherAllocationModel.degree && element.section==_teacherAllocationCubit.teacherAllocationModel.section).map((e) => e.semesterName??"",).toSet().toList()[p0];
                                        var model=_teacherAllocationCubit.teacherAllocationModel;
                                        _teacherAllocationCubit.getTeacherAllocationModel(TeacherAllocationModel(affiliation: model.affiliation,department: model.department,programName:model.programName,combinedPrograms: model.combinedPrograms,combinedProgramsIds:model.combinedProgramsIds,batch: model.batch ,degree: model.degree,section: model.section,semester: semesterName));
                                      },
                                      offset: Offset(0, 30),
                                      widget: DropDownFieldWidget(
                                        canTap: _teacherAllocationCubit.teacherAllocationModel.section!=null,
                                        text: _teacherAllocationCubit.teacherAllocationModel.semester??"Select..",
                                        maxLine: 1,
                                        isFilled: _teacherAllocationCubit.teacherAllocationModel.semester!=null,
                                      ),
                                    ):InkWell(
                                      onTap: () async{
                                        if(_teacherAllocationCubit.teacherAllocationModel.section!=null){
                                          await _courseMappingCubit.getMappingData();
                                        }
                                      },
                                      child: DropDownFieldWidget(
                                        canTap: _teacherAllocationCubit.teacherAllocationModel.section!=null,
                                        text: _teacherAllocationCubit.teacherAllocationModel.semester??"Select..",
                                        maxLine: 1,
                                        isFilled: _teacherAllocationCubit.teacherAllocationModel.semester!=null,
                                      ),
                                    ),
                                  );
                                }
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 15),
                      /// 🔹 STATUS
                      _buildField(
                        title: "Course",
                        child: BlocBuilder(
                          bloc: _courseMappingCubit,
                          builder: (context, state) {
                            List<CourseMappingModel> filteredList=[];
                            List<String> menuList=[];
                            if(_teacherAllocationCubit.teacherAllocationModel.semester!=null){

                              filteredList = _courseMappingCubit.activeCourseMappingList.where(
                                    (element) =>
                                element.affiliationName ==
                                    _teacherAllocationCubit.teacherAllocationModel.affiliation &&
                                    element.departmentName ==
                                        _teacherAllocationCubit.teacherAllocationModel.department &&
                                    _teacherAllocationCubit.teacherAllocationModel.combinedPrograms!
                                        .contains(element.programName) &&
                                    element.session ==
                                        _teacherAllocationCubit.teacherAllocationModel.batch &&
                                    element.degree ==
                                        _teacherAllocationCubit.teacherAllocationModel.degree &&
                                    element.section ==
                                        _teacherAllocationCubit.teacherAllocationModel.section &&
                                    element.semesterName ==
                                        _teacherAllocationCubit.teacherAllocationModel.semester,
                              ).toList();

                              menuList = filteredList
                                  .map(
                                    (e) => "${e.courseTitle} , ${e.courseCode},Credit hour: ${e.creditHours}",
                              )
                                  .toSet()
                                  .toList();
                            }

                            return SizedBox(
                              width: mdWidth(context),
                              child:_courseMappingCubit.activeCourseMappingList.isNotEmpty && _teacherAllocationCubit.teacherAllocationModel.semester!=null? CustomPopMenuButton(
                                menus: menuList,
                                onSelected: (p0) {
                                  String selectedText = menuList[p0];

                                  final selectedModel = filteredList.firstWhere(
                                        (e) =>
                                    "${e.courseTitle} , ${e.courseCode},Credit hour: ${e.creditHours}" ==
                                        selectedText,
                                  );


                                  // Example
                                  TeacherAllocationModel model = _teacherAllocationCubit.teacherAllocationModel;
                                  _teacherAllocationCubit.getTeacherAllocationModel(TeacherAllocationModel(affiliation: model.affiliation,department: model.department,programName:model.programName,combinedPrograms: model.combinedPrograms,combinedProgramsIds:model.combinedProgramsIds,batch: model.batch ,degree: model.degree,section: model.section,semester: model.semester,courseCode: selectedModel.courseCode,courseName: selectedModel.courseTitle,creditHours: "${selectedModel.creditHours}", courseMappingId: selectedModel.id));

                                },
                                offset: const Offset(0, 30),
                                widget: DropDownFieldWidget(
                                  canTap: _teacherAllocationCubit.teacherAllocationModel.semester!=null,
                                  text: _teacherAllocationCubit.teacherAllocationModel.courseName!=null?
                                     "${_teacherAllocationCubit.teacherAllocationModel.courseName}, ${_teacherAllocationCubit.teacherAllocationModel.courseCode}, ${_teacherAllocationCubit.teacherAllocationModel.creditHours}": "Select..",
                                  maxLine: 1,
                                  isFilled: _teacherAllocationCubit.teacherAllocationModel.courseName!=null,
                                ),
                              ): InkWell(
                                onTap: () async{
                                  if(_teacherAllocationCubit.teacherAllocationModel.semester!=null){
                                    await _courseMappingCubit.getMappingData();
                                  }
                                },
                                child: DropDownFieldWidget(
                                  canTap: _teacherAllocationCubit.teacherAllocationModel.semester!=null,
                                                            text: _teacherAllocationCubit.teacherAllocationModel.courseName!=null?
                                                            "${_teacherAllocationCubit.teacherAllocationModel.courseName}, ${_teacherAllocationCubit.teacherAllocationModel.courseCode}, ${_teacherAllocationCubit.teacherAllocationModel.creditHours}": "Select..",
                                maxLine: 1,
                                isFilled: _teacherAllocationCubit.teacherAllocationModel.courseName!=null,
                                                            ),
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 15),

                      _buildField(
                        title: "Teacher",
                        child:  BlocBuilder(
                          bloc: _teacherRecordCubit,
                          builder: (context,statebkkl) {
                            return SizedBox(
                              width: mdWidth(context),
                              child: _teacherRecordCubit.activeTeacherList.isNotEmpty && _teacherAllocationCubit.teacherAllocationModel.courseName!=null? CustomPopMenuButton(
                                menus:
                                _teacherRecordCubit.activeTeacherList.where((element) => element.department!.where((element) => element.name==_teacherAllocationCubit.teacherAllocationModel.department,).isNotEmpty,).map((e) => e.teacherName??"",).toList(),
                                onSelected: (p0) {
                                  var teacherModel=_teacherRecordCubit.activeTeacherList.where((element) => element.department!.where((element) => element.name==_teacherAllocationCubit.teacherAllocationModel.department,).isNotEmpty).toList()[p0];
                                  var model = _teacherAllocationCubit.teacherAllocationModel;
                                  _teacherAllocationCubit.getTeacherAllocationModel(TeacherAllocationModel(affiliation: model.affiliation,department: model.department,programName:model.programName,combinedPrograms: model.combinedPrograms,combinedProgramsIds:model.combinedProgramsIds,batch: model.batch ,degree: model.degree,section: model.section,semester: model.semester,courseCode: model.courseCode,courseName: model.courseName,creditHours: model.creditHours,teacherName: teacherModel.teacherName??"",teacherId: teacherModel.id??"",courseMappingId: model.courseMappingId??"" ));
                                },
                                offset: Offset(0, 30),
                                widget: DropDownFieldWidget(
                                  canTap: _teacherAllocationCubit.teacherAllocationModel.courseName!=null,
                                  text: _teacherAllocationCubit.teacherAllocationModel.teacherName??"Select",
                                  maxLine: 1,
                                  isFilled: _teacherAllocationCubit.teacherAllocationModel.teacherName!=null,
                                ),
                              ):InkWell(
                                onTap: () async{
                                  if(_teacherAllocationCubit.teacherAllocationModel.courseName!=null){
                                    await  _teacherRecordCubit.getTeachers();
                                  }
                                },
                                child: DropDownFieldWidget(
                                  canTap: _teacherAllocationCubit.teacherAllocationModel.courseName!=null,
                                  text:_teacherAllocationCubit.teacherAllocationModel.teacherName?? "Select",
                                  maxLine: 1,
                                  isFilled: _teacherAllocationCubit.teacherAllocationModel.teacherName!=null,
                                ),
                              ),
                            );
                          }
                        ),
                      ),

                      // SizedBox(height: 15),
                      //
                      // _buildField(
                      //   title: "Allocation Type",
                      //   child:  SizedBox(
                      //     width: mdWidth(context),
                      //     child:CustomPopMenuButton(
                      //       menus:["Workload", "Fixed", "Extra/Per Lecture"],
                      //       onSelected: (p0) {
                      //         String type=["Workload", "Fixed", "Extra/Per Lecture"][p0];
                      //         var model = _teacherAllocationCubit.teacherAllocationModel;
                      //         _teacherAllocationCubit.getTeacherAllocationModel(model.copyWith(allocationType: type));
                      //
                      //       },
                      //       offset: Offset(0, 30),
                      //       widget: DropDownFieldWidget(
                      //         text:_teacherAllocationCubit.teacherAllocationModel.allocationType?? "Select",
                      //         maxLine: 1,
                      //         isFilled: _teacherAllocationCubit.teacherAllocationModel.allocationType!=null,
                      //       ),
                      //     )
                      //   ),
                      // ),

                      SizedBox(height: 15),

                      _buildField(
                        title: "Status",
                        child:  SizedBox(
                          width: mdWidth(context),
                          child:CustomPopMenuButton(
                            menus:["Active", "Inactive"],
                            onSelected: (p0) {
                              String status=["Active", "Inactive"][p0];
                              var model = _teacherAllocationCubit.teacherAllocationModel;
                              _teacherAllocationCubit.getTeacherAllocationModel(model.copyWith(status: status),statusVal: status);

                            },
                            offset: Offset(0, 30),
                            widget: DropDownFieldWidget(
                              text:_teacherAllocationCubit.status,
                              maxLine: 1,
                              isFilled: _teacherAllocationCubit.teacherAllocationModel.status!=null,
                            ),
                          )
                        ),
                      ),

                      SizedBox(height: 30),

                      /// 🔹 SAVE BUTTON
                      Center(
                        child: CustomElevatedButton(
                          width: mdWidth(context) * .7,
                          onPressed: () async {
                            var model=_teacherAllocationCubit.teacherAllocationModel;
                            if(model.affiliation==null || model.department==null ||model.combinedPrograms==null || model.combinedPrograms!.isEmpty ||model.batch==null ||  model.degree==null|| model.section==null|| model.semester==null || model.courseName==null || model.courseName==null || model.creditHours==null || model.teacherName==null || model.status==null ){
                              showMessage("Please fill all fields",isError: true);
                              return ;
                            }
                            var response=
                            widget.allocationModel!=null?
                            await  _teacherAllocationCubit.update(_teacherAllocationCubit.teacherAllocationModel.copyWith(id: widget.allocationModel?.id??"")):
                            await  _teacherAllocationCubit.post(_teacherAllocationCubit.teacherAllocationModel);
                         if(response){
                           context.pop();
                           await _teacherAllocationCubit.get();

                         }
                          },
                          text: "Save",
                        ),
                      ),

                      SafeArea(
                          top: false,
                          child: SizedBox(height: 20)),
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

  /// 🔥 REUSABLE FIELD WIDGET
  Widget _buildField({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: title,
          fontSize: 12,
          color: AppColor.grey,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: 6),
        child,
      ],
    );
  }
}
import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/enums/user_enums.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/neural_generator/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/neural_generator/presentation/widgets/coordinator_neural_list.dart';
import 'package:college_management/features/admin/neural_generator/presentation/widgets/hod_neural_list.dart';
import 'package:college_management/features/admin/neural_generator/presentation/widgets/neural_tabs_section.dart';
import 'package:college_management/features/admin/neural_generator/presentation/widgets/teacher_neural_list.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/neural_widget_model.dart';


class NeuralGeneratorScreen extends StatefulWidget {
  const NeuralGeneratorScreen({super.key});

  @override
  State<NeuralGeneratorScreen> createState() =>
      _NeuralGeneratorScreenState();
}

class _NeuralGeneratorScreenState
    extends State<NeuralGeneratorScreen> {

final _neuralGeneratorCubit=DiContainer().sl<NeuralGeneratorCubit>();

@override
  void initState() {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    _neuralGeneratorCubit.getUserRole(UserRole.teacher);
    await _neuralGeneratorCubit.getTeachers();
  },);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder(
        bloc: _neuralGeneratorCubit,
        builder: (context,statesbkl) {
          return Column(
            children: [
              /// 🔹 TOP BAR
              CustomTopBar(text: "Access Generator"),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal:screenPaddingHori),
                    child: Column(
                      children: [
                        NeuralTabsSection(),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _neuralGeneratorCubit.userIds.isEmpty? SizedBox():CustomElevatedButton(
                              onPressed: () async {
                                /// todo
                               var res= await _neuralGeneratorCubit.post();
                               if(res){
                                 if(_neuralGeneratorCubit.userRole==UserRole.teacher){
                                   await _neuralGeneratorCubit.getTeachers();
                                 }else if(_neuralGeneratorCubit.userRole==UserRole.coordinator){
                                   await _neuralGeneratorCubit.getCoordinator();
                                 }else if(_neuralGeneratorCubit.userRole==UserRole.hod){
                                   await _neuralGeneratorCubit.getHod();
                                 }
                               }
                              }, text: "Generate",height: 25,width: 80,borderColor: AppColor.primary,showBorder: true,fontSize: 11,fontWeight: FontWeight.w500,bgColor: AppColor.primary.withOpacity(.6),),
                            InkWell(
                              onTap: () {
                                if(_neuralGeneratorCubit.userIds.isNotEmpty){
                                  _neuralGeneratorCubit.getIds([]);
                                }else{
                                  if(_neuralGeneratorCubit.userRole==UserRole.hod &&  _neuralGeneratorCubit.hodList.isNotEmpty){
                                    List<NeuralWidgetModel> hodIds=List.from(_neuralGeneratorCubit.hodFilterList.where((element) => element.teacher!.isAccountGenerated==false,).map((hod) => NeuralWidgetModel(id: hod.id??"",name: hod.teacher?.teacherName??'-', status: hod.status??"-", email: hod.teacher?.email??"-", department:[hod.department?.name??""], role: UserRole.hod, canSelect:hod.teacher?.isAccountGenerated??false, userName: hod.teacher?.userName??"-"),));
                                    _neuralGeneratorCubit.getIds(hodIds);
                                  }else if(_neuralGeneratorCubit.userRole==UserRole.coordinator && _neuralGeneratorCubit.coordinatorList.isNotEmpty){
                                    List<NeuralWidgetModel> coordinator=List.from(_neuralGeneratorCubit.coordinatorFilterList.where((element) => element.isAccountGenerated==false,).map((coordinator) => NeuralWidgetModel(id: coordinator.id??"",name: coordinator.coordinatorName??'-', status: coordinator.status??"-", email: coordinator.email??"-", department:[...coordinator.programs!.map((element) => element.department?.name??"")], role: UserRole.coordinator, canSelect:coordinator.isAccountGenerated??false, userName: coordinator.userName??"-"),));
                                    _neuralGeneratorCubit.getIds(coordinator);
                                  }else if(_neuralGeneratorCubit.userRole==UserRole.teacher && _neuralGeneratorCubit.teachersList.isNotEmpty){
                                    List<NeuralWidgetModel> teacherList=List.from(_neuralGeneratorCubit.teachersFilterList.where((element) => element.isAccountGenerated==false,).map((teacher) => NeuralWidgetModel(id: teacher.id??"",name: teacher.teacherName??'-', status: teacher.status??"-", email: teacher.email??"-", department: teacher.department?.map((e) => e.name,).toList()??[], role: UserRole.teacher, canSelect:teacher.isAccountGenerated??false, userName: teacher.userName??"-"),));
                                    _neuralGeneratorCubit.getIds(teacherList);
                                  }
                                }
                              },
                              child: AppText(
                                text:_neuralGeneratorCubit.userIds.isNotEmpty? "Uncheck All":"Check All",
                                fontSize: 12,
                                color: AppColor.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),

                        if(_neuralGeneratorCubit.userRole==UserRole.teacher)
                        TeacherNeuralList()
                        else if(_neuralGeneratorCubit.userRole==UserRole.hod)
                        HodNeuralList()
                        else if(_neuralGeneratorCubit.userRole==UserRole.coordinator)
                        CoordinatorNeuralList(),
                        SafeArea(
                            top: false,
                            child: SizedBox(height: 30,)),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        }
      ),
    );
  }
}
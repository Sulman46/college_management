import 'package:college_management/core/enums/user_enums.dart';
import 'package:college_management/features/admin/neural_generator/presentation/widgets/neural_widget.dart';
import 'package:college_management/widgets/data_not_found_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/app/di_container.dart';
import '../../models/neural_widget_model.dart';
import '../controller/cubit.dart';

class TeacherNeuralList extends StatefulWidget {
  const TeacherNeuralList({super.key});

  @override
  State<TeacherNeuralList> createState() => _TeacherNeuralListState();
}

class _TeacherNeuralListState extends State<TeacherNeuralList> {
  final _neuralGeneratorCubit=DiContainer().sl<NeuralGeneratorCubit>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(_neuralGeneratorCubit.teachersList.isNotEmpty && _neuralGeneratorCubit.teachersFilterList.isNotEmpty)
        ...List.generate(
          _neuralGeneratorCubit.teachersFilterList.length,
              (index) {
            var teacher=_neuralGeneratorCubit.teachersFilterList.toList()[index];
            NeuralWidgetModel model=NeuralWidgetModel(id: teacher.id??"",name: teacher.teacherName??'-', status: teacher.status??"-", email: teacher.email??"-", department: teacher.department?.map((e) => e.name,).toList()??[], role: UserRole.teacher, canSelect:teacher.isAccountGenerated??false, userName: teacher.userName??"-");
            return NeuralWidget(model: model);
          },)
        else
          DataNotFoundWidget(onTap: ()async{
           await _neuralGeneratorCubit.getTeachers();
          }),
      ],
    );
  }
}

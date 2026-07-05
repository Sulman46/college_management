import 'package:college_management/core/enums/user_enums.dart';
import 'package:college_management/features/admin/neural_generator/presentation/widgets/neural_widget.dart';
import 'package:college_management/widgets/data_not_found_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/app/di_container.dart';
import '../../models/neural_widget_model.dart';
import '../controller/cubit.dart';

class HodNeuralList extends StatefulWidget {
  const HodNeuralList({super.key});

  @override
  State<HodNeuralList> createState() => _HodNeuralListState();
}

class _HodNeuralListState extends State<HodNeuralList> {
  final _neuralGeneratorCubit=DiContainer().sl<NeuralGeneratorCubit>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(_neuralGeneratorCubit.hodList.isNotEmpty && _neuralGeneratorCubit.hodFilterList.isNotEmpty)
          ...List.generate(
            _neuralGeneratorCubit.hodFilterList.length,
                (index) {
              var hod=_neuralGeneratorCubit.hodFilterList[index];
              NeuralWidgetModel model=NeuralWidgetModel(id: hod.id??"",name: hod.teacher?.teacherName??'-', status: hod.status??"-", email: hod.teacher?.email??"-", department:[hod.department?.name??""], role: UserRole.hod, canSelect:hod.isAccountGenerated??false, userName: hod.userName);
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

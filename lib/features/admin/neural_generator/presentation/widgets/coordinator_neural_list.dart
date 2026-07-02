import 'package:college_management/core/enums/user_enums.dart';
import 'package:college_management/features/admin/neural_generator/presentation/widgets/neural_widget.dart';
import 'package:college_management/widgets/data_not_found_widget.dart';
import 'package:flutter/material.dart';
import '../../../../../core/app/di_container.dart';
import '../../models/neural_widget_model.dart';
import '../controller/cubit.dart';


class CoordinatorNeuralList extends StatefulWidget {
  const CoordinatorNeuralList({super.key});

  @override
  State<CoordinatorNeuralList> createState() => _CoordinatorNeuralListState();
}

class _CoordinatorNeuralListState extends State<CoordinatorNeuralList> {
  final _neuralGeneratorCubit=DiContainer().sl<NeuralGeneratorCubit>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(_neuralGeneratorCubit.coordinatorList.isNotEmpty && _neuralGeneratorCubit.coordinatorFilterList.isNotEmpty)
          ...List.generate(
            _neuralGeneratorCubit.coordinatorFilterList.length,
                (index) {
              var coordinator=_neuralGeneratorCubit.coordinatorFilterList[index];
              NeuralWidgetModel model=NeuralWidgetModel(id: coordinator.id??"",name: coordinator.coordinatorName??'-', status: coordinator.status??"-", email: coordinator.email??"-", department:[...coordinator.programs!.map((element) => element.department?.name??"")], role: UserRole.coordinator, canSelect:coordinator.isAccountGenerated??false, userName: coordinator.userName??"-");
              return NeuralWidget(model: model);
            },)
        else
          DataNotFoundWidget(onTap: ()async{
            await _neuralGeneratorCubit.getCoordinator();
          }),
      ],
    );
  }
}

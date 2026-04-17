import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class NeuralGeneratorCubit extends Cubit<NeuralGeneratorState> {
  final NeuralGeneratorUseCase _useCase;
  NeuralGeneratorCubit(this._useCase) : super(NeuralGeneratorInit());

}

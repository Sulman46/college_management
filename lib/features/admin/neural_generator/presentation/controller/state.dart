import 'package:equatable/equatable.dart';

abstract class NeuralGeneratorState extends Equatable{
@override // TODO: implement props
  List<Object?> get props => [];
}

class NeuralGeneratorInit extends NeuralGeneratorState{}
class NeuralGeneratorLoading extends NeuralGeneratorState{}
class NeuralGeneratorLoaded extends NeuralGeneratorState{}
class NeuralGeneratorError extends NeuralGeneratorState{}

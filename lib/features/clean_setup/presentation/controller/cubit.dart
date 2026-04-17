import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class NewFileNameCubit extends Cubit<NewFileNameState> {
  final NewFileNameUseCase _useCase;
  NewFileNameCubit(this._useCase) : super(NewFileNameInit());

}

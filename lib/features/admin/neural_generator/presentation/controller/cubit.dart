import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/enums/user_enums.dart';
import '../../../../../core/extensions/dart_extensions.dart';
import '../../../../../core/helper/show_message.dart';
import '../../../../../widgets/loader_dialog.dart';
import '../../domain/usecase/usecase.dart';
import '../../models/neural_generate_model.dart';
import 'state.dart';

class NeuralGeneratorCubit extends Cubit<NeuralGeneratorState> {
  final NeuralGeneratorUseCase _useCase;
  NeuralGeneratorCubit(this._useCase) : super(NeuralGeneratorInit());

  UserRole? userRole;
  void getUserRole(UserRole? val){
    emit(NeuralGeneratorLoading());
    userRole=val;
    emit(NeuralGeneratorLoaded());
  }


  Future<bool> post(NeuralGenerateModel value)async{
    
    showLoadingDialog();
    emit(NeuralGeneratorLoading());
    var response=await _useCase.post(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(NeuralGeneratorLoaded());
      closeLoadingDialog();
      return false;
    }else{
      var data=response.asRight();
      showMessage(data);
      emit(NeuralGeneratorLoaded());
      closeLoadingDialog();
      return true;
    }
  }
  



}

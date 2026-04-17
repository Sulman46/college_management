import 'package:college_management/core/extensions/dart_extensions.dart';
import '../../domain/usecase/usecase.dart';
import 'package:college_management/features/splash/presentation/controller/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitName extends Cubit<CubitNameState> {
  final UseCaseName _useCaseName;
  CubitName(this._useCaseName) : super(CubitNameInit());


  bool? isNewUser;
  Future<void> checkNewUser()async{
    emit(CubitNameInit());
    var response=await _useCaseName.function1();
    if(response.isRight()){
      isNewUser= response.asRight();
      emit(CubitNameLoaded());
    }else{
      emit(CubitNameError());
    }

  }
}

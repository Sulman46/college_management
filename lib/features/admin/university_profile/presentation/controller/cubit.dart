import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class UniversityProfileCubit extends Cubit<UniversityProfileState> {
  final UniversityProfileUseCase _useCase;
  UniversityProfileCubit(this._useCase) : super(UniversityProfileInit());

  bool editUniversityProfile=false;

  File? pickedUniversityImage;

  void pickUniversityImage(File? val)async{
    emit(UniversityProfileLoading());
    pickedUniversityImage=val;
    emit(UniversityProfileLoaded());
  }

  void updateEditUniversityProfile(bool val){
    emit(UniversityProfileLoading());
    editUniversityProfile=val;
    emit(UniversityProfileLoaded());
  }

}

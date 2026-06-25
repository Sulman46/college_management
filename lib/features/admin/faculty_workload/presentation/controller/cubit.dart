import 'package:college_management/core/extensions/dart_extensions.dart';
import 'package:college_management/features/admin/faculty_workload/model/workload_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helper/show_message.dart';
import '../../../../../widgets/loader_dialog.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class FacultyWorkLoadCubit extends Cubit<FacultyWorkLoadState> {
  final FacultyWorkLoadUseCase _useCase;
  FacultyWorkLoadCubit(this._useCase) : super(FacultyWorkLoadInit());

  WorkloadResponseModel? workloadResponseModel;

  String selectedDpt="All Dept";

  TextEditingController searchController=TextEditingController();

  String filterName="";

  void getSelectedDpt(String val){
    emit(FacultyWorkLoadLoading());
    selectedDpt=val;
    emit(FacultyWorkLoadLoaded());
  }

  void getSelectedName(String val){
    emit(FacultyWorkLoadLoading());
    filterName=val;
    emit(FacultyWorkLoadLoaded());
  }


  Future<void> get()async{
    showLoadingDialog();
     filterName="";
     searchController.clear();
    selectedDpt="All Dept";
    workloadResponseModel=null;
    emit(FacultyWorkLoadLoading());
    var response=await _useCase.get();
    if(response.isRight()){
      workloadResponseModel=response.asRight();
    }else{
      showMessage(response.asLeft(),isError: true);
    }
    emit(FacultyWorkLoadLoaded());
    closeLoadingDialog();
  }

}

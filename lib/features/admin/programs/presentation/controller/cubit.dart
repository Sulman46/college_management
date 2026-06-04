import 'package:college_management/core/enums/status_enum.dart';
import 'package:college_management/core/extensions/dart_extensions.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/programs/models/program_model.dart';
import 'package:college_management/features/admin/programs/models/program_request_model.dart';
import 'package:college_management/widgets/loader_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app/di_container.dart';
import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../core/controllers/screen_resizing/screen_resize_cubit.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class AdminProgramsCubit extends Cubit<AdminProgramsState> {
  final AdminProgramsUseCase _useCase;
  AdminProgramsCubit(this._useCase) : super(AdminProgramsInit());

  List<ProgramModel> _programsList=[];
  List<ProgramModel> get programsList=>_programsList;
  List<ProgramModel> filterProgramsList=[];
  double top=mdHeight(navigatorKey.currentContext!)*.9;
  double right=30;

  String selectedDepartment="";
  String selectedAffiliation="";
  StatusEnum? statusEnum;
  TextEditingController searchController=TextEditingController();

  void getDepartment({required String department, required String affiliation,required StatusEnum? status}){
    emit(AdminProgramsLoading());
    selectedDepartment=department;
    selectedAffiliation=affiliation;
    statusEnum=status;
    emit(AdminProgramsLoaded());
  }

  Future<void> getPrograms()async{
    emit(AdminProgramsLoading());
    showLoadingDialog();
   var response=await _useCase.getPrograms();
   if(response.isRight()){
     _programsList=response.asRight();
     filterProgramsList=response.asRight();
     searchController.clear();
   }else{
     showMessage(response.asLeft());
   }
    emit(AdminProgramsLoaded());
   closeLoadingDialog();
  }

  Future<bool> addPrograms(ProgramRequestModel model)async{
    showLoadingDialog();
   var response=await _useCase.addProgram(programRequestModel: model);
   if(response.isRight()){
     ProgramModel programModel=response.asRight();
     _programsList.add(programModel);
     filterProgramsList=[...programsList];
     searchController.clear();

     emit(AdminProgramsLoaded());
     closeLoadingDialog();
     return true;
   }else{
     showMessage(response.asLeft());
     emit(AdminProgramsLoaded());
     closeLoadingDialog();
     return false;
   }
  }

  Future<bool> updateProgram(ProgramRequestModel model)async{
    showLoadingDialog();
   var response=await _useCase.updateProgram(programRequestModel: model);
   if(response.isRight()){
     ProgramModel programModel=response.asRight();
     int index=programsList.indexWhere((element) => element.id==model.id,);
     _programsList[index]=programModel;
     filterProgramsList=[...programsList];
     searchController.clear();
     emit(AdminProgramsLoaded());
     closeLoadingDialog();
     return true;
   }else{
     showMessage(response.asLeft());
     emit(AdminProgramsLoaded());
     closeLoadingDialog();
     return false;
   }
  }

  Future<bool> deletePrograms(ProgramModel model)async{
    showLoadingDialog();
   var response=await _useCase.deleteProgram(id: model.id);
   if(response.isRight()){
     _programsList.removeWhere((element) => element.id==model.id);
     emit(AdminProgramsLoading());
     filterProgramsList=[...programsList];
     emit(AdminProgramsLoaded());

     closeLoadingDialog();
     return true;
   }else{
     showMessage(response.asLeft());
     emit(AdminProgramsLoaded());
     closeLoadingDialog();
     return false;
   }
  }

  void filterList(String val){
    emit(AdminProgramsLoading());
    List<ProgramModel> newList=[];
    for(var i in programsList){
      if(i.department.toString().toLowerCase().contains(val.toString().toLowerCase()) || i.code.toString().toLowerCase().contains(val.toString().toLowerCase())){
        newList.add(i);
      }
    }
    filterProgramsList=newList;
    emit(AdminProgramsLoaded());
  }

  void getButtonPosition({required double topVal,required double rightVal}){
    emit(AdminProgramsLoading());
    top+=topVal;
    right-=rightVal;
    emit(AdminProgramsLoaded());
  }


}



var _resizeCubit=DiContainer().sl<ScreenResizeCubit>();

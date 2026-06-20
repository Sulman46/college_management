
import 'dart:developer';

import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/controllers/screen_resizing/screen_resize_cubit.dart';
import 'package:college_management/core/extensions/dart_extensions.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/departments/data/model/department_model.dart';
import 'package:college_management/widgets/loader_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../data/model/request_new_department_model.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class AdminDepartmentCubit extends Cubit<AdminDepartmentState> {
  final AdminDepartmentUseCase _useCase;
  AdminDepartmentCubit(this._useCase) : super(AdminDepartmentInit());



  List<DepartmentModel> departmentList=[];
  List<DepartmentModel> activeDepartmentList=[];
  List<DepartmentModel> filterDepartmentList=[];
  double top=mdHeight(navigatorKey.currentContext!)*.9;
  double right=30;
  String departmentStatus="Active";

  void getStatus(String val){
    emit(AdminDepartmentLoading());
    departmentStatus=val;
    emit(AdminDepartmentLoaded());
  }


  Future<bool> addDepartment({required RequestNewDepartmentModel model})async{
    showLoadingDialog();
    emit(AdminDepartmentLoading());
   var response = await  _useCase.addNewDepartment(model: model);
   if(response.isRight()){
     departmentList.add(response.asRight());
     filterDepartmentList=List.from(departmentList);
     activeDepartmentList=List.from(departmentList.where((element) => element.status==DepartmentStatus.Active,));
     showMessage("New Department Added");
     closeLoadingDialog();
     emit(AdminDepartmentLoaded());
     return true;
   }else{
     showMessage(response.asLeft(),isError: true);
     closeLoadingDialog();
     return false;
   }
  }

  Future<bool> editDepartment({required RequestNewDepartmentModel model})async{
    showLoadingDialog();
    emit(AdminDepartmentLoading());
   var response = await  _useCase.editDepartment(model: model);
   if(response.isRight()){
  int replaceModel=   departmentList.indexWhere((element) => element.id==model.id,);
  departmentList[replaceModel]=response.asRight();
  int filterReplaceModel=   filterDepartmentList.indexWhere((element) => element.id==model.id,);
  filterDepartmentList[filterReplaceModel]=response.asRight();
  activeDepartmentList=List.from(departmentList.where((element) => element.status==DepartmentStatus.Active,));

     showMessage("Department Updated");
     closeLoadingDialog();
  emit(AdminDepartmentLoaded());
     return true;
   }else{
     showMessage(response.asLeft(),isError: true);
     closeLoadingDialog();
     return false;
   }
  }

  Future<void> getDepartments()async{
    showLoadingDialog();
    emit(AdminDepartmentLoading());
   var response = await  _useCase.getDepartments();
   if(response.isRight()){
     departmentList=response.asRight();
     filterDepartmentList=response.asRight();
     activeDepartmentList=List.from(departmentList.where((element) => element.status==DepartmentStatus.Active,));
     closeLoadingDialog();
   }else{
     showMessage(response.asLeft(),isError: true);
     log("2432432: ${response.asLeft()}");
     closeLoadingDialog();
   }
    emit(AdminDepartmentLoaded());
  }

  Future<bool> deleteDepartment(String id)async{
    showLoadingDialog();
    emit(AdminDepartmentLoading());
   var response = await  _useCase.deleteDepartment(id);
   if(response.isRight()){
     departmentList.removeWhere((element) => element.id==id,);
     filterDepartmentList.removeWhere((element) => element.id==id,);
     activeDepartmentList=List.from(departmentList.where((element) => element.status==DepartmentStatus.Active,));

     emit(AdminDepartmentLoaded());
     closeLoadingDialog();
     return true;
   }else{
     showMessage(response.asLeft(),isError: true);
     closeLoadingDialog();
     return false;
   }
  }

  void getButtonPosition({required double topVal,required double rightVal}){
    emit(AdminDepartmentLoading());
    top+=topVal;
    right-=rightVal;
    emit(AdminDepartmentLoaded());
  }

  void filterList(String val){
    emit(AdminDepartmentLoading());
    List<DepartmentModel> newList=[];
    for(var i in departmentList){
      if(i.name.toString().toLowerCase().contains(val.toString().toLowerCase()) || i.code.toString().toLowerCase().contains(val.toString().toLowerCase())){
        newList.add(i);
      }
    }
    filterDepartmentList=newList;
    emit(AdminDepartmentLoaded());
  }

}
var _resizeCubit=DiContainer().sl<ScreenResizeCubit>();



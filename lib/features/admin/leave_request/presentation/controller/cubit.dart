import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/extensions/dart_extensions.dart';
import '../../../../../core/helper/show_message.dart';
import '../../../../../widgets/loader_dialog.dart';
import '../../domain/usecase/usecase.dart';
import '../../models/faculty_leave_model.dart';
import 'state.dart';

class LeaveRequestCubit extends Cubit<LeaveRequestState> {
  final LeaveRequestUseCase _useCase;
  LeaveRequestCubit(this._useCase) : super(LeaveRequestInit());

  TextEditingController searchController=TextEditingController();

  List<FacultyLeaveModel> _dataList=[];
  List<FacultyLeaveModel> get dataList=>_dataList;

  List<FacultyLeaveModel> _filterList=[];
  List<FacultyLeaveModel> get filterList=>_filterList;

  String selectedCategory="";





  Future<bool> post(FacultyLeaveModel value)async{
    showLoadingDialog();
    emit(LeaveRequestLoading());
    var response=await _useCase.post(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(LeaveRequestLoaded());
      closeLoadingDialog();
      return false;
    }else{

      emit(LeaveRequestLoaded());
      closeLoadingDialog();
      var data=response.asRight();
      showMessage(data);
      return true;
    }
  }

  Future<void> get()async{
    showLoadingDialog();
    _dataList=[];
    _filterList=[];
    emit(LeaveRequestLoading());
    searchController.clear();
    var response=await _useCase.get();
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(LeaveRequestLoaded());
      closeLoadingDialog();
    }else{
      var data=response.asRight();
      _dataList=data;
      _filterList=List.from(_dataList);
      emit(LeaveRequestLoaded());
      closeLoadingDialog();
    }
  }

  Future<bool> delete(FacultyLeaveModel value)async{
    showLoadingDialog();
    emit(LeaveRequestLoading());
    var response=await _useCase.delete(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(LeaveRequestLoaded());
      closeLoadingDialog();
      return false;
    }else{
      emit(LeaveRequestLoaded());
      closeLoadingDialog();
      var data=response.asRight();
      showMessage(data);
      return true;
    }
  }


  Future<bool> update(FacultyLeaveModel value)async{

    showLoadingDialog();
    emit(LeaveRequestLoading());
    var response=await _useCase.update(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(LeaveRequestLoaded());
      closeLoadingDialog();
      return false;
    }else{
      emit(LeaveRequestLoaded());
      closeLoadingDialog();
      var data=response.asRight();
      showMessage(data);
      return true;
    }
  }



  void filterData(String val){
    emit(LeaveRequestLoading());
    List<FacultyLeaveModel> temp=[];
    for(var i in dataList){
      if(i.teacher!.name!.toLowerCase().toString().contains(val) || i.departments!.any((element) =>element.name!.toLowerCase().toString().contains(val) ,)  ){
        temp.add(i);
      }
    }
    _filterList=temp;
    emit(LeaveRequestLoaded());
  }


  void getStatusVal(String val){
    emit(LeaveRequestLoading());
    selectedCategory=val;
    emit(LeaveRequestLoaded());
  }

}

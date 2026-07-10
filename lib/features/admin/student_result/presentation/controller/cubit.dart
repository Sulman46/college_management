import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/extensions/dart_extensions.dart';
import '../../../../../core/helper/show_message.dart';
import '../../../../../widgets/loader_dialog.dart';
import '../../domain/usecase/usecase.dart';
import '../../model/filter_result_model.dart';
import '../../model/user_result_model.dart';
import 'state.dart';

class StudentResultCubit extends Cubit<StudentResultState> {
  final StudentResultUseCase _useCase;
  StudentResultCubit(this._useCase) : super(StudentResultInit());
  
  FilterResultModel filterModel=FilterResultModel();

  FilterResultModel submittedData=FilterResultModel();
  TextEditingController searchController=TextEditingController();
  String filterName="";


  List<UserResultModel> _dataList=[];
  List<UserResultModel> get dataList=>_dataList;

  void dataInit(){
    emit(StudentResultLoading());
    _dataList=[];
    searchController.clear();
    filterModel=FilterResultModel();
    filterName="";
    submittedData=FilterResultModel();
    emit(StudentResultLoaded());
  }
  
  void getSearchText(String val){
    emit(StudentResultLoading());
    filterName=val;
    emit(StudentResultLoaded());
  }


  void getStudentResultFilter(FilterResultModel val){
    emit(StudentResultLoading());
    filterModel=val;
    emit(StudentResultLoaded());
  }

  void getSubmittedData(FilterResultModel val){
    emit(StudentResultLoading());
    submittedData=val;
    emit(StudentResultLoaded());
  }


  Future<bool> getResult()async{
    filterName="";
    searchController.clear();
    showLoadingDialog();
    _dataList=[];
    emit(StudentResultLoading());
    var response=await _useCase.get(model: submittedData);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(StudentResultLoaded());
      closeLoadingDialog();
      return false;
    }else{
      var data=response.asRight();
      _dataList=data;
      emit(StudentResultLoaded());
      closeLoadingDialog();
      return true;
    }
  }
  
  
  
  
}

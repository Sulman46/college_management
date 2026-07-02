import 'dart:developer';

import 'package:college_management/features/admin/freez_unfreez_admin/models/freeze_request_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/extensions/dart_extensions.dart';
import '../../../../../core/helper/show_message.dart';
import '../../../../../widgets/loader_dialog.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class FreezUnFreezCubit extends Cubit<FreezUnFreezState> {
  final FreezUnFreezUseCase _useCase;
  FreezUnFreezCubit(this._useCase) : super(FreezUnFreezInit());

  TextEditingController searchController=TextEditingController();
  String searchText="";

  List<FreezeRequestModel> _dataList=[];
  List<FreezeRequestModel> get dataList=>_dataList;
  List<FreezeRequestModel> get filterList=>List.from(dataList.where((element) =>  isPendingTab==false?element.requestStatus!="Pending":true).where((element) =>( element.studentName!.toLowerCase().contains(searchText.toLowerCase()) ||element.srNo!.toLowerCase().contains(searchText.toLowerCase()) || element.reason!.toLowerCase().contains(searchText.toLowerCase())) ).toList());

  bool isPendingTab=true;

  Future<void> get()async{

  }

  void getTabVal(bool isPen){
    emit(FreezUnFreezLoading());
    isPendingTab=isPen;
    emit(FreezUnFreezLoaded());
  }

  void getSearchText(String val){
    emit(FreezUnFreezLoading());
    searchText=val;
    log("324432: ${val}");
    emit(FreezUnFreezLoaded());
  }


  Future<void> getPen()async{
    searchText="";
    searchController.clear();
    _dataList=[];
    showLoadingDialog();
    emit(FreezUnFreezLoading());
    var response=await _useCase.getPen();
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(FreezUnFreezLoaded());
      closeLoadingDialog();
    }else{
      var data=response.asRight();
      _dataList=data;
      emit(FreezUnFreezLoaded());
      closeLoadingDialog();
    }
  }


  Future<void> getFinal()async{
    searchText="";
    searchController.clear();
    _dataList=[];
    showLoadingDialog();
    emit(FreezUnFreezLoading());
    var response=await _useCase.getFinal();
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(FreezUnFreezLoaded());
      closeLoadingDialog();
    }else{
      var data=response.asRight();
      _dataList=data;
      emit(FreezUnFreezLoaded());
      closeLoadingDialog();
    }
  }


  Future<bool> delete(FreezeRequestModel value)async{
    showLoadingDialog();
    emit(FreezUnFreezLoading());
    var response=await _useCase.delete(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(FreezUnFreezLoaded());
      closeLoadingDialog();
      return false;
    }else{
      showMessage(response.asRight());
      emit(FreezUnFreezLoaded());
      closeLoadingDialog();
      return true;
    }
  }


  Future<bool> update(FreezeRequestModel value)async{

    showLoadingDialog();
    emit(FreezUnFreezLoading());
    var response=await _useCase.update(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(FreezUnFreezLoaded());
      closeLoadingDialog();
      return false;
    }else{
      showMessage(response.asRight());
      emit(FreezUnFreezLoaded());
      closeLoadingDialog();
      return true;
    }
  }

}

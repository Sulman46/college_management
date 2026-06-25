import 'package:college_management/features/admin/timetable_manager/models/new_slot_model.dart';
import 'package:college_management/features/admin/timetable_manager/models/table_filter_model.dart';
import 'package:college_management/features/admin/timetable_manager/models/time_table_manger_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/extensions/dart_extensions.dart';
import '../../../../../core/helper/show_message.dart';
import '../../../../../widgets/loader_dialog.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class TimetableManagerCubit extends Cubit<TimetableManagerState> {
  final TimetableManagerUseCase _useCase;
  TimetableManagerCubit(this._useCase) : super(TimetableManagerInit());



  TextEditingController searchController=TextEditingController();

  List<TimeTableManagerModel> _dataList=[];
  List<TimeTableManagerModel> get dataList=>_dataList;

  List<TimeTableManagerModel> _filterList=[];
  List<TimeTableManagerModel> get filterList=>_filterList;

  TimeTableGetDataModel addTimeTableManagerModel=TimeTableGetDataModel();


  NewSlotModel newSlotModel=NewSlotModel();
  TimeTableCellModel tableCellModel=TimeTableCellModel();

  TableFilterModel filterModel=TableFilterModel();

  void getFilterModel({required TableFilterModel model}){
    emit(TimetableManagerLoading());
    filterModel=model;
    emit(TimetableManagerLoaded());
  }

  void getSlotTime({required NewSlotModel model} ){
    emit(TimetableManagerLoading());
    newSlotModel=model;
    emit(TimetableManagerLoaded());
  }

  void getTableCell({required TimeTableCellModel model} ){
    emit(TimetableManagerLoading());
    tableCellModel=model;
    emit(TimetableManagerLoaded());
  }

  void getTimeTableManagerModel(TimeTableGetDataModel model){
    emit(TimetableManagerLoading());
    addTimeTableManagerModel=model;
    emit(TimetableManagerLoaded());
  }

  Future<bool> post(TimeTableManagerModel value)async{
    showLoadingDialog();
    emit(TimetableManagerLoading());
    var response=await _useCase.post(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(TimetableManagerLoaded());
      closeLoadingDialog();
      return false;
    }else{
      var data=response.asRight();
      showMessage(data);
      emit(TimetableManagerLoaded());
      closeLoadingDialog();
      return true;
    }
  }

  Future<void> get()async{
    showLoadingDialog();
    searchController.clear();
    _filterList=[];
    _dataList=[];
    emit(TimetableManagerLoading());
    var response=await _useCase.get();
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(TimetableManagerLoaded());
      closeLoadingDialog();
    }else{
      var data=response.asRight();
      _dataList=data;
      _filterList=List.from(_dataList);
      emit(TimetableManagerLoaded());
      closeLoadingDialog();
    }
  }

  Future<bool> delete(TimeTableManagerModel value)async{
    showLoadingDialog();
    emit(TimetableManagerLoading());
    var response=await _useCase.delete(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(TimetableManagerLoaded());
      closeLoadingDialog();
      return false;
    }else{
      emit(TimetableManagerLoaded());
      closeLoadingDialog();

      var data=response.asRight();
      showMessage(data);
      return true;
    }
  }


  Future<bool> update(TimeTableManagerModel value)async{

    showLoadingDialog();
    emit(TimetableManagerLoading());
    var response=await _useCase.update(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(TimetableManagerLoaded());
      closeLoadingDialog();
      return false;
    }else{
      emit(TimetableManagerLoaded());
      closeLoadingDialog();

      var data=response.asRight();
      showMessage(data);
      return true;
    }
  }



  void filterData(String val){
    emit(TimetableManagerLoading());
    List<TimeTableManagerModel> temp=[];
    for(var i in dataList){
      if(i.programModel!.name!.toLowerCase().toString().contains(val) || i.programModel!.department!.name.toLowerCase().toString().contains(val) || i.programModel!.degree!.toLowerCase().toString().contains(val) ){
        temp.add(i);
      }
    }
    _filterList=temp;
    emit(TimetableManagerLoaded());
  }



  
}

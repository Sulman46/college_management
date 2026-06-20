import 'package:college_management/features/admin/timetable_manager/models/new_slot_model.dart';
import 'package:college_management/features/admin/timetable_manager/models/table_filter_model.dart';
import 'package:college_management/features/admin/timetable_manager/models/time_table_manger_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../core/extensions/dart_extensions.dart';
import '../../../../../core/helper/show_message.dart';
import '../../../../../widgets/loader_dialog.dart';
import '../../domain/usecase/usecase.dart';
import '../../models/time_table_manger_model.dart';
import 'state.dart';

class TimetableManagerCubit extends Cubit<TimetableManagerState> {
  final TimetableManagerUseCase _useCase;
  TimetableManagerCubit(this._useCase) : super(TimetableManagerInit());



  TextEditingController searchController=TextEditingController();

  List<TimeTableManagerModel> _dataList=[];
  List<TimeTableManagerModel> get dataList=>_dataList;

  List<TimeTableManagerModel> _filterList=[];
  List<TimeTableManagerModel> get filterList=>_filterList;

  TimeTableManagerModel addTimeTableManagerModel=TimeTableManagerModel();

  String? shiftType;

  NewSlotModel newSlotModel=NewSlotModel();
  TimeTableCellModel tableCellModel=TimeTableCellModel();

  TableFilterModel filterModel=TableFilterModel();

  void getShiftType(String? val){
    emit(TimetableManagerLoading());
    shiftType=val;
    emit(TimetableManagerLoaded());
  }

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

  void getTimeTableManagerModel(TimeTableManagerModel model){
    emit(TimetableManagerLoading());
    addTimeTableManagerModel=model;
    emit(TimetableManagerLoaded());
  }

  Future<bool> post(TimeTableManagerModel value)async{
    showLoadingDialog();
    emit(TimetableManagerLoading());
    var response=await _useCase.post(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft());
      emit(TimetableManagerLoaded());
      closeLoadingDialog();
      return false;
    }else{
      searchController.clear();
      var data=response.asRight();
      _dataList.add(data);
      _filterList=List.from(dataList);
      _filterList.toSet();
      emit(TimetableManagerLoaded());
      closeLoadingDialog();
      return true;
    }
  }

  Future<void> get()async{
    showLoadingDialog();
    emit(TimetableManagerLoading());
    searchController.clear();
    var response=await _useCase.get();
    if(response.isLeft()){
      showMessage(response.asLeft());
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
      showMessage(response.asLeft());
      emit(TimetableManagerLoaded());
      closeLoadingDialog();
      return false;
    }else{
      searchController.clear();
      _dataList.removeWhere((element) => element.id==value.id,);
      _filterList=List.from(dataList);
      emit(TimetableManagerLoaded());
      closeLoadingDialog();
      return true;
    }
  }


  Future<bool> update(TimeTableManagerModel value)async{

    showLoadingDialog();
    emit(TimetableManagerLoading());
    var response=await _useCase.update(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft());
      emit(TimetableManagerLoaded());
      closeLoadingDialog();
      return false;
    }else{
      var data=response.asRight();
      int index= dataList.indexWhere((element) => element.id==value.id,);
      searchController.clear();
      _dataList[index]=value;
      _filterList=List.from(dataList);
      emit(TimetableManagerLoaded());
      closeLoadingDialog();
      return true;
    }
  }



  void filterData(String val){
    emit(TimetableManagerLoading());
    List<TimeTableManagerModel> temp=[];
    for(var i in dataList){
      if(i.programName!.toLowerCase().toString().contains(val) || i.department!.toLowerCase().toString().contains(val) || i.degree!.toLowerCase().toString().contains(val) ){
        temp.add(i);
      }
    }
    _filterList=temp;
    emit(TimetableManagerLoaded());
  }



  
}

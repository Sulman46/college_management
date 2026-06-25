import 'package:college_management/features/admin/coordinator_management/presentation/models/coordinator_register_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../core/extensions/dart_extensions.dart';
import '../../../../../core/helper/show_message.dart';
import '../../../../../widgets/loader_dialog.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class CoordinatorManagementCubit extends Cubit<CoordinatorManagementState> {
  final CoordinatorManagementUseCase _useCase;
  CoordinatorManagementCubit(this._useCase) : super(CoordinatorManagementInit());

  List<CoordinatorRegisterModel> _dataList=[];
  List<CoordinatorRegisterModel> get dataList=>_dataList;

  List<CoordinatorRegisterModel> _filterList=[];
  List<CoordinatorRegisterModel> get filterList=>_filterList;
  
  
  CoordinatorRegisterModel coordinatorRegisterModel=CoordinatorRegisterModel();

  TextEditingController searchController=TextEditingController();

  double top=mdHeight(navigatorKey.currentContext!)*.9;
  double right=30;
  void getButtonPosition({required double topVal,required double rightVal}){
    emit(CoordinatorManagementLoading());
    top+=topVal;
    right-=rightVal;
    emit(CoordinatorManagementLoaded());
  }


  void getCoordinatorModel(CoordinatorRegisterModel model){
    emit(CoordinatorManagementLoading());
    coordinatorRegisterModel=model;
    emit(CoordinatorManagementLoaded());
  }




  Future<bool> post(CoordinatorRegisterModel value)async{
    showLoadingDialog();
    emit(CoordinatorManagementLoading());
    var response=await _useCase.post(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(CoordinatorManagementLoaded());
      closeLoadingDialog();
      return false;
    }else{

      emit(CoordinatorManagementLoaded());
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
    emit(CoordinatorManagementLoading());
    searchController.clear();
    var response=await _useCase.get();
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(CoordinatorManagementLoaded());
      closeLoadingDialog();
    }else{
      var data=response.asRight();
      _dataList=data;
      _filterList=List.from(_dataList);
      emit(CoordinatorManagementLoaded());
      closeLoadingDialog();
    }
  }

  Future<bool> delete(CoordinatorRegisterModel value)async{
    showLoadingDialog();
    emit(CoordinatorManagementLoading());
    var response=await _useCase.delete(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(CoordinatorManagementLoaded());
      closeLoadingDialog();
      return false;
    }else{
      emit(CoordinatorManagementLoaded());
      closeLoadingDialog();
      var data=response.asRight();
      showMessage(data);
      return true;
    }
  }


  Future<bool> update(CoordinatorRegisterModel value)async{

    showLoadingDialog();
    emit(CoordinatorManagementLoading());
    var response=await _useCase.update(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(CoordinatorManagementLoaded());
      closeLoadingDialog();
      return false;
    }else{
      emit(CoordinatorManagementLoaded());
      closeLoadingDialog();
      var data=response.asRight();
      showMessage(data);
      return true;
    }
  }



  void filterData(String val){
    emit(CoordinatorManagementLoading());
    List<CoordinatorRegisterModel> temp=[];
    for(var i in dataList){
      if(i.coordinatorName!.toLowerCase().toString().contains(val) || i.designation!.toLowerCase().toString().contains(val) || i.status!.toLowerCase().toString().contains(val) || i.designation!.toLowerCase().toString().contains(val) || i.programs!.where((e) => e.name!.toLowerCase().toString().contains(val),).isNotEmpty|| i.programs!.where((e) => e.department!.name!.toLowerCase().toString().contains(val),).isNotEmpty ){
        temp.add(i);
      }
    }
    _filterList=temp;
    emit(CoordinatorManagementLoaded());
  }


}

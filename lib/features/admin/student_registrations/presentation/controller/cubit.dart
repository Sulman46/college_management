import 'dart:io';
import 'package:college_management/features/admin/student_registrations/models/student_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../core/extensions/dart_extensions.dart';
import '../../../../../core/helper/image_picker_class.dart';
import '../../../../../core/helper/show_message.dart';
import '../../../../../widgets/loader_dialog.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class StudentRegistrationCubit extends Cubit<StudentRegistrationState> {
  final StudentRegistrationUseCase _useCase;
  StudentRegistrationCubit(this._useCase) : super(StudentRegistrationInit());

  XFile? userImage;
  String? gender;
  String? status;
  StudentModel studentModel=StudentModel();
  StudentModel? updateStudentModel;

  TextEditingController searchController=TextEditingController();

  List<StudentModel> _dataList=[];
  List<StudentModel> get dataList=>_dataList;

  List<StudentModel> _filterList=[];
  List<StudentModel> get filterList=>_filterList;

  double top=mdHeight(navigatorKey.currentContext!)*.9;
  double right=30;
  void getButtonPosition({required double topVal,required double rightVal}){
    emit(StudentRegistrationLoading());
    top+=topVal;
    right-=rightVal;
    emit(StudentRegistrationLoaded());
  }

  void getGender(String? val){
    emit(StudentRegistrationLoading());
    gender=val;
    emit(StudentRegistrationLoaded());
  }
  void getStatus(String? val){
    emit(StudentRegistrationLoading());
    status=val;
    emit(StudentRegistrationLoaded());
  }


  void getStudentModel(StudentModel val){
    emit(StudentRegistrationLoading());
    studentModel=val;
    emit(StudentRegistrationLoaded());
  }

  void getStudentUpdateModel(StudentModel? val){
    emit(StudentRegistrationLoading());
    updateStudentModel=val;
    emit(StudentRegistrationLoaded());
  }

  Future<void> pickImage() async {
    final picked = await ImagePickerClass.pickImage();
    if (picked != null) {
      emit(StudentRegistrationLoading());
        userImage=picked;
      emit(StudentRegistrationLoaded());
    }
  }



  Future<bool> post(StudentModel value)async{
    showLoadingDialog();
    emit(StudentRegistrationLoading());
    var response=await _useCase.post(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(StudentRegistrationLoaded());
      closeLoadingDialog();
      return false;
    }else{
      var data=response.asRight();
      showMessage(data);
      emit(StudentRegistrationLoaded());
      closeLoadingDialog();
      await get();
      return true;
    }
  }

  Future<void> get()async{
    showLoadingDialog();
    emit(StudentRegistrationLoading());
    var response=await _useCase.get();
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(StudentRegistrationLoaded());
      closeLoadingDialog();
    }else{
      searchController.clear();
      var data=response.asRight();
      _dataList=data;
      _filterList=List.from(_dataList);
      emit(StudentRegistrationLoaded());
      closeLoadingDialog();
    }
  }

  Future<bool> delete(StudentModel value)async{
    showLoadingDialog();
    emit(StudentRegistrationLoading());
    var response=await _useCase.delete(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(StudentRegistrationLoaded());
      closeLoadingDialog();
      return false;
    }else{
      searchController.clear();

      _dataList.removeWhere((element) => element.id==value.id,);
      _filterList=List.from(dataList);
      emit(StudentRegistrationLoaded());
      closeLoadingDialog();
      return true;
    }
  }


  Future<bool> update(StudentModel value)async{

    showLoadingDialog();
    emit(StudentRegistrationLoading());
    var response=await _useCase.update(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(StudentRegistrationLoaded());
      closeLoadingDialog();
      return false;
    }else{
      var data=response.asRight();
      int index= dataList.indexWhere((element) => element.id==value.id,);
      searchController.clear();
      _dataList[index]=data;
      _filterList=List.from(dataList);
      emit(StudentRegistrationLoaded());
      closeLoadingDialog();
      return true;
    }
  }



  void filterData(String val){
    emit(StudentRegistrationLoading());
    List<StudentModel> temp=[];
    for(var i in dataList){
      if(i.name!.toLowerCase().toString().contains(val)||i.rollNo!.toLowerCase().toString().contains(val)||i.registrationNumber!.toLowerCase().toString().contains(val) ){
        temp.add(i);
      }
    }

    _filterList=temp;
    emit(StudentRegistrationLoaded());
  }


  void initValues(){
    emit(StudentRegistrationLoaded());
     userImage=null;
    gender=null;
    status=null;
    updateStudentModel=null;
     studentModel=StudentModel();
     emit(StudentRegistrationLoaded());

  }


}

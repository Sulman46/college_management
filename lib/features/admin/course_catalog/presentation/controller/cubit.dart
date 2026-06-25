
import 'package:college_management/core/extensions/dart_extensions.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/widgets/loader_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../domain/usecase/usecase.dart';
import '../../models/course_catalog_model.dart';
import 'state.dart';

class CourseCatalogAdminCubit extends Cubit<CourseCatalogAdminState> {
  final CourseCatalogAdminUseCase _useCase;
  CourseCatalogAdminCubit(this._useCase) : super(CourseCatalogAdminInit());

String courseType="";
String courseCategory="";
List<CourseCatalogDepartmentModel> department=[];

  List<CourseCatalogModel> _courseCatalogList=[];
  List<CourseCatalogModel> get courseCatalogList=>_courseCatalogList;

  List<CourseCatalogModel> get activeCourseCatalogList=>courseCatalogList.where((element) => element.status=="Active",).toList();

  List<CourseCatalogModel> filterCourseCatalogList=[];

  TextEditingController searchController=TextEditingController();

  double top=mdHeight(navigatorKey.currentContext!)*.9;
  double right=30;

  void getButtonPosition({required double topVal,required double rightVal}){
    emit(CourseCatalogAdminLoading());
    top+=topVal;
    right-=rightVal;
    emit(CourseCatalogAdminLoaded());
  }

  void getDepartment({required List<CourseCatalogDepartmentModel> depart, required String type,required String category}){
    emit(CourseCatalogAdminLoading());
    department=depart;
    courseType=type;
    courseCategory=category;
    emit(CourseCatalogAdminLoaded());
  }

  void removeDepartment(CourseCatalogDepartmentModel val){
    emit(CourseCatalogAdminLoading());
    department.removeWhere((element) => element==val,);
    emit(CourseCatalogAdminLoaded());
  }

  Future<void> getCourseCatalogList()async{
    searchController.clear();
    _courseCatalogList=[];
    filterCourseCatalogList=[];
    emit(CourseCatalogAdminLoading());
    showLoadingDialog();
    var response=await _useCase.getCourseCatalog();

    if(response.isRight()){
      var data=response.asRight();
      _courseCatalogList=List.from(data);
      filterCourseCatalogList=courseCatalogList;
    }else{
      showMessage(response.asLeft(),isError: true);
    }
    emit(CourseCatalogAdminLoaded());
    closeLoadingDialog();
  }
  
  Future<bool> addCourseCatalog({required CourseCatalogModel val}) async {
    emit(CourseCatalogAdminLoading());
    showLoadingDialog();
    var response=await _useCase.addCourseCatalog(model: val);
    if(response.isRight()){
      showMessage(response.asRight());
      emit(CourseCatalogAdminLoaded());
      closeLoadingDialog();
      return true;
    }else{
      showMessage(response.asLeft(),isError: true);
      emit(CourseCatalogAdminLoaded());
      closeLoadingDialog();
      return false;
    }
  }


  Future<bool> updateCatalog({required CourseCatalogModel val}) async {
    searchController.clear();
    emit(CourseCatalogAdminLoading());
    showLoadingDialog();
    var response=await _useCase.updateCatalog(model: val);
    if(response.isRight()){
      closeLoadingDialog();
      showMessage(response.asRight());
      emit(CourseCatalogAdminLoaded());
      return true;
    }else{
      showMessage(response.asLeft(),isError: true);
      emit(CourseCatalogAdminLoaded());
      closeLoadingDialog();
      return false;
    }
  }

  Future<bool> deleteCatalog({required CourseCatalogModel val}) async {
    emit(CourseCatalogAdminLoading());
    showLoadingDialog();
    var response=await _useCase.deleteCourseCatalog(model: val);
    if(response.isRight()){
      closeLoadingDialog();
      emit(CourseCatalogAdminLoaded());
      showMessage(response.asRight());
      return true;
    }else{
      showMessage(response.asLeft(),isError: true);
      emit(CourseCatalogAdminLoaded());
      closeLoadingDialog();
      return false;
    }
  }

  void filterData(String val){
    emit(CourseCatalogAdminLoading());
    List<CourseCatalogModel> temp=[];
    if(courseCatalogList.isNotEmpty){
      for(var i in courseCatalogList){
        if(i.courseTitle!.toLowerCase().toString().contains(val)|| i.courseCode!.toLowerCase().toString().contains(val)){
          temp.add(i);
        }
      }
    }
    filterCourseCatalogList=temp;
    emit(CourseCatalogAdminLoaded());
  }


}



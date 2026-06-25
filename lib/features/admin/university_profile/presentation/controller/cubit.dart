import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:college_management/core/app/myapp.dart';
import 'package:college_management/core/enums/status_enum.dart';
import 'package:college_management/core/extensions/dart_extensions.dart';
import 'package:college_management/core/helper/share_pref/auth_sharepref_helper.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/Authentication/models/user_model.dart';
import 'package:college_management/features/admin/university_profile/models/affiliation_model.dart';
import 'package:college_management/features/admin/university_profile/models/university_model.dart';
import 'package:college_management/features/admin/university_profile/models/update_uni_specific_section_model.dart';
import 'package:college_management/widgets/loader_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/app/di_container.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../core/controllers/screen_resizing/screen_resize_cubit.dart';
import '../../domain/usecase/usecase.dart';
import '../../models/profile_update_model.dart';
import '../../models/university_profile_model.dart';
import 'state.dart';

class UniversityProfileCubit extends Cubit<UniversityProfileState> {
  final UniversityProfileUseCase _useCase;
  UniversityProfileCubit(this._useCase) : super(UniversityProfileInit());

  bool editUniversityProfile=false;

  XFile? pickedUniversityImage;

  double top=mdHeight(navigatorKey.currentContext!)*.9;
  double right=30;

  StatusEnum? statusEnum;
  String? sector;

  String? severityValue;

  AffiliationModel? updateModel;


  UniversityModel? universityModel;

  List<AffiliationModel> affiliationFilterList=[]
  ;
  List<AffiliationModel> get activeAffiliationList=>universityModel?.affiliationModel?.where((element) => element.status=="Active",).toList()??[];

  void getSeverityValue(String? val){
    emit(UniversityProfileLoading());
    severityValue=val;
    emit(UniversityProfileLoaded());

  }
  void getUpdateModel(AffiliationModel? model){
    emit(UniversityProfileLoading());
    updateModel=model;
    emit(UniversityProfileLoaded());

  }

  void getStatusEnum(StatusEnum? val){
    emit(UniversityProfileLoading());
    statusEnum=val;
    emit(UniversityProfileLoaded());
  }


  void getSectorEnum(String? val){
    emit(UniversityProfileLoading());
    sector=val;
    emit(UniversityProfileLoaded());
  }

  void pickUniversityImage(XFile? val)async{
    emit(UniversityProfileLoading());
    pickedUniversityImage=val;

    emit(UniversityProfileLoaded());
   await uploadProfileImage();
  }

  void updateEditUniversityProfile(bool val){
    emit(UniversityProfileLoading());
    editUniversityProfile=val;
    emit(UniversityProfileLoaded());
  }


  void filterData(String val){
    emit(UniversityProfileLoading());
    List<AffiliationModel> temp=[];
    if(universityModel!=null){
      for(var i in universityModel!.affiliationModel!){
        if(i.name.toLowerCase().toString().contains(val)){
          temp.add(i);
        }
      }
    }
    affiliationFilterList=temp;
    emit(UniversityProfileLoaded());
  }

  Future<bool> updateAffiliation(AffiliationModel model,{String? message})async{
    emit(UniversityProfileLoading());
    showLoadingDialog();
    var list=universityModel?.affiliationModel??[];
    int index=list.indexWhere((element) => element.id==model.id,);
    UpdateUniSpecificSectionModel uniSpecificSectionModel=UpdateUniSpecificSectionModel(index: index,affiliationModel: model,id: universityModel?.id??"");
    var response=await _useCase.updateUniversitySetup(model: uniSpecificSectionModel);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      closeLoadingDialog();
      emit(UniversityProfileLoaded());
      return false;
    }else{
      list[index]=model;
      universityModel= universityModel!.copyWith(affiliationModel: list);
      filterData("");
      showMessage(message??response.asRight());
      closeLoadingDialog();
      emit(UniversityProfileLoaded());
      return true;
    }
  }


  Future<bool> deletedAffiliation(AffiliationModel model)async{
    emit(UniversityProfileLoading());
    showLoadingDialog();
    var list=universityModel?.affiliationModel??[];
    int index=list.indexWhere((element) => element.id==model.id,);
    UpdateUniSpecificSectionModel uniSpecificSectionModel=UpdateUniSpecificSectionModel(index: index,affiliationModel: model,id: universityModel?.id??"");
    
    var response=await _useCase.deleteUniversitySetup(model: uniSpecificSectionModel);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      closeLoadingDialog();
      emit(UniversityProfileLoaded());
      return false;
    }else{
      showMessage(response.asRight());
      closeLoadingDialog();
      emit(UniversityProfileLoaded());
     await getUniversitySetup();
      return true;
    }
  }

  Future<bool> addUniversitySetup(UniversityModel model,{String? message})async{
    emit(UniversityProfileLoading());
    showLoadingDialog();
    var response=await _useCase.addUniversitySetup(universityModel: model);
    if(response.isRight()){
      UniversityModel uniModel=response.asRight();
      universityModel=uniModel;
      editUniversityProfile=false;
      affiliationFilterList=uniModel.affiliationModel??[];
      showMessage(message??"Data Added Successfully");
      closeLoadingDialog();
      emit(UniversityProfileLoaded());
      return true;
    }else{
      showMessage(response.asLeft(),isError: true);
      closeLoadingDialog();
      emit(UniversityProfileLoaded());
      return false;
    }
  }

  Future<UniversityModel?> getUniversitySetup()async{
    emit(UniversityProfileLoading());
    showLoadingDialog();
    var response=await _useCase.getUniversitySetup();
    if(response.isRight()){
      UniversityModel uniModel=response.asRight();
      universityModel=uniModel;
      editUniversityProfile=false;
      affiliationFilterList=uniModel.affiliationModel??[];
      closeLoadingDialog();
      emit(UniversityProfileLoaded());
      return uniModel;
    }else{
      showMessage(response.asLeft(),isError: true);
      closeLoadingDialog();
      emit(UniversityProfileLoaded());
      return null;
    }
  }



  Future<void> uploadProfileImage()async{
    emit(UniversityProfileLoading());
    showLoadingDialog();
    UserModel? user=await AuthShareprefHelper.getUser();
    if(user==null){
      showMessage("User Not Found");
      navigatorKey.currentContext!.push("/login");
      return;
    }
    ProfileImageUpdateModel model=ProfileImageUpdateModel(userId: user.id, image: File(pickedUniversityImage!.path));
    var response=await _useCase.uploadProfile(profileModel: model);
    if(response.isRight()){
      UniversityProfileModel  tempModel=universityModel!.universityProfileModel!;
      universityModel=universityModel!.copyWith(universityProfileModel: tempModel.copyWith(logo: response.asRight()));
    }else{
      showMessage(response.asLeft(),isError: true);
      emit(UniversityProfileLoaded());
    }
    closeLoadingDialog();
  }

  void getButtonPosition({required double topVal,required double rightVal}){
    emit(UniversityProfileLoading());
    top+=topVal;
    right-=rightVal;
    emit(UniversityProfileLoaded());
  }

}


var _resizeCubit=DiContainer().sl<ScreenResizeCubit>();

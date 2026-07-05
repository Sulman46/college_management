import 'dart:math';
import 'package:college_management/features/admin/coordinator_management/presentation/models/coordinator_register_model.dart';
import 'package:college_management/features/admin/hod_assignment/models/hod_assign_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/enums/user_enums.dart';
import '../../../../../core/extensions/dart_extensions.dart';
import '../../../../../core/helper/show_message.dart';
import '../../../../../widgets/loader_dialog.dart';
import '../../../teacher_records/models/teacher_model.dart';
import '../../domain/usecase/usecase.dart';
import '../../models/neural_generate_model.dart';
import '../../models/neural_user_management_model.dart';
import '../../models/neural_widget_model.dart';
import 'state.dart';

class NeuralGeneratorCubit extends Cubit<NeuralGeneratorState> {
  final NeuralGeneratorUseCase _useCase;
  NeuralGeneratorCubit(this._useCase) : super(NeuralGeneratorInit());

  UserRole? userRole;
  List<NeuralWidgetModel> _userIds=[];
  List<NeuralWidgetModel> get userIds=>_userIds;
  TextEditingController searchController=TextEditingController();

  String selectedDepartment="";
  String name="";

  List<TeacherModel> _teachersList=[];
  List<TeacherModel> get teachersList=>_teachersList;
  List<TeacherModel> get teachersFilterList=>teachersList.where((element) => element.department!.any((element) => element.name.toLowerCase().contains(selectedDepartment.toLowerCase()),) && element.teacherName!.toLowerCase().contains(name.toLowerCase())).toList();

  List<CoordinatorRegisterModel> _coordinatorList=[];
  List<CoordinatorRegisterModel> get coordinatorList=>_coordinatorList;
  List<CoordinatorRegisterModel> get coordinatorFilterList=>coordinatorList.where((element) => element.coordinatorName!.toLowerCase().contains(name.toLowerCase()) && element.programs!.any((element) => element.department!.name!.toLowerCase().contains(selectedDepartment.toLowerCase()),),).toList();

  List<HodAssignModel> _hodList=[];
  List<HodAssignModel> get hodList=>_hodList;
  List<HodAssignModel> get hodFilterList=>hodList.where((element) => element.department!.name!.toLowerCase().contains(selectedDepartment.toLowerCase()) && element.teacher!.teacherName!.toLowerCase().contains(name.toLowerCase())).toList();

  List<NeuralUserManagementModel> _neuralUsersManagementList=[];
  List<NeuralUserManagementModel> get neuralUsersManagementList=>_neuralUsersManagementList;
  List<NeuralUserManagementModel> get neuralUsersManagementFilter=>neuralUsersManagementList.where((element) => element.role!.toLowerCase().contains(role.toLowerCase()) && element.status!.toLowerCase().contains(status.toLowerCase()) && (element.name!.toLowerCase().contains(userSearch.toLowerCase()) || element.email!.toLowerCase().contains(userSearch.toLowerCase()) || element.username!.toLowerCase().contains(userSearch.toLowerCase()))).toList();

  String role='';
  String status="";
  TextEditingController searchUserManagement=TextEditingController();
  String userSearch="";

  void getIds(List<NeuralWidgetModel> ids){
    emit(NeuralGeneratorLoading());
    _userIds=ids;
    emit(NeuralGeneratorLoaded());
  }
  
  void checkAll(){
    if(userRole==UserRole.teacher){
      
    }
  }

  void getUserRole(UserRole? val){
    emit(NeuralGeneratorLoading());
    userRole=val;
    selectedDepartment='';
    name="";
    _userIds=[];
    searchController.clear();
    emit(NeuralGeneratorLoaded());
  }

  void getDepartmentName(String val){
    emit(NeuralGeneratorLoading());
    selectedDepartment=val=="All Dept" || val==""?"":val;
    emit(NeuralGeneratorLoaded());
  }

  void getName(String val){
    emit(NeuralGeneratorLoading());
    name=val;
    emit(NeuralGeneratorLoaded());
  }

  Future<bool> registerAccount(NeuralGenerateModel value)async {
    var response=await _useCase.post(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      return false;
    }else{
      return true;
    }
  }



  String makeUsername(String name) {
    // Remove all spaces and convert to lowercase
    final cleanedName = name.toLowerCase().replaceAll(RegExp(r'\s+'), '');

    final random = Random();
    String randomNamePicked = '';

    if (cleanedName.length <= 5) {
      // If the name is 5 characters or fewer, use the whole thing
      randomNamePicked = cleanedName;
    } else {
      // Convert string to characters to pick from
      List<String> chars = cleanedName.split('');

      // Pick 5 unique character positions randomly
      for (int i = 0; i < 5; i++) {
        int randomIndex = random.nextInt(chars.length);
        randomNamePicked += chars.removeAt(randomIndex); // Prevents picking the same index twice
      }
    }

    // Generate 2 random alphanumeric characters
    final randomChars = String.fromCharCodes(
      List.generate(3, (_) => random.nextInt(36)).map(
            (value) => value < 10 ? 48 + value : 87 + value,
      ),
    );

    final msStr = DateTime.now().millisecond.toString().padLeft(3, '0');

    return '$randomNamePicked$msStr$randomChars';
  }


  String makePassword() {
    // Generate 8 random alphanumeric characters in uppercase
    final random = Random();
    final randomChars = String.fromCharCodes(
      List.generate(8, (_) => random.nextInt(36)).map(
            (value) => value < 10 ? 48 + value : 87 + value, // ASCII for 0-9 and a-z
      ),
    ).toUpperCase();

    return randomChars;
  }



  Future<bool> post()async{
    showLoadingDialog();

    /// todo model
    List<NeuralWidgetModel> temp=List.from(userIds);
    bool val=true;
    for(var i in temp){
      NeuralGenerateModel model=NeuralGenerateModel(departmentValue: i.department,email: i.email,name: i.name,userName: i.userName==null || i.userName=="-" || i.userName==""?makeUsername(i.name):i.userName,role: userRole!.toJson(),userId: i.id,password:makePassword() );
      var response=await registerAccount(model);
      if(!response){
        val=false;
        emit(NeuralGeneratorLoaded());
      }else{
        _userIds.removeWhere((element) => element.id==i.id);
      }
    }
    if(val){
      showMessage("Account(s) generated successfully");
    }
    closeLoadingDialog();
    emit(NeuralGeneratorLoading());
    return val;
  }


  Future<void> getTeachers()async{
    showLoadingDialog();
    _teachersList=[];
    emit(NeuralGeneratorLoading());
    var response=await _useCase.getTeachers();
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(NeuralGeneratorLoaded());
      closeLoadingDialog();
    }else{
      var data=response.asRight();
      _teachersList=data;
      emit(NeuralGeneratorLoaded());
      closeLoadingDialog();
    }
  }

  Future<void> getCoordinator()async{
    showLoadingDialog();
    _coordinatorList=[];
    emit(NeuralGeneratorLoading());
    var response=await _useCase.getCoordinator();
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(NeuralGeneratorLoaded());
      closeLoadingDialog();
    }else{
      var data=response.asRight();
      _coordinatorList=data;
      emit(NeuralGeneratorLoaded());
      closeLoadingDialog();
    }
  }

  Future<void> getHod()async{
    showLoadingDialog();
    _hodList=[];
    emit(NeuralGeneratorLoading());
    var response=await _useCase.getHod();
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(NeuralGeneratorLoaded());
      closeLoadingDialog();
    }else{
      var data=response.asRight();
      _hodList=data;
      emit(NeuralGeneratorLoaded());
      closeLoadingDialog();
    }
  }


  /// user management
  Future<void> getNeuralUserManagement()async{
    userSearch="";
    searchUserManagement.text="";
    status="";
    role="";
    showLoadingDialog();
    _neuralUsersManagementList=[];
    emit(NeuralGeneratorLoading());
    var response=await _useCase.getNeuralUserManagement();
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(NeuralGeneratorLoaded());
      closeLoadingDialog();
    }else{
      var data=response.asRight();
      _neuralUsersManagementList=data;
      emit(NeuralGeneratorLoaded());
      closeLoadingDialog();
    }
  }



  Future<bool> statusPatchNeuralUserManagement(NeuralUserManagementModel model)async{
    showLoadingDialog();
    var response=await _useCase.statusPatchNeuralUserManagement(model: model);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      closeLoadingDialog();
      emit(NeuralGeneratorLoading());
      return false;
    }else{
      showMessage(response.asRight());
      closeLoadingDialog();
      emit(NeuralGeneratorLoading());
      return true;
    }
  }


  Future<bool> keyPatchNeuralUserManagement(NeuralUserManagementModel model)async{
    showLoadingDialog();
    var response=await _useCase.keyPatchNeuralUserManagement(model: model);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      closeLoadingDialog();
      emit(NeuralGeneratorLoading());
      return false;
    }else{
      showMessage(response.asRight());
      closeLoadingDialog();
      emit(NeuralGeneratorLoading());
      return true;
    }
  }


  void getUserSearch(String val){
    emit(NeuralGeneratorLoading());
    userSearch=val;
    emit(NeuralGeneratorLoaded());
  }


  void getUserStatus(String val){
    emit(NeuralGeneratorLoading());
    status=val;
    emit(NeuralGeneratorLoaded());
  }

  void getUserManagementRole(String val){
    emit(NeuralGeneratorLoading());
    role=val;
    emit(NeuralGeneratorLoaded());
  }



}

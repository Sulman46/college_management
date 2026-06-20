import 'package:college_management/features/admin/student_enrollment/data/models/student_enrollment_filter_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/extensions/dart_extensions.dart';
import '../../../../../core/helper/show_message.dart';
import '../../../../../widgets/loader_dialog.dart';
import '../../data/models/student_enrollment_model.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class StudentEnrollmentCubit extends Cubit<StudentEnrollmentState> {
  final StudentEnrollmentUseCase _useCase;
  StudentEnrollmentCubit(this._useCase) : super(StudentEnrollmentInit());

  StudentEnrollmentFilterModel filterModel=StudentEnrollmentFilterModel();
  List<StudentEnrollmentModel> _dataList=[];
  List<StudentEnrollmentModel> get dataList=>_dataList;

  bool isNewTab=true;

  void getTabIndex(bool val){
    emit(StudentEnrollmentLoading());
    isNewTab=val;
    emit(StudentEnrollmentLoaded());
  }


  void getStudentEnrollmentFilter(StudentEnrollmentFilterModel val){
    emit(StudentEnrollmentLoading());
    filterModel=val;
    emit(StudentEnrollmentLoaded());
  }

  Future<bool> get(StudentEnrollmentFilterModel val)async{
    showLoadingDialog();
    emit(StudentEnrollmentLoading());
    var response=await _useCase.get(value: val);
    if(response.isLeft()){
      showMessage(response.asLeft());
      emit(StudentEnrollmentLoaded());
      closeLoadingDialog();
      return false;
    }else{
      var data=response.asRight();
      _dataList=data;
      emit(StudentEnrollmentLoaded());
      closeLoadingDialog();
      return true;
    }
  }



  Future<bool> update(StudentEnrollmentModel value)async{

    showLoadingDialog();
    emit(StudentEnrollmentLoading());
    var response=await _useCase.update(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft());
      emit(StudentEnrollmentLoaded());
      closeLoadingDialog();
      return false;
    }else{
      var data=response.asRight();
      int index= dataList.indexWhere((element) => element.id==value.id,);
      _dataList[index]=data;
      emit(StudentEnrollmentLoaded());
      closeLoadingDialog();
      return true;
    }
  }
  
}

import 'package:college_management/features/admin/exam_schedule/models/exam_schedule_widget_model.dart';
import 'package:college_management/features/admin/exam_schedule/models/exams_schedule_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/extensions/dart_extensions.dart';
import '../../../../../core/helper/show_message.dart';
import '../../../../../widgets/loader_dialog.dart';
import '../../domain/usecase/usecase.dart';
import '../../models/filter_exams_schedule_model.dart';
import 'state.dart';

class ExamScheduleCubit extends Cubit<ExamScheduleState> {
  final ExamScheduleUseCase _useCase;
  ExamScheduleCubit(this._useCase) : super(ExamScheduleInit());

  FilterExamsScheduleModel filterModel=FilterExamsScheduleModel();

  FilterExamsScheduleModel submittedData=FilterExamsScheduleModel();

  ExamScheduleResponseModel _dataList=ExamScheduleResponseModel(mappings: [], dates: []);
  ExamScheduleResponseModel get dataList=>_dataList;
  List<ExamScheduleWidgetModel> _examScheduleDataList=[];
  List<ExamScheduleWidgetModel> get examScheduleDataList =>_examScheduleDataList;



  void dataInit(){
    emit(ExamScheduleLoading());
    _examScheduleDataList=[];
     _dataList=ExamScheduleResponseModel(mappings: [], dates: []);
    filterModel=FilterExamsScheduleModel();
    
    submittedData=FilterExamsScheduleModel();
    emit(ExamScheduleLoaded());
  }


  void updateModel(ExamScheduleWidgetModel model){
    emit(ExamScheduleLoading());
   int index= _examScheduleDataList.indexWhere((element) => element.courseMappingId==model.courseMappingId,);
   _examScheduleDataList[index]=model;
   emit(ExamScheduleLoaded());
  }


  void getExamScheduleFilter(FilterExamsScheduleModel val){
    emit(ExamScheduleLoading());
    filterModel=val;
    emit(ExamScheduleLoaded());
  }

  void getSubmittedData(FilterExamsScheduleModel val){
    emit(ExamScheduleLoading());
    submittedData=val;
    emit(ExamScheduleLoaded());
  }




  Future<bool> get()async{
    showLoadingDialog();
    _examScheduleDataList=[];
    _dataList=ExamScheduleResponseModel(mappings: [], dates: []);
    emit(ExamScheduleLoading());
    var response=await _useCase.get(model: submittedData);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(ExamScheduleLoaded());
      closeLoadingDialog();
      return false;
    }else{
      var data=response.asRight();
      _dataList=data;
      _examScheduleDataList=dataList.mappings.map((mapping) {
        var list = dataList.dates.where(
              (e) => e.courseMappingId == mapping.courseMappingId,
        );
        ExamScheduleModel? data=ExamScheduleModel();
        if(list.isNotEmpty){
          data=list.first;
        }else{
          data=null;
        }

        return ExamScheduleWidgetModel(
          courseMappingId: mapping.courseMappingId,
          courseCode: mapping.courseCode,
          courseTitle: mapping.courseTitle,
          id: data?.id,
          examDate: data?.examDate,
          examTime: data?.examTime,
          examType: data?.examType,
        );
      }).toList();
      emit(ExamScheduleLoaded());
      closeLoadingDialog();
      return true;
    }
  }

  Future<bool> examScheduleUpdate()async{
    showLoadingDialog();
    emit(ExamScheduleLoading());
    Map<String,dynamic> model={
      "schedules":examScheduleDataList.map((e) => e.toMap(),).toList()
    };
    var response=await _useCase.examScheduleSave(model: model);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(ExamScheduleLoaded());
      closeLoadingDialog();
      return false;
    }else{
      var data=response.asRight();
      showMessage(data);
      emit(ExamScheduleLoaded());
      closeLoadingDialog();
      return true;
    }
  }



}

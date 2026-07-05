import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/constants/constant_data.dart';
import 'package:college_management/core/constants/media_query.dart';
import 'package:college_management/core/helper/app_date_picker.dart';
import 'package:college_management/core/helper/date_to_string_helper.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/core/helper/text_input_formator_helper.dart';
import 'package:college_management/features/admin/coordinator_management/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/coordinator_management/presentation/models/coordinator_register_model.dart';
import 'package:college_management/features/admin/course_catalog/presentation/widgets/catalog_depart_widget.dart';
import 'package:college_management/features/admin/departments/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/hod_assignment/models/hod_assign_model.dart';
import 'package:college_management/features/admin/hod_assignment/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/programs/models/program_model.dart';
import 'package:college_management/features/admin/programs/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/teacher_records/presentation/controller/cubit.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text_form.dart';

class CoordinatorRegisterDialog extends StatefulWidget {
  const CoordinatorRegisterDialog({super.key, this.coordinatorRegisterModel});
  final CoordinatorRegisterModel? coordinatorRegisterModel;
  @override
  State<CoordinatorRegisterDialog> createState() =>
      _CoordinatorRegisterDialogState();
}

class _CoordinatorRegisterDialogState extends State<CoordinatorRegisterDialog> {


  final _coordinatorCubit=DiContainer().sl<CoordinatorManagementCubit>();
  final _programCubit=DiContainer().sl<AdminProgramsCubit>();
  TextEditingController coordinatorName=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController cnic=TextEditingController();
  @override
  void initState() {
WidgetsBinding.instance.addPostFrameCallback((timeStamp)async {
if(widget.coordinatorRegisterModel!=null){
  coordinatorName.text=widget.coordinatorRegisterModel?.coordinatorName??"";
  email.text=widget.coordinatorRegisterModel?.email??"";
  phone.text=widget.coordinatorRegisterModel?.phone??"";
  cnic.text=widget.coordinatorRegisterModel?.cnic??"";
}
  _coordinatorCubit.getCoordinatorModel(widget.coordinatorRegisterModel?? CoordinatorRegisterModel());
 await _programCubit.getPrograms();
},);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder(
          bloc: _coordinatorCubit,
          builder: (context,statebkal) {
            var coordinatorModel=_coordinatorCubit.coordinatorRegisterModel;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,

              children: [
                /// 🔹 HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text:widget.coordinatorRegisterModel!=null? "Update Coordinator":"Register Coordinator",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close, color: AppColor.grey),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                CustomTextFormField(controller: coordinatorName, subTitle: "e.g. M Ali",title: "Name",isHintText: true,),

                SizedBox(height: 10),
                CustomTextFormField(controller: email, subTitle: "coordinator@gmail.com",title: "Email${widget.coordinatorRegisterModel!=null?" (read only)":""}",readOnly: widget.coordinatorRegisterModel!=null,isHintText: true,),

                SizedBox(height: 10),

                CustomTextFormField(controller: phone,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  subTitle: "03XXXX",title: "Name",isHintText: true,),
                SizedBox(height: 10),

                CustomTextFormField(controller: cnic,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CnicInputFormatter(),
                  ],
                  subTitle: "XXXXX-XXXXXXX-X",title: "CNIC",isHintText: true,),
                SizedBox(height: 10),
                BlocBuilder(
                    bloc: _programCubit,
                    builder: (context,statevhja) {
                      return _programCubit.activePrograms.isNotEmpty? CustomPopMenuButton(
                        menus: _programCubit.activePrograms.map((e) => "${e.name}, ${e.code}, ${e.degree}, ${e.section}, ${e.session}, ${e.department?.name??""}, ${e.affiliationName}",).toList(),
                        offset: Offset(0, 30),
                        onSelected: (p0) {
                          String programName=_programCubit.activePrograms.map((e) => "${e.name}, ${e.code}, ${e.degree}, ${e.section}, ${e.session}, ${e.department?.name??""}, ${e.affiliationName}",).toList()[p0];
                          ProgramModel model=_programCubit.activePrograms.where((e) =>programName== "${e.name}, ${e.code}, ${e.degree}, ${e.section}, ${e.session}, ${e.department?.name??""}, ${e.affiliationName}",).toList().first;
                          CoordinatorProgramModel coorProgram=CoordinatorProgramModel(id: model.id,name: model.name,degree: model.degree,session: model.session,section: model.section,code: model.code,department: CoordinatorDepartmentModel(id: model.department?.id??"",name: model.department?.name??"",code: model.department?.code??"",));
                          List<CoordinatorProgramModel> list=coordinatorModel.programs??[];
                          if(list.where((element) => element.id==coorProgram.id,).toList().isEmpty){
                            list.add(coorProgram);
                          }
                          _coordinatorCubit.getCoordinatorModel(coordinatorModel.copyWith(programs: list));
                        },
                        widget: DropDownFieldWidget(
                          text: "Select..",
                          maxLine: 1,
                          isFilled: false,
                          title: "Program",
                        ),
                      ):InkWell(
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap: () async {
                          await _programCubit.getPrograms();
                        },
                        child: DropDownFieldWidget(
                          text: "Select..",
                          maxLine: 1,
                          isFilled:  coordinatorModel.programs!=null? coordinatorModel.programs!.isNotEmpty:false,
                          title: "Program",
                        ),
                      );
                    }
                ),
                if(coordinatorModel.programs!=null && coordinatorModel.programs!.isNotEmpty)
                  ...[
                    SizedBox(height: 6,),
                    Wrap(
                      children: [
                        ...List.generate(coordinatorModel.programs!.length, (index) => CatalogDepartWidget(text: "${coordinatorModel.programs![index].name}, ${coordinatorModel.programs![index].code}, ${coordinatorModel.programs![index].degree}, ${coordinatorModel.programs![index].section}, ${coordinatorModel.programs![index].session}, ${coordinatorModel.programs![index].department?.name??""}", onTap: (){
                          var list=coordinatorModel.programs;
                          list!.removeWhere((element) => element.id==coordinatorModel.programs![index].id,);

                          _coordinatorCubit.getCoordinatorModel(coordinatorModel.copyWith(programs: list));

                        }),)
                      ],
                    )
                  ],

                SizedBox(height: 10),

                CustomPopMenuButton(
                  menus: ConstantData.coordinatorDesignation,
                  offset: Offset(0, 30),
                  onSelected: (p0) {
                    _coordinatorCubit.getCoordinatorModel(coordinatorModel.copyWith(designation: ConstantData.coordinatorDesignation[p0]));
                  },
                  widget: DropDownFieldWidget(
                    text:coordinatorModel.designation?? "Select..",
                    maxLine: 1,
                    isFilled: coordinatorModel.designation!=null,
                    title: "Designation",
                  ),
                ),

                SizedBox(height: 10),

                CustomPopMenuButton(
                  menus: ["Active","Inactive"],
                  offset: Offset(0, 30),
                  onSelected: (p0) {
                    _coordinatorCubit.getCoordinatorModel(coordinatorModel.copyWith(status: ["Active","Inactive"][p0]));
                  },
                  widget: DropDownFieldWidget(
                    text:coordinatorModel.status?? "Select..",
                    maxLine: 1,
                    isFilled:  coordinatorModel.status!=null,
                    title: "Status",
                  ),
                ),

                SizedBox(height: 25),

                /// 🔹 BUTTONS
                Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        text: "Discard",
                        bgColor: AppColor.white,
                        textColor: AppColor.red,
                        borderColor: AppColor.red,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CustomElevatedButton(
                        onPressed: () async {
                          if(
                          coordinatorName.text.isEmpty || phone.text.isEmpty || email.text.isEmpty|| cnic.text.isEmpty||
                              _coordinatorCubit.coordinatorRegisterModel.programs!.isEmpty || _coordinatorCubit.coordinatorRegisterModel.designation==null|| _coordinatorCubit.coordinatorRegisterModel.status==null){
                            showMessage("Please fill all fields",isError: true);
                            return;
                          }
                          var model=_coordinatorCubit.coordinatorRegisterModel;
                          model=model.copyWith(id: widget.coordinatorRegisterModel?.id,email: email.text,phone: phone.text,cnic: cnic.text,coordinatorName:coordinatorName.text,);
                          var response=
                          widget.coordinatorRegisterModel!=null?
                          await _coordinatorCubit.update(model):
                          await _coordinatorCubit.post(model);
                          if(response){
                            context.pop();
                            await _coordinatorCubit.get();
                          }
                        },
                        text:widget.coordinatorRegisterModel!=null? "Update":"Save",
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
      ),
    );
  }
}

import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/constants/media_query.dart';
import 'package:college_management/core/enums/status_enum.dart';
import 'package:college_management/core/helper/session_input_formatter_helper.dart';
import 'package:college_management/core/helper/share_pref/auth_sharepref_helper.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/programs/models/program_model.dart';
import 'package:college_management/features/admin/programs/models/program_request_model.dart';
import 'package:college_management/features/admin/programs/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/university_profile/models/affiliation_model.dart';
import 'package:college_management/features/admin/university_profile/presentation/controller/cubit.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text_form.dart';
import '../../../../../widgets/custom_top_bar.dart';
import '../../../departments/presentation/controller/cubit.dart';

class CreateProgramScreen extends StatefulWidget {
   CreateProgramScreen({super.key,this.programModel});
ProgramModel? programModel;
  @override
  State<CreateProgramScreen> createState() => _CreateProgramScreenState();
}

class _CreateProgramScreenState extends State<CreateProgramScreen> {
  final _departmentCubit = DiContainer().sl<AdminDepartmentCubit>();
  final _programCubit = DiContainer().sl<AdminProgramsCubit>();
  final _universityProfileCubit = DiContainer().sl<UniversityProfileCubit>();

  /// 🔹 Controllers
  final titleController = TextEditingController();
  final codeController = TextEditingController();
  final levelController = TextEditingController();
  final sectionController = TextEditingController();
  final sessionController = TextEditingController();

  final midsController = TextEditingController();
  final sessionalController = TextEditingController();
  final finalController = TextEditingController();
  final theoryPassController = TextEditingController();

  final practicalMarksController = TextEditingController();
  final practicalPassController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if(widget.programModel!=null){
        titleController.text=widget.programModel?.name??"";
        codeController.text=widget.programModel?.code??"";
        levelController.text=widget.programModel?.degree??"";
        sectionController.text=widget.programModel?.section??"";
        sessionController.text=widget.programModel?.session??"";
        midsController.text=widget.programModel?.mids.toString()??"";
        sessionalController.text=widget.programModel?.sessional.toString()??"";
        finalController.text=widget.programModel?.finalMarks.toString()??"";
        theoryPassController.text=widget.programModel?.theoryPassPercentage.toString()??"";
        practicalMarksController.text=widget.programModel?.practicalMax.toString()??"";
        practicalPassController.text=widget.programModel?.practicalPassPercentage.toString()??"";
        _programCubit.getDepartment(department: widget.programModel!.department, affiliation: AffiliationModel(id: widget.programModel?.affiliationId??"",name: widget.programModel?.affiliationName??""), status:widget.programModel!.status);
      }else{
        _programCubit.getDepartment(department: null, affiliation: null, status: null);
        midsController.text="30";
        sessionalController.text="10";
        finalController.text="60";
        theoryPassController.text="40";
        practicalMarksController.text="50";
        practicalPassController.text="40";

      }
      await _departmentCubit.getDepartments();
    },);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgPrimary,
      body: BlocBuilder(
        bloc: _programCubit,
        builder: (context, statesbjle) {
          return Column(
            children: [
              CustomTopBar(text:widget.programModel!=null? "Update Program":"Create New Program"),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenPaddingHori,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 10),

                      CustomTextFormField(
                        controller: titleController,
                        subTitle: "Full Title",
                      ),
                      SizedBox(height: 15),

                      /// 🔹 TITLE + CODE
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              controller: levelController,
                              subTitle: "Level / Degree",
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: CustomTextFormField(
                              controller: codeController,
                              subTitle: "Program Code",
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 15),

                      /// 🔹 LEVEL + AFFILIATION
                      Row(
                        children: [
                          BlocBuilder(
                            bloc: _departmentCubit,
                            builder: (context, staesk) {
                              return Expanded(
                                child: _departmentCubit.activeDepartmentList.isEmpty
                                    ? InkWell(
                                        onTap: () async {
                                          await _departmentCubit
                                              .getDepartments();
                                        },
                                        child: DropDownFieldWidget(
                                          text:
                                              _programCubit
                                                      .selectedDepartment ==
                                                  null
                                              ? "Select Dept"
                                              : _programCubit
                                                    .selectedDepartment?.name??"",
                                          isFilled:
                                              _programCubit
                                                  .selectedDepartment !=
                                              null,
                                        ),
                                      )
                                    : CustomPopMenuButton(
                                        onSelected: (p0) {
                                          _programCubit.getDepartment(
                                            department: _departmentCubit
                                                .activeDepartmentList
                                                .toList()[p0],
                                            affiliation: _programCubit
                                                .selectedAffiliation,
                                            status: _programCubit.statusEnum,
                                          );
                                        },
                                        menus: _departmentCubit.activeDepartmentList
                                            .map((e) => "${e.name} (${e.code})")
                                            .toList(),
                                        widget: DropDownFieldWidget(
                                          text:
                                              _programCubit
                                                      .selectedDepartment ==
                                                  null
                                              ? "Select Dept"
                                              : _programCubit
                                                    .selectedDepartment?.name??"",
                                          isFilled:
                                              _programCubit
                                                  .selectedDepartment !=
                                              null,
                                        ),
                                      ),
                              );
                            },
                          ),
                          SizedBox(width: 10),

                          BlocBuilder(
                            bloc: _universityProfileCubit,
                            builder: (context, statebsknl) {
                              return Expanded(
                                child:
                                    _universityProfileCubit.universityModel ==
                                            null ||
                                        _universityProfileCubit
                                            .activeAffiliationList
                                            .isEmpty
                                    ? InkWell(
                                        onTap: () async {
                                          await _universityProfileCubit
                                              .getUniversitySetup();
                                        },
                                        child: DropDownFieldWidget(
                                          text:
                                              _programCubit
                                                      .selectedAffiliation ==
                                                  null
                                              ? "Select Affiliation"
                                              : _programCubit
                                                    .selectedAffiliation?.name??"",
                                          isFilled:
                                              _programCubit
                                                  .selectedAffiliation !=
                                              null,
                                        ),
                                      )
                                    : CustomPopMenuButton(
                                        onSelected: (p0) {

                                          var model=_universityProfileCubit
                                              .activeAffiliationList
                                              .toList()[p0];
                                          midsController.text="${model.theory?.mids??""}";
                                          sessionalController.text="${model.theory?.sessional??""}";
                                          finalController.text="${model.theory?.finalMarks??""}";
                                          theoryPassController.text="${model.theory?.passPercentage??""}";
                                          practicalMarksController.text="${model.practical?.maxMarks??""}";
                                          practicalPassController.text="${model.practical?.passPercentage??""}";


                                          _programCubit.getDepartment(
                                            department: _programCubit
                                                .selectedDepartment,
                                            affiliation: model,
                                            status: _programCubit.statusEnum,
                                          );
                                          // affiliation=_departmentCubit.activeDepartmentList.map((e) => e.name,).toList()[p0];
                                        },
                                        menus: _universityProfileCubit
                                            .activeAffiliationList
                                            .map((e) => e.name)
                                            .toList(),
                                        widget: DropDownFieldWidget(
                                          text:
                                              _programCubit
                                                      .selectedAffiliation ==
                                                  null
                                              ? "Select Affiliation"
                                              : _programCubit
                                                    .selectedAffiliation?.name??"",
                                          isFilled:
                                              _programCubit
                                                  .selectedAffiliation !=
                                              null,
                                        ),
                                      ),
                              );
                            },
                          ),
                        ],
                      ),

                      SizedBox(height: 15),

                      /// 🔹 DEPARTMENT + SECTION
                      CustomTextFormField(
                        controller: sessionController,
                        subTitle: "Session (2021-2025)",
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          SessionInputFormatterHelper(),
                        ],
                      ),
                      SizedBox(height: 15),

                      /// 🔹 SESSION + STATUS
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              controller: sectionController,
                              subTitle: "Section",
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: CustomPopMenuButton(
                              onSelected: (p0) {
                                _programCubit.getDepartment(
                                  department: _programCubit.selectedDepartment,
                                  affiliation:
                                      _programCubit.selectedAffiliation,
                                  status: ["Active", "Inactive"][p0] == "Active"
                                      ? StatusEnum.Active
                                      : StatusEnum.Inactive,
                                );
                              },
                              menus: ["Active", "Inactive"],
                              widget: DropDownFieldWidget(
                                text: _programCubit.statusEnum == null
                                    ? "Select Status"
                                    : _programCubit.statusEnum?.name ?? "",
                                isFilled: _programCubit.statusEnum != null,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 15),

                      /// 🔥 GRADING FRAMEWORK
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: AppColor.white,
                              height: 1,
                            ),
                          ),
                          SizedBox(width: 5),
                          AppText(
                            text: "Grading Framework",
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: AppColor.white,
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: AppColor.white,
                              height: 1,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 5),
                      AppText(
                        text: "Theory",
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: AppColor.white.withOpacity(.8),
                      ),
                      SizedBox(height: 10),

                      /// 🔹 THEORY ROW 1
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: midsController,

                              subTitle: "Mids",
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: CustomTextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: sessionalController,
                              subTitle: "Sessional",
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 15),

                      /// 🔹 THEORY ROW 2
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: finalController,
                              subTitle: "Final",
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: CustomTextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: theoryPassController,
                              subTitle: "Theory Pass %",
                            ),
                          ),
                        ],
                      ),


                      SizedBox(height: 10),

                      /// 🔹 PRACTICAL
                      AppText(
                        text: "Practical",
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: AppColor.white.withOpacity(.8),
                      ),

                      SizedBox(height: 10),

                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: practicalMarksController,
                              subTitle: "Max Marks",
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: CustomTextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: practicalPassController,
                              subTitle: "Pass %",
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 25),

                      /// 🔹 BUTTON
                      Center(
                        child: CustomElevatedButton(
                          width: mdWidth(context) * .6,
                          onPressed: () async {
                            if (titleController.text.isEmpty ||
                                levelController.text.isEmpty ||
                                codeController.text.isEmpty ||
                                _programCubit.selectedAffiliation == null ||
                                _programCubit.selectedDepartment == null ||
                                _programCubit.statusEnum == null ||
                                sessionController.text.isEmpty ||
                                sectionController.text.isEmpty ||
                                midsController.text.isEmpty ||
                                sessionalController.text.isEmpty ||
                                finalController.text.isEmpty ||
                                theoryPassController.text.isEmpty ||
                                practicalMarksController.text.isEmpty ||
                                practicalPassController.text.isEmpty) {
                              showMessage("Please fill all fields",isError: true);
                              return;
                            }
                            int midN=int.parse(midsController.text);
                            int sessionalN=int.parse(sessionalController.text);
                            int finalN=int.parse(finalController.text);
                            int totalTheor=midN+sessionalN+finalN;

                            ProgramRequestModel
                            programRequestModel = ProgramRequestModel(
                              name: titleController.text,
                              code: codeController.text,
                              degree: levelController.text,
                              session: sessionController.text,
                              section: sectionController.text,
                              department: _programCubit.selectedDepartment!,
                              mids: int.parse(midsController.text),
                              sessional: int.parse(sessionalController.text),
                              finalMarks: int.parse(finalController.text),
                              affiliation:
                                  _programCubit.selectedAffiliation!,
                              practicalMax: int.parse(
                                practicalMarksController.text,
                              ),
                              practicalPassPercentage: int.parse(
                                practicalPassController.text,
                              ),
                              theoryPassPercentage: int.parse(
                                theoryPassController.text,
                              ),
                              totalTheory: totalTheor,
                              status:
                                  _programCubit.statusEnum?.name ?? "InActive",
                              id: widget.programModel==null?null:widget.programModel!.id,
                            );

                         bool response=
                         widget.programModel==null?
                         await _programCubit.addPrograms(programRequestModel):
                         await _programCubit.updateProgram(programRequestModel);
                         if(response){
                           context.pop();
                           await _programCubit.getPrograms();
                         }
                          },
                          text:widget.programModel==null? "Create Program":"Update Program",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

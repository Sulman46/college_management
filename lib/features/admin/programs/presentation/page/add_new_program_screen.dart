import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/constants/media_query.dart';
import 'package:college_management/core/enums/status_enum.dart';
import 'package:college_management/core/helper/session_input_formatter_helper.dart';
import 'package:college_management/core/helper/share_pref/auth_sharepref_helper.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/programs/models/program_model.dart';
import 'package:college_management/features/admin/programs/models/program_request_model.dart';
import 'package:college_management/features/admin/programs/presentation/controller/cubit.dart';
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
  var _departmentCubit = DiContainer().sl<AdminDepartmentCubit>();
  var _programCubit = DiContainer().sl<AdminProgramsCubit>();
  var _universityProfileCubit = DiContainer().sl<UniversityProfileCubit>();

  /// 🔹 Controllers
  final titleController = TextEditingController();
  final codeController = TextEditingController();
  final levelController = TextEditingController();
  final sectionController = TextEditingController();
  final sessionController = TextEditingController();

  final midsController = TextEditingController();
  final sessionalController = TextEditingController();
  final finalController = TextEditingController();
  final totalTheoryController = TextEditingController();
  final theoryPassController = TextEditingController();

  final practicalMarksController = TextEditingController();
  final practicalPassController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if(widget.programModel!=null){
        titleController.text=widget.programModel?.name??"";
        codeController.text=widget.programModel?.code??"";
        levelController.text=widget.programModel?.department??"";
        sectionController.text=widget.programModel?.section??"";
        sessionController.text=widget.programModel?.session??"";
        midsController.text=widget.programModel?.mids.toString()??"";
        sessionalController.text=widget.programModel?.sessional.toString()??"";
        finalController.text=widget.programModel?.finalMarks.toString()??"";
        totalTheoryController.text=widget.programModel?.totalTheory.toString()??"";
        theoryPassController.text=widget.programModel?.theoryPassPercentage.toString()??"";
        practicalMarksController.text=widget.programModel?.practicalMax.toString()??"";
        practicalPassController.text=widget.programModel?.practicalPassPercentage.toString()??"";
        _programCubit.getDepartment(department: widget.programModel?.department??"", affiliation: widget.programModel?.affiliationName??"", status:widget.programModel!.department=="Active"? StatusEnum.Active:StatusEnum.Inactive);
      }else{
        _programCubit.getDepartment(department: "", affiliation: "", status: null);

      }
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
                      Center(
                        child: AppText(
                          text:widget.programModel!=null? "Fill in the details to update program.":"Fill in the details to create a new program.",
                          fontSize: 12,
                          color: AppColor.primary,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.center,
                        ),
                      ),
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
                                child: _departmentCubit.departmentList.isEmpty
                                    ? InkWell(
                                        onTap: () async {
                                          await _departmentCubit
                                              .getDepartments();
                                        },
                                        child: DropDownFieldWidget(
                                          text:
                                              _programCubit
                                                      .selectedDepartment ==
                                                  ""
                                              ? "Select Dept"
                                              : _programCubit
                                                    .selectedDepartment,
                                          isFilled:
                                              _programCubit
                                                  .selectedDepartment !=
                                              "",
                                        ),
                                      )
                                    : CustomPopMenuButton(
                                        onSelected: (p0) {
                                          _programCubit.getDepartment(
                                            department: _departmentCubit
                                                .departmentList
                                                .map((e) => e.name)
                                                .toList()[p0],
                                            affiliation: _programCubit
                                                .selectedAffiliation,
                                            status: _programCubit.statusEnum,
                                          );
                                        },
                                        menus: _departmentCubit.departmentList
                                            .map((e) => e.name)
                                            .toList(),
                                        widget: DropDownFieldWidget(
                                          text:
                                              _programCubit
                                                      .selectedDepartment ==
                                                  ""
                                              ? "Select Dept"
                                              : _programCubit
                                                    .selectedDepartment,
                                          isFilled:
                                              _programCubit
                                                  .selectedDepartment !=
                                              "",
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
                                            .universityModel!
                                            .affiliationModel!
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
                                                  ""
                                              ? "Select Affiliation"
                                              : _programCubit
                                                    .selectedAffiliation,
                                          isFilled:
                                              _programCubit
                                                  .selectedAffiliation !=
                                              "",
                                        ),
                                      )
                                    : CustomPopMenuButton(
                                        onSelected: (p0) {
                                          _programCubit.getDepartment(
                                            department: _programCubit
                                                .selectedDepartment,
                                            affiliation: _universityProfileCubit
                                                .universityModel!
                                                .affiliationModel!
                                                .map((e) => e.name)
                                                .toList()[p0],
                                            status: _programCubit.statusEnum,
                                          );
                                          // affiliation=_departmentCubit.departmentList.map((e) => e.name,).toList()[p0];
                                        },
                                        menus: _universityProfileCubit
                                            .universityModel!
                                            .affiliationModel!
                                            .map((e) => e.name)
                                            .toList(),
                                        widget: DropDownFieldWidget(
                                          text:
                                              _programCubit
                                                      .selectedAffiliation ==
                                                  ""
                                              ? "Select Affiliation"
                                              : _programCubit
                                                    .selectedAffiliation,
                                          isFilled:
                                              _programCubit
                                                  .selectedAffiliation !=
                                              "",
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
                          AppText(
                            text: "Grading Framework",
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppColor.primary.withOpacity(.8),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: AppColor.primary.withOpacity(.8),
                              height: 1,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 5),
                      AppText(
                        text: "Theory",
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColor.grey.withOpacity(.8),
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
                              controller: totalTheoryController,
                              subTitle: "Total Theory",
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10),
                      CustomTextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: theoryPassController,
                        subTitle: "Theory Pass %",
                      ),
                      SizedBox(height: 10),

                      /// 🔹 PRACTICAL
                      AppText(
                        text: "Practical",
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColor.grey.withOpacity(.8),
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
                                _programCubit.selectedAffiliation == "" ||
                                _programCubit.selectedDepartment == "" ||
                                _programCubit.statusEnum == null ||
                                sessionController.text.isEmpty ||
                                sectionController.text.isEmpty ||
                                midsController.text.isEmpty ||
                                sessionalController.text.isEmpty ||
                                finalController.text.isEmpty ||
                                theoryPassController.text.isEmpty ||
                                practicalMarksController.text.isEmpty ||
                                practicalPassController.text.isEmpty) {
                              showMessage("Please fill all fields");
                              return;
                            }

                            ProgramRequestModel
                            programRequestModel = ProgramRequestModel(
                              name: titleController.text,
                              code: codeController.text,
                              degree: levelController.text,
                              session: sessionController.text,
                              section: sectionController.text,
                              department: _programCubit.selectedDepartment,
                              mids: int.parse(midsController.text),
                              sessional: int.parse(sessionalController.text),
                              finalMarks: int.parse(finalController.text),
                              affiliationName:
                                  _programCubit.selectedAffiliation,
                              practicalMax: int.parse(
                                practicalMarksController.text,
                              ),
                              practicalPassPercentage: int.parse(
                                practicalPassController.text,
                              ),
                              theoryPassPercentage: int.parse(
                                theoryPassController.text,
                              ),
                              totalTheory: int.parse(totalTheoryController.text),
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

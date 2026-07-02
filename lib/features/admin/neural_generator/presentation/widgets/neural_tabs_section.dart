import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/enums/user_enums.dart';
import 'package:college_management/features/admin/departments/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/neural_generator/presentation/controller/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/custom_text_form.dart';
import '../../../../../widgets/drop_down_field_widget.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';
import 'neural_tabs_widget.dart';

class NeuralTabsSection extends StatefulWidget {
  const NeuralTabsSection({super.key});

  @override
  State<NeuralTabsSection> createState() => _NeuralTabsSectionState();
}

class _NeuralTabsSectionState extends State<NeuralTabsSection> {
  TextEditingController searchController=TextEditingController();

  final _neuralCubit=DiContainer().sl<NeuralGeneratorCubit>();
  final _departmentCubit=DiContainer().sl<AdminDepartmentCubit>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7,vertical: 7),
      // decoration: AppColor.containerNeon,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2,vertical: 2),
            decoration: BoxDecoration(
              color: AppColor.bgPrimary.withOpacity(.5), // glass tint
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColor.primary.withOpacity(.5),
                width: .5,
              ),
              // boxShadow: AppColor.shadowBlack,
            ),
            child: Row(
              children: [
                Expanded(child: NeuralTabsWidget(text: "Teacher", onTap: () async {
                  _neuralCubit.getUserRole(UserRole.teacher);
                 await _neuralCubit.getTeachers();
                }, isSelected: _neuralCubit.userRole==UserRole.teacher)),
                Expanded(child: NeuralTabsWidget(text: "HOD", onTap: () async {
                  _neuralCubit.getUserRole(UserRole.hod);
                  await _neuralCubit.getHod();
                }, isSelected: _neuralCubit.userRole==UserRole.hod)),
                Expanded(child: NeuralTabsWidget(text: "Coordinator", onTap: () async {
                  _neuralCubit.getUserRole(UserRole.coordinator);
                  await _neuralCubit.getCoordinator();
                }, isSelected: _neuralCubit.userRole==UserRole.coordinator)),
              ],
            ),
          ),
          SizedBox(height: 8,),
          Row(
            children: [
              Expanded(child: CustomTextFormField(controller: _neuralCubit.searchController,onChanged: (p0) {
                _neuralCubit.getName(p0.toLowerCase());
              }, subTitle: "Name")),
              SizedBox(width: 8,),
              BlocBuilder(
                bloc: _departmentCubit,
                builder: (context,statgebk) {
                  return Expanded(child:
                      _departmentCubit.departmentList.isNotEmpty?
                  CustomPopMenuButton(menus: ["All Dept",..._departmentCubit.departmentList.map((e) => e.name,)],
                    onSelected: (p0) {
                      _neuralCubit.getDepartmentName(["All Dept",..._departmentCubit.departmentList.map((e) => e.name,)][p0]);
                    },
                    widget: DropDownFieldWidget(text:_neuralCubit.selectedDepartment==""? "All Dept":_neuralCubit.selectedDepartment, isFilled: true),):InkWell(
                          onTap: () async{
                           await _departmentCubit.getDepartments();
                          },
                          child: DropDownFieldWidget(text: "All Dept", isFilled: true)));
                }
              ),
            ],
          )
        ],
      ),
    );
  }
}

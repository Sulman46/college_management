import 'package:college_management/widgets/custom_text_form.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../core/constants/app_widgets_size.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../controller/cubit.dart';

class FacultyHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 50;

  @override
  double get maxExtent => 60;
  final _facultyWorkload = DiContainer().sl<FacultyWorkLoadCubit>();

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: AppColor.bgPrimary,
      padding: EdgeInsets.symmetric(horizontal: screenPaddingHori),
      alignment: Alignment.centerLeft,
      child: BlocBuilder(
        bloc: _facultyWorkload,
        builder: (context, statevja) {
          return Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: _facultyWorkload.searchController,
                  subTitle: "Search",
                  onChanged: (p0) {
                    _facultyWorkload.getSelectedName(p0.toLowerCase());
                  },
                  isHintText: true,
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: CustomPopMenuButton(
                  menus: [
                    "All Dept",
                    ...(_facultyWorkload.workloadResponseModel != null
                        ? _facultyWorkload
                        .workloadResponseModel!
                        .teacherWorkloadModel
                        .expand((teacher) => teacher.departments)
                        .map((dept) => dept.name ?? "")
                        .where((name) => name.isNotEmpty)
                        .toSet()
                        .toList()
                        : <String>[]),
                  ],
                  onSelected: (p0) {
                    _facultyWorkload.getSelectedDpt([
                      "All Dept",
                      ...(_facultyWorkload.workloadResponseModel != null
                          ? _facultyWorkload
                          .workloadResponseModel!
                          .teacherWorkloadModel
                          .expand((teacher) => teacher.departments)
                          .map((dept) => dept.name ?? "")
                          .where((name) => name.isNotEmpty)
                          .toSet()
                          .toList()
                          : <String>[]),
                    ][p0]);
                  },
                  widget: DropDownFieldWidget(
                    text:_facultyWorkload.selectedDpt,
                    isFilled: false,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

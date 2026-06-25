import 'package:college_management/features/admin/timetable_manager/models/table_filter_model.dart';
import 'package:college_management/features/admin/timetable_manager/presentation/controller/cubit.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_widgets_size.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';

class SliverHeaderFilterButtons extends SliverPersistentHeaderDelegate {
  SliverHeaderFilterButtons({required this.timetableManagerCubit});
  TimetableManagerCubit timetableManagerCubit;
  @override
  double get minExtent => 49;

  @override
  double get maxExtent => 49;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: AppColor.bgPrimary
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: AppColor.containerNeon,
            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
            margin: EdgeInsets.symmetric(horizontal: screenPaddingHori-5),
            alignment: Alignment.centerLeft,
            child: BlocBuilder(
             bloc: timetableManagerCubit ,
              builder: (context,statesnjl) {
                return Row(
                  children: [
                    Expanded(child: InkWell(
                        onTap: () {
                          timetableManagerCubit.getFilterModel(model: TableFilterModel());
                        },
                        child: DropDownFieldWidget(text:"All", isFilled:timetableManagerCubit.filterModel.allEmpty))),
                    SizedBox(width: 10,),
                    Expanded(child: CustomPopMenuButton(
                      onSelected: (p0) {
                        timetableManagerCubit.getFilterModel(model: timetableManagerCubit.filterModel.copyWith(department: timetableManagerCubit.dataList.map((e) => e.programModel?.department?.name??"",).toSet().toList()[p0]));
                      },
                      menus: timetableManagerCubit.dataList.map((e) => e.programModel?.department?.name??"",).toSet().toList(),
                      widget: DropDownFieldWidget(
                          text:timetableManagerCubit.filterModel.department?? "Dept..",
                          isFilled: timetableManagerCubit.filterModel.department!=null),)),
                    SizedBox(width: 10,),
                    Expanded(child: CustomPopMenuButton(
                      onSelected: (p0) {
                        timetableManagerCubit.getFilterModel(model: timetableManagerCubit.filterModel.copyWith(program: timetableManagerCubit.dataList.map((e) => e.programModel?.name??"",).toSet().toList()[p0]));

                      },
                      menus: timetableManagerCubit.dataList.map((e) => e.programModel?.name??"",).toSet().toList(),widget: DropDownFieldWidget(text:timetableManagerCubit.filterModel.program??"Program..", isFilled: timetableManagerCubit.filterModel.program!=null),)),
                    SizedBox(width: 10,),
                    Expanded(child: CustomPopMenuButton(menus: timetableManagerCubit.dataList.map((e) => e.programModel?.session??"",).toSet().toList(),
                      onSelected: (p0) {
                        timetableManagerCubit.getFilterModel(model: timetableManagerCubit.filterModel.copyWith(session: timetableManagerCubit.dataList.map((e) => e.programModel?.session??"",).toSet().toList()[p0]));

                      },widget: DropDownFieldWidget(text:timetableManagerCubit.filterModel.session??"Session..", isFilled: timetableManagerCubit.filterModel.session !=null),)),
                  ],
                );
              }
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
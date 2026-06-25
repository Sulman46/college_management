import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/timetable_manager/models/table_filter_model.dart';
import 'package:college_management/features/admin/timetable_manager/presentation/widgets/add_sheet.dart';
import 'package:college_management/features/admin/timetable_manager/presentation/widgets/sliver_header_filter_buttons.dart';
import 'package:college_management/features/admin/timetable_manager/presentation/widgets/time_table_sheet_widget.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/custom_animated_dialog.dart';
import 'package:college_management/widgets/data_not_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/cubit.dart';


class TimetableManagerScreen extends StatefulWidget {
  const TimetableManagerScreen({super.key});

  @override
  State<TimetableManagerScreen> createState() => _TimetableManagerScreenState();
}

class _TimetableManagerScreenState extends State<TimetableManagerScreen> {
  final _timeTableCubit = DiContainer().sl<TimetableManagerCubit>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
       _timeTableCubit.getFilterModel(model: TableFilterModel());
      await _timeTableCubit.get();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        bloc: _timeTableCubit,
        builder: (context, statebskj) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                elevation: 0,

                pinned: true,
                backgroundColor: AppColor.primary,
                leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_outlined,
                    size: 25,
                    color: AppColor.white,
                  ),
                ),
                // title:,
                centerTitle: true,
                title: AppText(
                  text: "Timetable Dashboard",
                  fontSize: 13,
                  color: AppColor.white,
                ),
                actionsPadding: EdgeInsets.only(right: screenPaddingHori),
                actions: [
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            CustomAnimatedDialog(child: AddSheet()),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 1, color: AppColor.white),
                      ),
                      child: Icon(Icons.add, size: 20, color: AppColor.white),
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverPersistentHeader(
                delegate: SliverHeaderFilterButtons(
                  timetableManagerCubit: _timeTableCubit,
                ),
                pinned: true,
              ),

              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    if ( _timeTableCubit.filterList.where(
                            (element) =>
                        (_timeTableCubit.filterModel.department!=null? element.programModel!.department!.name ==
                            _timeTableCubit.filterModel.department:true) &&
                            (_timeTableCubit.filterModel.program!=null? element.programModel!.name ==
                                _timeTableCubit.filterModel.program:true) &&
                            (_timeTableCubit.filterModel.session!=null? element.programModel!.session ==
                                _timeTableCubit.filterModel.session:true)
                    ).toList().isNotEmpty)
                      ...List.generate(
                        _timeTableCubit.filterList
                            .where(
                              (element) =>
                              (_timeTableCubit.filterModel.department!=null? element.programModel!.department!.name ==
                                  _timeTableCubit.filterModel.department:true) &&
                              (_timeTableCubit.filterModel.program!=null? element.programModel!.name ==
                                  _timeTableCubit.filterModel.program:true) &&
                              (_timeTableCubit.filterModel.session!=null? element.programModel!.session ==
                                  _timeTableCubit.filterModel.session:true)
                            ).toList()
                            .length,
                        (index) => TimeTableSheetWidget(
                          model: _timeTableCubit.filterList.where(
                                  (element) =>
                              (_timeTableCubit.filterModel.department!=null? element.programModel!.department!.name ==
                                  _timeTableCubit.filterModel.department:true) &&
                                  (_timeTableCubit.filterModel.program!=null? element.programModel!.name ==
                                      _timeTableCubit.filterModel.program:true) &&
                                  (_timeTableCubit.filterModel.session!=null? element.programModel!.session ==
                                      _timeTableCubit.filterModel.session:true)
                          ).toList()[index],
                        ),
                      )
                    else
                      DataNotFoundWidget(
                        onTap: () async {
                          await _timeTableCubit.get();
                        },
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

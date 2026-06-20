import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/constants/constant_data.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/announcements/presentation/widgets/announcement_widget.dart';
import 'package:college_management/features/admin/announcements/presentation/widgets/filter_button_widget.dart';
import 'package:college_management/widgets/data_not_found_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text_form.dart';
import '../controller/cubit.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  TextEditingController searchController = TextEditingController();

  var _announcementCubit = DiContainer().sl<AnnouncementsCubit>();

  double top = mdHeight(navigatorKey.currentContext!) * .9;
  double left = mdWidth(navigatorKey.currentContext!) * .65;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _announcementCubit.initFilter();
      await _announcementCubit.get();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder(
        bloc: _announcementCubit,
        builder: (context, statesnln) {
          return Stack(
            children: [
              Column(
                children: [
                  /// 🔹 TOP BAR
                  CustomTopBar(text: "Announcements"),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenPaddingHori,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 10),

                            /// 🔹 SEARCH
                            CustomTextFormField(
                              controller: _announcementCubit.searchController,
                              subTitle: "Search...",
                              isHintText: true,
                              onChanged: (p0) {
                                _announcementCubit.filterData(p0.toLowerCase());
                              },
                              borderSize: 1,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 10,
                              ),
                            ),

                            SizedBox(height: 15),

                            Row(
                              children: [
                                CustomPopMenuButton(
                                  selectedIndex: _announcementCubit.isArchive,
                                  menus: [
                                    'Live Feed (${_announcementCubit.dataList.where((e) => e.isArchived != true).toList().length})',
                                    'Archives (${_announcementCubit.dataList.where((e) => e.isArchived == true).toList().length})',
                                  ],
                                  onSelected: (p0) {
                                    _announcementCubit.filterArchive(p0);
                                  },
                                  offset: Offset(0, 25),
                                  widget: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 9,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: .5,
                                        color: AppColor.primary,
                                      ),
                                      color: AppColor.primary.withOpacity(.2),
                                    ),
                                    child: Icon(
                                      Icons.filter_list,
                                      size: 16,
                                      color: AppColor.primary,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Container(
                                  height: 23,
                                  width: 2,
                                  color: AppColor.primary,
                                ),
                                SizedBox(width: 5),
                                FilterButtonWidget(
                                  onTap: () {
                                    _announcementCubit.filterCategory("");
                                  },
                                  text: "All",
                                  isSelected: _announcementCubit.selectedCategory=="",
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: List.generate(
                                        ConstantData
                                            .announcementCategoryList
                                            .length,
                                        (index) => Container(
                                          margin: EdgeInsets.only(right: 5),
                                          child: FilterButtonWidget(
                                            onTap: () {
                                              _announcementCubit.filterCategory( ConstantData
                                                  .announcementCategoryList[index]);
                                            },
                                            text: ConstantData
                                                .announcementCategoryList[index],
                                            isSelected: _announcementCubit.selectedCategory==ConstantData
                                                .announcementCategoryList[index],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            if (_announcementCubit.filterList
                                .where(
                                  (element) => element.category!.contains(
                                _announcementCubit.selectedCategory,
                              ) && (_announcementCubit.isArchive==0?element.isArchived==false:element.isArchived==true),
                            ).isNotEmpty)
                              ...List.generate(
                                _announcementCubit.filterList
                                    .where(
                                      (element) => element.category!.contains(
                                        _announcementCubit.selectedCategory,
                                      ) && (_announcementCubit.isArchive==0?element.isArchived==false:element.isArchived==true),
                                    )
                                    .length,
                                (index) => AnnouncementWidget(
                                  model: _announcementCubit.filterList.where(
                                    (element) => element.category!.contains(
                                      _announcementCubit.selectedCategory,
                                    )&& (_announcementCubit.isArchive==0?element.isArchived==false:element.isArchived==true),
                                  ).toList()[index],
                                ),
                              )
                            else
                              DataNotFoundWidget(
                                onTap: () async {
                                  await _announcementCubit.get();
                                },
                              ),
                            SafeArea(top: false, child: SizedBox(height: 30)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 100),
                top: _announcementCubit.top,
                right: _announcementCubit.right,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    _announcementCubit.getButtonPosition(topVal: details.delta.dy, rightVal: details.delta.dx);

                  },
                  child: CustomElevatedButton(
                    onPressed: () {
                      context.push("/Admin-add-announcement");
                    },
                    text: "Add New",
                    fontSize: 15,
                    width: 110,
                    height: 50,
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

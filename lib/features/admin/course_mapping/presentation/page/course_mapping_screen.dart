import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:flutter/material.dart';
import 'package:college_management/widgets/custom_text_form.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../core/enums/user_enums.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/data_not_found_widget.dart';
import '../../../../Authentication/presentation/controller/cubit.dart';
import '../controller/cubit.dart';
import '../widgets/course_mapping_widget.dart';
import 'add_new_course_mapping_screen.dart';

class CourseMappingScreen extends StatefulWidget {
  const CourseMappingScreen({super.key});

  @override
  State<CourseMappingScreen> createState() => _CourseMappingScreenState();
}

class _CourseMappingScreenState extends State<CourseMappingScreen> {
  final _courseMappingCubit = DiContainer().sl<CourseMappingCubit>();
  final _authCubit = DiContainer().sl<AuthenticationCubit>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _courseMappingCubit.getMappingData();
    });
  }

  double top = mdHeight(navigatorKey.currentContext!) * .9;
  double left = mdWidth(navigatorKey.currentContext!) * .65;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder(
        bloc: _courseMappingCubit,
        builder: (context, staesbk) {
          return Stack(
            children: [
              Column(
                children: [
                  /// 🔹 TOP BAR
                  CustomTopBar(text: "Course Mapping"),

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
                              controller: _courseMappingCubit.searchController,
                              subTitle: "Search...",
                              isHintText: true,
                              onChanged: (p0) {
                                _courseMappingCubit.filterData(
                                  p0.toLowerCase(),
                                );
                              },
                              borderSize: 1,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 10,
                              ),
                            ),

                            SizedBox(height: 15),

                            /// 🔹 LIST
                            if (_courseMappingCubit.filterMapping.isNotEmpty)
                              ...List.generate(
                                _courseMappingCubit.filterMapping.length,
                                (index) => CourseMappingWidget(
                                  canEdit: _authCubit.userModel!.role==UserRole.admin,
                                  model:
                                      _courseMappingCubit.filterMapping[index],
                                ),
                              )
                            else
                              DataNotFoundWidget(
                                onTap: () async {
                                  await _courseMappingCubit.getMappingData();
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
              if(
              _authCubit.userModel!.role==UserRole.admin)
              AnimatedPositioned(
                duration: Duration(milliseconds: 100),
                top: _courseMappingCubit.top,
                right: _courseMappingCubit.right,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    _courseMappingCubit.getButtonPosition(
                      topVal: details.delta.dy,
                      rightVal: details.delta.dx,
                    );
                  },
                  child: CustomElevatedButton(
                    onPressed: () {
                      context.push("/Admin-add-course-mapping");
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

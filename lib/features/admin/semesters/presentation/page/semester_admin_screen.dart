import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/Authentication/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/semesters/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/semesters/presentation/page/add_semester_screen.dart';
import 'package:college_management/widgets/data_not_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:college_management/widgets/custom_text_form.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../core/enums/user_enums.dart';
import '../../../../../widgets/custom_button.dart';
import '../widgets/program_time_line_widget.dart';

class SemesterAdminScreen extends StatefulWidget {
  const SemesterAdminScreen({super.key});

  @override
  State<SemesterAdminScreen> createState() =>
      _SemesterAdminScreenState();
}

class _SemesterAdminScreenState
    extends State<SemesterAdminScreen> {

  var _semesterCubit=DiContainer().sl<SemesterAdminCubit>();
  var _authCubit=DiContainer().sl<AuthenticationCubit>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
     await _semesterCubit.getSemesterList();
    },);
  }


  double       top=mdHeight(navigatorKey.currentContext!)*.9;
  double left=mdWidth(navigatorKey.currentContext!)*.65;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder(bloc: _semesterCubit,
        builder: (context,statesbhjklk) {
          return Stack(
            children: [
              Column(
                children: [
                  /// 🔹 TOP BAR
                  CustomTopBar(text: "Semesters",

                    suffix:

              _authCubit.userModel!.role==UserRole.admin?
                    InkWell(
                      onTap: () {
                        _semesterCubit.canEdit(!_semesterCubit.isEdit);
                      },
                      child: Icon(_semesterCubit.isEdit? Icons.close:Icons.edit,color: AppColor.white,size: 20,))
                  :null,),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal:screenPaddingHori),
                        child: Column(
                          children: [
                            SizedBox(height: 10,),

                            /// 🔹 SEARCH
                            CustomTextFormField(
                              controller: _semesterCubit.searchController,
                              subTitle: "Search...",
                              isHintText: true,
                              onChanged: (p0) {
                                _semesterCubit.getSearchVal(p0.toLowerCase());
                              },
                              borderSize: 1,
                              contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                            ),

                            SizedBox(height: 15,),

                            if(_semesterCubit.groupedSemesterList.isNotEmpty)
                            ...List.generate(_semesterCubit.groupedSemesterList.length, (index) => ProgramTimelineCard(
                              semesterLevelsModel: _semesterCubit.groupedSemesterList[index],),)
                            else
                              DataNotFoundWidget(onTap: ()async{
                              await  _semesterCubit.getSemesterList();
                              }),
                            SafeArea(
                                top: false,
                                child: SizedBox(height: 30,)),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),

              if(_semesterCubit.isEdit)
              AnimatedPositioned(
                duration: Duration(milliseconds: 100),
                top: _semesterCubit.top,
                right: _semesterCubit.right,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    _semesterCubit.getButtonPosition(topVal: details.delta.dy, rightVal: details.delta.dx);

                  },
                  child: CustomElevatedButton(
                    onPressed: () {
                      context.push("/Admin-add-semester-screen");
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
        }
      ),
    );
  }
}
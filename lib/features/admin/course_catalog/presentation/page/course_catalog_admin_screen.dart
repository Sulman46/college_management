import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/features/admin/course_catalog/presentation/widgets/add_new_course_catalog_dialog.dart';
import 'package:college_management/widgets/data_not_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:college_management/widgets/custom_text_form.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app/di_container.dart';
import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../core/enums/user_enums.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../Authentication/presentation/controller/cubit.dart';
import '../controller/cubit.dart';
import '../widgets/course_list_widget.dart';


class CourseCatalogAdminScreen extends StatefulWidget {
  const CourseCatalogAdminScreen({super.key});

  @override
  State<CourseCatalogAdminScreen> createState() =>
      _CourseCatalogAdminScreenState();
}

class _CourseCatalogAdminScreenState
    extends State<CourseCatalogAdminScreen> {

  TextEditingController searchController = TextEditingController();

  var _courseCatalogCubit = DiContainer().sl<CourseCatalogAdminCubit>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    await  _courseCatalogCubit.getCourseCatalogList();
    },);
  }

  double       top=mdHeight(navigatorKey.currentContext!)*.9;
  double left=mdWidth(navigatorKey.currentContext!)*.65;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder(
        bloc: _courseCatalogCubit,
        builder: (context,statesbkjno) {
          return Stack(
            children: [
              Column(
                children: [
                  /// 🔹 TOP BAR
                  CustomTopBar(text: "Course Catalog"),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal:screenPaddingHori),
                        child: Column(
                          children: [
                            SizedBox(height: 10,),

                            /// 🔹 SEARCH
                            CustomTextFormField(
                              controller: _courseCatalogCubit.searchController,
                              subTitle: "Search...",
                              isHintText: true,
                              onChanged: (p0) {
                                _courseCatalogCubit.filterData(p0.toLowerCase());
                              },
                              borderSize: 1,
                              contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                            ),

                            SizedBox(height: 15,),


                            if(_courseCatalogCubit.filterCourseCatalogList.isNotEmpty)
                            ...List.generate(_courseCatalogCubit.filterCourseCatalogList.length,
                                  (index) => CourseListWidget(canEdit: _authCubit.userModel!.role==UserRole.admin,courseCatalogModel: _courseCatalogCubit.filterCourseCatalogList[index],),)
                            else
                              DataNotFoundWidget(onTap: ()async{
                               await _courseCatalogCubit.getCourseCatalogList();
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

              if(_authCubit.userModel!.role==UserRole.admin)
                AnimatedPositioned(
                duration: Duration(milliseconds: 100),
                top: _courseCatalogCubit.top,
                right: _courseCatalogCubit.right,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    _courseCatalogCubit.getButtonPosition(topVal: details.delta.dy, rightVal: details.delta.dx);

                  },
                  child: CustomElevatedButton(
                    onPressed: () {
                      showDialog(context: context, builder: (context) => AddNewCourseCatalogDialog(),);
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

final _authCubit=DiContainer().sl<AuthenticationCubit>();


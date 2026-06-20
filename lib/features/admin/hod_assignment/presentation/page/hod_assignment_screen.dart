import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/features/admin/hod_assignment/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/hod_assignment/presentation/widgets/assign_hod_department_dialog.dart';
import 'package:college_management/widgets/data_not_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:college_management/widgets/custom_text_form.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app/di_container.dart';
import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../widgets/custom_button.dart';
import '../widgets/hod_assignment_item.dart';

class HodAssignmentScreen extends StatefulWidget {
  const HodAssignmentScreen({super.key});

  @override
  State<HodAssignmentScreen> createState() =>
      _HodAssignmentScreenState();
}

class _HodAssignmentScreenState extends State<HodAssignmentScreen> {

  TextEditingController searchController = TextEditingController();
  var _hodAssignmentCubit=DiContainer().sl<HODAssignmentCubit>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _hodAssignmentCubit.get();
    },);
    super.initState();
  }


  double top=mdHeight(navigatorKey.currentContext!)*.9;
  double left=mdWidth(navigatorKey.currentContext!)*.65;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder(
        bloc: _hodAssignmentCubit,
        builder: (context,statesbknj) {
          return Stack(
            children: [
              Column(
                children: [
                  /// 🔹 TOP BAR
                  CustomTopBar(text: "HOD Assignment"),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal:screenPaddingHori),
                        child: Column(
                          children: [
                            SizedBox(height: 10,),

                            /// 🔹 SEARCH
                            CustomTextFormField(
                              controller: _hodAssignmentCubit.searchController,
                              subTitle: "Search...",
                              isHintText: true,
                              onChanged: (p0) {
                                _hodAssignmentCubit.filterData(p0.toLowerCase());
                              },
                              borderSize: 1,
                              contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                            ),

                            SizedBox(height: 15,),

                            if(_hodAssignmentCubit.filterList.isNotEmpty)
                            ...List.generate(_hodAssignmentCubit.filterList.length, (index) => HodAssignmentItem(model: _hodAssignmentCubit.filterList[index],),)
                            else
                              DataNotFoundWidget(onTap: () async{
                                await _hodAssignmentCubit.get();
                              },),
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
              AnimatedPositioned(
                duration: Duration(milliseconds: 100),
                top: _hodAssignmentCubit.top,
                right: _hodAssignmentCubit.right,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    _hodAssignmentCubit.getButtonPosition(topVal: details.delta.dy, rightVal: details.delta.dx);
                  },
                  child: CustomElevatedButton(
                    onPressed: () {
                      showDialog(context: context, builder: (context) => AssignHodDepartmentDialog(),);
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
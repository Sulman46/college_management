import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/features/admin/teacher_allocation/presentation/controller/cubit.dart';
import 'package:college_management/widgets/data_not_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:college_management/widgets/custom_text_form.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/enums/user_enums.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../Authentication/presentation/controller/cubit.dart';
import '../widgets/teacher_allocation_item.dart';


class TeacherAllocationScreen extends StatefulWidget {
  const TeacherAllocationScreen({super.key});

  @override
  State<TeacherAllocationScreen> createState() =>
      _TeacherAllocationScreenState();
}

class _TeacherAllocationScreenState extends State<TeacherAllocationScreen> {
final _allocationCubit=DiContainer().sl<TeacherAllocationCubit>();
final _authCubit=DiContainer().sl<AuthenticationCubit>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
     await _allocationCubit.get();
    },);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder(
          bloc: _allocationCubit,
        builder: (context,statesbkk) {
          return Stack(
            children: [
              Column(
                children: [
                  /// 🔹 TOP BAR
                  CustomTopBar(text: "Teacher Allocation"),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal:screenPaddingHori),
                        child: Column(
                          children: [
                            SizedBox(height: 10,),

                            /// 🔹 SEARCH
                            CustomTextFormField(
                              controller: _allocationCubit.searchController,
                              subTitle: "Search...",
                              isHintText: true,
                              onChanged: (p0) {
                                _allocationCubit.filterData(p0.toLowerCase());
                              },
                              borderSize: 1,
                              contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                            ),

                            SizedBox(height: 15,),

                            /// 🔹 LIST
                            if(_allocationCubit.filterTeacherAllocation.isNotEmpty)
                            ...List.generate(_allocationCubit.filterTeacherAllocation.length, (index) => TeacherAllocationItem(canEdit: _authCubit.userModel!.role==UserRole.admin,model: _allocationCubit.filterTeacherAllocation[index],),)
                            else
                              DataNotFoundWidget(onTap: () async{
                               await _allocationCubit.get();
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
              if(_authCubit.userModel!.role==UserRole.admin)
              AnimatedPositioned(
                duration: Duration(milliseconds: 100),
                top: _allocationCubit.top,
                right: _allocationCubit.right,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    _allocationCubit.getButtonPosition(topVal: details.delta.dy, rightVal: details.delta.dx);

                  },
                  child: CustomElevatedButton(
                    onPressed: () {
                      context.push("/Admin-add-teacher-allocation");
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
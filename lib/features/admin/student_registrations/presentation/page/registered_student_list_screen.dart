import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/features/admin/student_registrations/presentation/page/add_new_student_screen.dart';
import 'package:college_management/features/admin/teacher_records/presentation/page/add_teacher_record_screen.dart';
import 'package:college_management/features/admin/teacher_records/presentation/widgets/teacher_record_item_widget.dart';
import 'package:college_management/widgets/data_not_found_widget.dart';
import 'package:college_management/widgets/floating_add_new_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:college_management/widgets/custom_text_form.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../core/enums/user_enums.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../Authentication/presentation/controller/cubit.dart';
import '../../../teacher_allocation/presentation/widgets/teacher_allocation_item.dart';
import '../widgets/registered_student_item.dart';
import 'package:college_management/features/admin/student_registrations/presentation/controller/cubit.dart';
class RegisteredStudentListScreen extends StatefulWidget {
  const RegisteredStudentListScreen({super.key});

  @override
  State<RegisteredStudentListScreen> createState() =>
      _RegisteredStudentListScreenState();
}

class _RegisteredStudentListScreenState extends State<RegisteredStudentListScreen> {
  var _studentRegisterCubit = DiContainer().sl<StudentRegistrationCubit>();

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      await _studentRegisterCubit.get();
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
        bloc: _studentRegisterCubit,
        builder: (context,statesbkk) {
          return Stack(
            children: [
              Column(
                children: [
                  /// 🔹 TOP BAR
                  CustomTopBar(text: "Registered Students"),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal:screenPaddingHori),
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            /// 🔹 SEARCH
                            CustomTextFormField(
                              controller: _studentRegisterCubit.searchController,
                              subTitle: "Search...",
                              isHintText: true,
                              onChanged: (p0) {
                                _studentRegisterCubit.filterData(p0.toLowerCase());
                              },
                              borderSize: 1,
                              contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                            ),

                            SizedBox(height: 15,),

                            /// 🔹 LIST
                            if(_studentRegisterCubit.filterList.isNotEmpty)
                            ...List.generate(_studentRegisterCubit.filterList.length,
                                  (index) => RegisteredStudentItem(canEdit: _authCubit.userModel!.role==UserRole.admin,studentModel: _studentRegisterCubit.filterList[index],),)
                            else
                              DataNotFoundWidget(onTap: () async{
                              await _studentRegisterCubit.get();
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
                top: _studentRegisterCubit.top,
                right: _studentRegisterCubit.right,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    _studentRegisterCubit.getButtonPosition(topVal: details.delta.dy, rightVal: details.delta.dx);

                  },
                  child: FloatingAddNewButtonWidget(text: "Add New", onTap: (){
                    _studentRegisterCubit.getStudentUpdateModel(null);
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewStudentScreen(),));
                  }),
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



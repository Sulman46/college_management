import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/features/admin/coordinator_management/presentation/widgets/coordinator_register_dialog.dart';
import 'package:college_management/features/admin/coordinator_management/presentation/widgets/registered_coordinator_widget.dart';
import 'package:college_management/features/admin/hod_assignment/presentation/controller/cubit.dart';
import 'package:college_management/widgets/custom_animated_dialog.dart';
import 'package:college_management/widgets/data_not_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:college_management/widgets/custom_text_form.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app/di_container.dart';
import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../widgets/custom_button.dart';
import '../controller/cubit.dart';

class CoordinatorManagementScreen extends StatefulWidget {
  const CoordinatorManagementScreen({super.key});

  @override
  State<CoordinatorManagementScreen> createState() =>
      _CoordinatorManagementScreenState();
}

class _CoordinatorManagementScreenState extends State<CoordinatorManagementScreen> {

  TextEditingController searchController = TextEditingController();
  final _coordinatorCubit=DiContainer().sl<CoordinatorManagementCubit>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _coordinatorCubit.get();
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
          bloc: _coordinatorCubit,
          builder: (context,statesbknj) {
            return Stack(
              children: [
                Column(
                  children: [
                    /// 🔹 TOP BAR
                    CustomTopBar(text: "Coordinator Management"),

                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal:screenPaddingHori),
                          child: Column(
                            children: [
                              SizedBox(height: 10,),

                              /// 🔹 SEARCH
                              CustomTextFormField(
                                controller: _coordinatorCubit.searchController,
                                subTitle: "Search...",
                                isHintText: true,
                                onChanged: (p0) {
                                  _coordinatorCubit.filterData(p0.toLowerCase());
                                },
                                borderSize: 1,
                                contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                              ),

                              SizedBox(height: 15,),

                              if(_coordinatorCubit.filterList.isNotEmpty)
                                ...List.generate(_coordinatorCubit.filterList.length, (index) => RegisteredCoordinatorWidget(model: _coordinatorCubit.filterList[index],),)
                              else
                                DataNotFoundWidget(onTap: () async{
                                  await _coordinatorCubit.get();
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
                  top: _coordinatorCubit.top,
                  right: _coordinatorCubit.right,
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      _coordinatorCubit.getButtonPosition(topVal: details.delta.dy, rightVal: details.delta.dx);
                    },
                    child: CustomElevatedButton(
                      onPressed: () {
                        showDialog(context: context, builder: (context) => CustomAnimatedDialog(child: CoordinatorRegisterDialog()),);
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
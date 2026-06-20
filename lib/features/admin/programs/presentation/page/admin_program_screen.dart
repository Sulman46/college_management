import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/features/admin/programs/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/programs/presentation/widgets/admin_program_widget.dart';
import 'package:flutter/material.dart';
import 'package:college_management/widgets/custom_text_form.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';


class AdminProgramScreen extends StatefulWidget {
  const AdminProgramScreen({super.key});

  @override
  State<AdminProgramScreen> createState() =>
      _AdminProgramScreenState();
}

class _AdminProgramScreenState
    extends State<AdminProgramScreen> {

  var _programsCubit=DiContainer().sl<AdminProgramsCubit>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    await  _programsCubit.getPrograms();
    },);
  }


  double       top=mdHeight(navigatorKey.currentContext!)*.9;
  double left=mdWidth(navigatorKey.currentContext!)*.65;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder(
        bloc: _programsCubit,
        builder: (context,statebskjn) {
          return Stack(
            children: [
              Column(
                children: [
                  /// 🔹 TOP BAR
                  CustomTopBar(text: "Programs"),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal:screenPaddingHori),
                        child: Column(
                          children: [
                            SizedBox(height: 10,),

                            /// 🔹 SEARCH
                            CustomTextFormField(
                              controller: _programsCubit.searchController,
                              subTitle: "Search...",
                              isHintText: true,
                              onChanged: (p0) {
                                _programsCubit.filterList(p0.toLowerCase());
                              },
                              borderSize: 1,
                              contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                            ),

                            SizedBox(height: 15,),

                            /// 🔹 LIST
                            if (_programsCubit.filterProgramsList.isEmpty) Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppText(
                                    text: "Programs not found",
                                    color: AppColor.grey,
                                  ),
                                  SizedBox(height: 10,),
                                  InkWell(
                                      onTap: ()async {
                                        await _programsCubit.getPrograms();
                                      },
                                      child: Icon(Icons.refresh,size: 20,color: AppColor.primary,)),
                                ],
                              ),
                            ) else
                            ...List.generate(_programsCubit.filterProgramsList.length, (index) => AdminProgramWidget(model: _programsCubit.filterProgramsList[index],),),
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
                top: _programsCubit.top,
                right: _programsCubit.right,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    _programsCubit.getButtonPosition(topVal:details.delta.dy, rightVal: details.delta.dx);
                  },
                  child: CustomElevatedButton(
                    onPressed: () {
                      context.push("/Admin-program-create");
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
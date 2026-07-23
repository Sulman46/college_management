import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/enums/user_enums.dart';
import 'package:college_management/features/Authentication/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/freez_unfreez_admin/presentation/widgets/student_freeze_request_dialog.dart';
import 'package:college_management/widgets/data_not_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/custom_text_form.dart';
import '../../../../../widgets/custom_top_bar.dart';
import '../../../neural_generator/presentation/widgets/neural_tabs_widget.dart';
import '../controller/cubit.dart';
import '../widgets/freeze_request_widget.dart';

class FreezeUnfreezeScreen extends StatefulWidget {
  const FreezeUnfreezeScreen({super.key});

  @override
  State<FreezeUnfreezeScreen> createState() => _FreezeUnfreezeScreenState();
}

class _FreezeUnfreezeScreenState extends State<FreezeUnfreezeScreen> {
  TextEditingController searchController=TextEditingController();
  final _freezeCubit=DiContainer().sl<FreezUnFreezCubit>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _freezeCubit.getTabVal(true);
      if(_authCubit.userModel!.role!=UserRole.student) {

        await _freezeCubit.getPen();
      }else{
        await _freezeCubit.getMyRequest();
      }
    },);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
          bloc: _freezeCubit,
          builder: (context,stateus) {
            return Column(
              children: [
                CustomTopBar(text: "Freeze/Withdrawals",suffix:

                _authCubit.userModel!.role!=UserRole.student?null:InkWell(
                  splashColor: AppColor.transparent,
                  hoverColor: AppColor.transparent,
                  onTap: () {
                    showDialog(context: context, builder: (context) => StudentFreezeRequestDialog(),);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1,color: AppColor.white),
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(5),
                    child: Icon(Icons.add,size: 15,color: AppColor.white,),
                  ),
                ),),
                Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: screenPaddingHori),
                      child: Column(
                        children: [
                          SizedBox(height: 5,),
                          if(_authCubit.userModel!.role!=UserRole.student)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 2,vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColor.bgPrimary.withOpacity(.5), // glass tint
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColor.primary.withOpacity(.5),
                                width: .5,
                              ),
                              // boxShadow: AppColor.shadowBlack,
                            ),
                            child: Row(
                              children: [
                                Expanded(child: NeuralTabsWidget(text: "Pending", onTap: () async {
                                  _freezeCubit.getTabVal(true);
                                  await _freezeCubit.getPen();
                                }, isSelected:_freezeCubit.isPendingTab)),
                                Expanded(child: NeuralTabsWidget(text: "Finalized", onTap: () async {
                                  _freezeCubit.getTabVal(false);
                                  await _freezeCubit.getFinal();
                                }, isSelected: !_freezeCubit.isPendingTab)),
                              ],
                            ),
                          ),
                          SizedBox(height: 5,),
                          CustomTextFormField(
                            controller: _freezeCubit.searchController,
                            subTitle: "Search...",
                            isHintText: true,
                            onChanged: (p0) {
                              _freezeCubit.getSearchText(p0.toLowerCase());
                            },
                            borderSize: 1,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 10,
                            ),
                          ),
                          SizedBox(height: 5,),

                          if(_freezeCubit.filterList.isNotEmpty)
                            ...List.generate(_freezeCubit.filterList.length, (index) => FreezeRequestWidget(model:_freezeCubit.filterList[index],),)
                          else
                            DataNotFoundWidget(onTap: () async {
                              if(_authCubit.userModel!.role==UserRole.student){
                                await _freezeCubit.getMyRequest();
                                return;
                              }
                              if(_freezeCubit.isPendingTab){
                                await _freezeCubit.getPen();
                              }else{
                                await _freezeCubit.getFinal();
                              }
                            },),

                          SafeArea(
                              top: false,
                              child: SizedBox(height: 20,)),

                        ],
                      ),
                    ))

              ],
            );
          }
      ),
    );
  }
}

var _authCubit=DiContainer().sl<AuthenticationCubit>();

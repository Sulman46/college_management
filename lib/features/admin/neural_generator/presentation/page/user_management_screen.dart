import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/constants/constant_data.dart';
import 'package:college_management/features/admin/neural_generator/presentation/widgets/neural_user_widget.dart';
import 'package:college_management/widgets/data_not_found_widget.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../widgets/custom_text_form.dart';
import '../../../../../widgets/custom_top_bar.dart';
import '../controller/cubit.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  TextEditingController searchController=TextEditingController();
  final _neuralGeneratorCubit=DiContainer().sl<NeuralGeneratorCubit>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _neuralGeneratorCubit.getNeuralUserManagement();
    },);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        bloc: _neuralGeneratorCubit,
        builder: (context,stateus) {
          return Column(
            children: [
              CustomTopBar(text: "User Security Management"),
              Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: screenPaddingHori),
                child: Column(
                  children: [
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Expanded(child: CustomPopMenuButton(menus: ["All","Active","Inactive","Blocked"],
                          onSelected: (p0) {
                            String val=["All","Active","Inactive","Blocked"][p0];
                            _neuralGeneratorCubit.getUserStatus(val=="All"?"":val);
                          },
                          widget: DropDownFieldWidget(text:_neuralGeneratorCubit.status==""? "All":_neuralGeneratorCubit.status, isFilled: true),)),
                        SizedBox(width: 5,),
                        Expanded(child: CustomPopMenuButton(menus: ["All",...ConstantData.userRoles.map((e) => e.toJson(),)],
                          onSelected: (p0) {
                          String val=["All",...ConstantData.userRoles.map((e) => e.toJson(),)][p0];
                            _neuralGeneratorCubit.getUserManagementRole(val=="All"?"":val);
                          },
                          widget: DropDownFieldWidget(text: _neuralGeneratorCubit.role==""? "All":_neuralGeneratorCubit.role, isFilled: true),)),
                      ],
                    ),
                    SizedBox(height: 5,),
                    CustomTextFormField(
                      controller: _neuralGeneratorCubit.searchUserManagement,
                      subTitle: "Search...",
                      isHintText: true,
                      onChanged: (p0) {
                        _neuralGeneratorCubit.getUserSearch(p0.toLowerCase());
                      },
                      borderSize: 1,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 10,
                      ),
                    ),
                    SizedBox(height: 5,),

                    if(_neuralGeneratorCubit.neuralUsersManagementFilter.isNotEmpty)
                    ...List.generate(_neuralGeneratorCubit.neuralUsersManagementFilter.length, (index) => NeuralUserWidget(model: _neuralGeneratorCubit.neuralUsersManagementFilter[index],),)
                    else
                      DataNotFoundWidget(onTap: () async {
                        await _neuralGeneratorCubit.getNeuralUserManagement();
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

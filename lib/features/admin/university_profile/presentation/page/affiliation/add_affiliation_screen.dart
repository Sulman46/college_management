import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/constants/media_query.dart';
import 'package:college_management/core/enums/status_enum.dart';
import 'package:college_management/features/admin/university_profile/models/affiliation_model.dart';
import 'package:college_management/features/admin/university_profile/models/university_model.dart';
import 'package:college_management/features/admin/university_profile/presentation/controller/cubit.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/helper/show_message.dart';
import '../../../../../../core/theme/AppColor.dart';
import '../../../../../../widgets/app_text.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../../../widgets/custom_text_form.dart';
import '../../../../../../widgets/custom_top_bar.dart';


class AddAffiliationScreen extends StatefulWidget {
  const AddAffiliationScreen({super.key});

  @override
  State<AddAffiliationScreen> createState() => _AddAffiliationScreenState();
}

class _AddAffiliationScreenState extends State<AddAffiliationScreen> {
  /// 🔹 Controllers
  final nameController = TextEditingController();
  final location = TextEditingController();
  final sector = TextEditingController();
  final website = TextEditingController();


  final midsController = TextEditingController();
  final sessional = TextEditingController();
  final finalController = TextEditingController();
  final totalTheory = TextEditingController();
  final theoryPassController = TextEditingController();

  final practicalMarksController = TextEditingController();
  final practicalPassController = TextEditingController();


  var universityProfileCubit=DiContainer().sl<UniversityProfileCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgPrimary,
      body: BlocBuilder(
        bloc: universityProfileCubit,
        builder: (context,statesbhj) {
          return Column(
            children: [
              CustomTopBar(text: "Create New Affiliation"),


              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal:screenPaddingHori,vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: AppText(text: "Add details for a new affiliation.",fontSize: 12,color: AppColor.primary,fontWeight: FontWeight.w500,textAlign: TextAlign.center,)),
                      SizedBox(height: 10,),

                      CustomTextFormField(
                        controller: nameController,
                        subTitle: "Name",

                      ),
                      SizedBox(height: 15,),
                      CustomTextFormField(
                        controller: location,
                        subTitle: "Location",

                      ),
                      SizedBox(height: 15),
                      CustomTextFormField(
                        controller: website,
                        subTitle: "Website",

                      ),
                      SizedBox(height: 15),

                      /// 🔹 LEVEL + AFFILIATION
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              controller: sector,
                              subTitle: "Sector",

                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: CustomPopMenuButton(
                              onSelected: (p0) {
                                universityProfileCubit.getStatusEnum(p0==0?StatusEnum.Active:StatusEnum.Inactive);
                              },
                              menus: ["Active", "InActive"],
                              widget:
                              DropDownFieldWidget(text: universityProfileCubit.statusEnum!=null?universityProfileCubit.statusEnum!.name:"Select Status",isFilled: universityProfileCubit.statusEnum!=null,),

                            ),
                          ),
                        ],
                      ),



                      SizedBox(height: 15),

                      /// 🔥 GRADING FRAMEWORK
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppText(
                            text: "Grading Framework",
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppColor.primary.withOpacity(.8),
                          ),
                          SizedBox(width: 5,),
                          Expanded(child: Divider(thickness: 1,color: AppColor.primary.withOpacity(.8),height: 1,))
                        ],
                      ),

                      SizedBox(height: 5),
                      AppText(
                        text: "Theory",
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColor.grey.withOpacity(.8),
                      ),
                      SizedBox(height: 10),

                      /// 🔹 THEORY ROW 1
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              controller: midsController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              subTitle: "Mids",
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: CustomTextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: sessional,
                              subTitle: "Sessional",
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 15),

                      /// 🔹 THEORY ROW 2
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: finalController,
                              subTitle: "Final",
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: CustomTextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: totalTheory,
                              subTitle: "Total Theory",
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10),
                      CustomTextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: theoryPassController,
                        subTitle: "Theory Pass %",
                      ),
                      SizedBox(height: 10),

                      /// 🔹 PRACTICAL
                      AppText(
                        text: "Practical",
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColor.grey.withOpacity(.8),
                      ),

                      SizedBox(height: 10),

                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: practicalMarksController,
                              subTitle: "Max Marks",
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: CustomTextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: practicalPassController,
                              subTitle: "Pass %",
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 25),

                      /// 🔹 BUTTON
                      Center(
                        child: CustomElevatedButton(
                          width: mdWidth(context)*.6,
                          onPressed: () async {

                            if (
                            nameController.text.isEmpty ||
                                location.text.isEmpty ||
                                sector.text.isEmpty ||
                                website.text.isEmpty ||
                                midsController.text.isEmpty ||
                                sessional.text.isEmpty ||
                                finalController.text.isEmpty ||
                                totalTheory.text.isEmpty ||
                                theoryPassController.text.isEmpty ||
                                practicalMarksController.text.isEmpty ||
                                practicalPassController.text.isEmpty||
                                 universityProfileCubit.statusEnum==null
                            ) {
                              showMessage("Please fill all fields",isError: true);
                              return;
                            }


                            AffiliationModel affiliationModel=AffiliationModel(name: nameController.text, sector: sector.text, location: location.text, website: website.text, status: universityProfileCubit.statusEnum!.name, theory: TheoryGradingCriteria(mids: int.parse(midsController.text), sessional: int.parse(sessional.text), finalMarks: int.parse(finalController.text), totalTheory: int.parse(totalTheory.text), passPercentage: int.parse(theoryPassController.text)), practical: PracticalGradingCriteria(maxMarks: int.parse(practicalMarksController.text), passPercentage: int.parse(practicalPassController.text)));

                            List<AffiliationModel> temp=universityProfileCubit.universityModel!.affiliationModel??[];
                            temp.add(affiliationModel);
                            UniversityModel model=UniversityModel(affiliationModel: temp);
                            bool val= await universityProfileCubit.addUniversitySetup(model);
                            if(val){
                              context.pop();
                            }
                            // proceed API call or next step here
                          },
                          text: "Create Program",
                        ),
                      ),
                    ],
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
import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/constants/media_query.dart';
import 'package:college_management/widgets/custom_button.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';

class PayrollFilterBottomSheet extends StatelessWidget {
  const PayrollFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenPaddingHori),
      child: Column(
        children: [
          SizedBox(height: 20,),
          AppText(text: "Active billings",fontSize: 14,color: AppColor.primary,),
          SizedBox(height: 20,),
          CustomPopMenuButton(menus: ['Departments 1','Departments 1',],widget: DropDownFieldWidget(text: "All Departments", isFilled: true),),
          SizedBox(height: 10,),
          CustomPopMenuButton(menus: ['Type 1','Type 1',],widget: DropDownFieldWidget(text: "All Types", isFilled: true),),
        SizedBox(height: 10,),
          CustomPopMenuButton(menus: ['Type 1','Type 1',],widget: DropDownFieldWidget(text: "All", isFilled: true),),
       SizedBox(height: 10,),
          CustomPopMenuButton(menus: ['Teacher 1','Teacher 1',],widget: DropDownFieldWidget(text: "All Teacher", isFilled: true),),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(child: Divider(height: 1,thickness: 1,color: AppColor.grey.withOpacity(.5),)),
              SizedBox(width: 10,),
              AppText(text: "Documents",fontSize: 12,color: AppColor.grey.withOpacity(.8)),
              SizedBox(width: 10,),
              Expanded(child: Divider(height: 1,thickness: 1,color: AppColor.grey.withOpacity(.5),)),
            ],
          ),

          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(child: documentGenerateWidget("Generate Bill", AppColor.red)),
              SizedBox(width: 10,),
              Expanded(child: documentGenerateWidget("Export PDF", AppColor.green)),
            ],
          ),
          Spacer(),
          SafeArea(

              child: Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child:
                  Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          text: "Discard",
                          bgColor: AppColor.white,
                          textColor: AppColor.red,
                          borderColor: AppColor.red,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CustomElevatedButton(
                          onPressed: () {
                            // TODO: Submit logic
                          },
                          text: "Search",
                        ),
                      ),
                    ],
                  )
              )
          ),
        ],
      ),
    );
  }
}


Widget documentGenerateWidget(String text,Color color){
  return Container(
    alignment:
    Alignment.center,
    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: color.withOpacity(.2),
      border: Border.all(width: 1,color:color),
    ),
    child:AppText(text: text,fontSize: 12,color: color),
  );
}
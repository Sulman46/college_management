import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/neural_generator/models/neural_user_management_model.dart';
import 'package:college_management/features/admin/neural_generator/presentation/widgets/user_neural_status_widget.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/custom_image_cache.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';

import '../../../../../core/app/di_container.dart';
import '../controller/cubit.dart';

class NeuralUserWidget extends StatefulWidget {
   NeuralUserWidget({super.key,required this.model});
  NeuralUserManagementModel model;

  @override
  State<NeuralUserWidget> createState() => _NeuralUserWidgetState();
}

class _NeuralUserWidgetState extends State<NeuralUserWidget> {
  
  List<String> statusList=[ "Active","Inactive","Blocked","Reset key"];
  
  @override
  void initState() {
    statusList.remove(widget.model.status??"");
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
      decoration: AppColor.containerNeon,
      child: Column(
        children: [
          Row(
            children: [
              widget.model.profileImg==null||   widget.model.profileImg==""?   Container(
                height: 40,width: 40,
                decoration: BoxDecoration(
                  color: AppColor.bgPrimary.withOpacity(.5), // glass tint
                  border: Border.all(
                    color: AppColor.primary.withOpacity(.5),
                    width: .5,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: AppColor.shadowBlack,
                ),
                child: Center(child: AppText(text: (widget.model.name??"")[0].toUpperCase(),color: AppColor.greyLight,)),
              ):CustomImageCache(url: widget.model.profileImg??"",height: 40,width: 40,),
              SizedBox(width: 6,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(text: widget.model.name??"",fontSize: 12,color: AppColor.white,),
                    AppText(text: widget.model.email??"",fontSize: 10,color: AppColor.greyLight,),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(text: "ID: ${widget.model.username??""}",fontSize: 11,color: AppColor.greyLight,),
              AppText(text: widget.model.role??"",fontSize: 11,color: AppColor.secondaryColor,),
            ],
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UserNeuralStatusWidget(status: widget.model.status??"Active"),
              widget.model.role=="Admin"? SizedBox():CustomPopMenuButton(
                menus:statusList,
                onSelected: (p0) async {
                  final neuralGeneratorCubit=DiContainer().sl<NeuralGeneratorCubit>();
                  if(statusList[p0]=="Reset key"){
                   var res= await neuralGeneratorCubit.keyPatchNeuralUserManagement(widget.model);
                    if(res){
                      await neuralGeneratorCubit.getNeuralUserManagement();
                    }
                  }else{
                   var res= await neuralGeneratorCubit.statusPatchNeuralUserManagement(widget.model.copyWith(status: statusList[p0]));
                    if(res){
                      await neuralGeneratorCubit.getNeuralUserManagement();
                    }
                  }
                },
                
              ),
            ],
          ),
        ],
      ),
    );
  }
}

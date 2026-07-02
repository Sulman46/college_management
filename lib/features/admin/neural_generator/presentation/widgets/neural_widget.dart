import 'dart:math';

import 'package:college_management/features/admin/neural_generator/models/neural_widget_model.dart';
import 'package:college_management/features/admin/teacher_records/models/teacher_model.dart';
import 'package:flutter/material.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../controller/cubit.dart';
import 'neural_user_status.dart';

class NeuralWidget extends StatefulWidget {
  NeuralWidget({super.key,required this.model});
   NeuralWidgetModel model;
  @override
  State<NeuralWidget> createState() => _NeuralWidgetState();
}

class _NeuralWidgetState extends State<NeuralWidget> {
  final _neuralGeneratorCubit=DiContainer().sl<NeuralGeneratorCubit>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.symmetric(horizontal: 7,vertical: 7),
      decoration:widget.model.canSelect? AppColor.containerNeonGreen:AppColor.containerNeon,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: AppText(text: widget.model.name,fontSize: 11,color: AppColor.white,fontWeight: FontWeight.w600,)),
              widget.model.canSelect? SizedBox(): InkWell(
                  onTap:() {
                    if(_neuralGeneratorCubit.userIds.any((element) => element.id==widget.model.id,)){
                      List<NeuralWidgetModel> list=List.from(_neuralGeneratorCubit.userIds);
                      list.removeWhere((element) => element.id==widget.model.id,);
                      _neuralGeneratorCubit.getIds(list);
                    }else{
                      List<NeuralWidgetModel> list=List.from(_neuralGeneratorCubit.userIds);
                      list.add(widget.model);
                      _neuralGeneratorCubit.getIds(list);
                    }
                  },
                  child: Icon(_neuralGeneratorCubit.userIds.any((element) => element.id==widget.model.id,)? Icons.check_box_rounded:Icons.check_box_outline_blank,size: 20,color:_neuralGeneratorCubit.userIds.any((element) => element.id==widget.model.id,)? AppColor.white.withOpacity(.8):AppColor.grey.withOpacity(.8),)),
            ],
          ),
          SizedBox(height: 4,),
          AppText(text:"Dept: ${widget.model.department.join(", ")}",fontSize: 11,color: AppColor.white,fontWeight: FontWeight.w500,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(text: widget.model.email??"",fontSize: 11,color: AppColor.white,fontWeight: FontWeight.w600,),
              NeuralUserStatus(isGenerated: widget.model.canSelect),
            ],
          )
        ],
      ),

    );
  }
}

import 'package:college_management/core/constants/constant_data.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/leave_request/models/faculty_leave_model.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';
import '../controller/cubit.dart';
import 'approved_reject_widget.dart';

class LeaveItem extends StatefulWidget {
   LeaveItem({super.key,required this.model});
  FacultyLeaveModel model;
  @override
  State<LeaveItem> createState() => _LeaveItemState();
}

class _LeaveItemState extends State<LeaveItem> {
  final _leaveCubit=DiContainer().sl<LeaveRequestCubit>();
  bool showMore=false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      decoration:  AppColor.containerNeon,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ApprovedRejectWidget(status:widget.model.status=="Approved"? LeaveRequestStatusEnum.approved:widget.model.status=="Rejected"? LeaveRequestStatusEnum.reject: LeaveRequestStatusEnum.pending),
              CustomPopMenuButton(
                menus: [ "Pending", "Approved", "Rejected"],
                onSelected: (value) async {
                  var response=await _leaveCubit.update(widget.model.copyWith(status: [ "Pending", "Approved", "Rejected"][value]));
                  if(response){
                 await _leaveCubit.get();
                  }
                },),
            ],
          ),
          SizedBox(height: 5,),
          AppText(text: widget.model.teacher?.name??"-",fontSize: 12,color: AppColor.white,fontWeight: FontWeight.w600,),
          SizedBox(height: 3,),
          AppText(text: "Dept. ${widget.model.departments?.map((e) => e.name,).join(", ")??"-"}",fontSize: 11,color: AppColor.white,fontWeight: FontWeight.w500,),
          SizedBox(height: 3,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(text: "${widget.model.startDate??'-'} - ${widget.model.endDate??"-"}",fontSize: 11,color: AppColor.greyLight,fontWeight: FontWeight.w500,),
              SizedBox(width: 5,),
              AppText(text: "${widget.model.countDays}Days",fontSize: 11,color: AppColor.greyLight,fontWeight: FontWeight.w500,),
            ],
          ),
          InkWell(
              onTap: () { 
                setState(() {
                  showMore=!showMore;
                });
              },
              child: AppText(text: widget.model.reason??"-",maxLines: showMore==true?null:3,fontSize: 11,color: AppColor.grey,fontWeight: FontWeight.w500,textAlign: TextAlign.justify,overflow: showMore==true?null: TextOverflow.ellipsis,)),
        ],
      ),
    );
  }
}

import 'package:college_management/features/admin/faculty_workload/model/workload_card_model.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';

class AnimatedTeacherCardWidget extends StatefulWidget {
  const AnimatedTeacherCardWidget({super.key,required this.index,required this.model});
final int index;
 final WorkloadCardModel model;

  @override
  State<AnimatedTeacherCardWidget> createState() => _AnimatedTeacherCardWidgetState();
}

class _AnimatedTeacherCardWidgetState extends State<AnimatedTeacherCardWidget> {

  bool showFull=false;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 400 + (widget.index * 100)),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: InkWell(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          setState(() {
            showFull=!showFull;
          });
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 15),
          padding: EdgeInsets.all(15),
          decoration: AppColor.containerNeon,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 🔷 NAME + HOURS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: widget.model.teacherName,
                        fontWeight: FontWeight.w600,
                      ),
                      AppText(
                        text: widget.model.designation,
                        fontSize: 11,
                        color: AppColor.grey,
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColor.grey.withOpacity(.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: AppText(
                      text: "${widget.model.completedCr}/${widget.model.targetCH}h",
                      fontWeight: FontWeight.w600,
                      color:widget.model.completedCr>widget.model.targetCH?AppColor.red.withOpacity(.8):AppColor.white ,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 3,vertical: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1,color: AppColor.green),
                      color: AppColor.green.withOpacity(.2),
                    ),
                    child: AppText(
                      text: widget.model.teacherType,
                      fontWeight: FontWeight.w500,
                      color: AppColor.green,
                      fontSize: 10,
                    ),
                  ),
                  AppText(
                    text:widget.model.creditHourRemaining<0? "${widget.model.completedCr-widget.model.targetCH} CH over":"${widget.model.creditHourRemaining} CH remaining",
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    color:widget.model.creditHourRemaining<0?AppColor.red: AppColor.green,
                  ),
                ],
              ),

              SizedBox(height: 5),
              AppText(text: "Depts. ${widget.model.teacherWorkloadModel.departments.map((e) => e.name,).join(", ")}",fontSize: 12,color: AppColor.white.withOpacity(.7),fontWeight: FontWeight.w500,),

              SizedBox(height: 15),

              /// 🔷 ENGAGEMENT BOX
              if(showFull)
              if(widget.model.courseInfoList.isNotEmpty)
                ...[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal:5,vertical: 10),
                    decoration: AppColor.containerDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: "Allocated courses",
                          fontSize: 10,
                          color: AppColor.grey,
                        ),

                        ...List.generate(widget.model.courseInfoList.length,(index) => Container(
                          margin: EdgeInsets.only(top: 4),
                          padding: EdgeInsets.symmetric(vertical:5,horizontal: 7),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColor.bgPrimary
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(text: widget.model.courseInfoList[index].courseTitle??""),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(text: widget.model.courseInfoList[index].courseCode??""),
                                  AppText(text: "${widget.model.courseInfoList[index].creditHours} CR"),
                                ],
                              ),
                            ],
                          ),
                        ), )
                      ],
                    ),
                  ),

                  SizedBox(height: 10),],

              /// 🔷 PROGRESS BAR
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: "Weekly Capacity Usage",
                    fontSize: 10,
                    color: AppColor.grey,
                  ),
                  SizedBox(height: 5),
                  LinearProgressIndicator(
                    value: widget.model.progressFraction>1?1:widget.model.progressFraction,
                    minHeight: 6,
                    color: widget.model.progressFraction>1?AppColor.red:AppColor.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        text: "${(widget.model.progressFraction*100).toInt()}% of ${widget.model.targetCH} CH target",
                        fontSize: 10,
                        color: AppColor.grey,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


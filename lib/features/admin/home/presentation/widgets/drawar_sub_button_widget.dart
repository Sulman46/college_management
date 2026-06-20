// ignore_for_file: must_be_immutable

import 'package:college_management/core/models/admin_drawer_button_model.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/media_query.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';


class DrawarSubButtonWidget extends StatefulWidget {
  DrawarSubButtonWidget({super.key,required this.model,});

  SubDrawerButtonModel model;

  @override
  State<DrawarSubButtonWidget> createState() => _DrawarSubButtonWidgetState();
}

class _DrawarSubButtonWidgetState extends State<DrawarSubButtonWidget> {

  bool _isTapped = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isTapped = true);
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isTapped = false);
    if(widget.model.onTap!=null){
      widget.model.onTap!.call();
    }
  }

  void _handleTapCancel() {
    setState(() => _isTapped = false);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 17),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(width: 2,color:_isTapped?AppColor.primary: AppColor.secondaryColor)),
        gradient: _isTapped
            ? AppColor.drawerGradient
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            splashColor: AppColor.transparent,
            focusColor: AppColor.transparent,
            hoverColor: AppColor.transparent,
            highlightColor: AppColor.transparent,
            onTapDown: _handleTapDown,
            onTapUp: _handleTapUp,
            onTapCancel: _handleTapCancel,
            child: Container(
              alignment: Alignment.center,
              width: mdWidth(context),
              padding: const EdgeInsets.symmetric(vertical: 13,horizontal: 10),
              decoration: BoxDecoration(
                  color:_isTapped?AppColor.primary.withOpacity(.3): AppColor.bgPrimary.withOpacity(.7),
                  // gradient:_isTapped?  LinearGradient(
                  //     begin: Alignment.bottomCenter,
                  //     end: Alignment.topCenter,
                  //     colors: [
                  //       AppColor.white.withOpacity(.5),
                  //   AppColor.primary.withOpacity(.3),
                  // ]):LinearGradient(colors: [AppColor.white,AppColor.white,]),
                  border:_isTapped? Border(bottom:BorderSide(width: 1,color: AppColor.primary.withOpacity(.4)),):Border()
              ),
              child: Padding(
                padding: const EdgeInsets.only(left:3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(widget.model.icon,color: _isTapped?AppColor.white:AppColor.white.withOpacity(.7),size: 15,),
                    SizedBox(width: 10,),
                    Expanded(child: AppText(text: "${widget.model.title}",fontSize: 12,color:_isTapped?AppColor.white:AppColor.white.withOpacity(.7),)),
                    Icon(Icons.navigate_next_rounded,size: 20,color: _isTapped?AppColor.white:AppColor.white.withOpacity(.7),),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

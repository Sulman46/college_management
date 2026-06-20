// ignore_for_file: must_be_immutable

import 'package:college_management/core/models/admin_drawer_button_model.dart';
import 'package:college_management/features/admin/home/presentation/widgets/drawar_sub_button_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/media_query.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';


class DrawerButtonWidget extends StatefulWidget {
   DrawerButtonWidget({super.key,required this.model,this.title,});

String? title;
   AdminDrawerButtonModel model;

  @override
  State<DrawerButtonWidget> createState() => _DrawerButtonWidgetState();
}

class _DrawerButtonWidgetState extends State<DrawerButtonWidget> {

  bool _isTapped = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isTapped = true);
  }

  bool showSublist=false;
  void _handleTapUp(TapUpDetails details) {
    if(widget.model.subList!=null){
      setState((){
        showSublist=!showSublist;
        _isTapped = false;
      });

    }else{
      setState(() => _isTapped = false);
      widget.model.onTap!.call();
    }
  }

  void _handleTapCancel() {
    setState(() => _isTapped = false);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height:widget.title!=null? 3:0,),
        widget.title!=null? Container(
            margin: EdgeInsets.only(left: 5),
            child: AppText(text: widget.title??"",fontSize: 12,color: AppColor.secondaryColor.withOpacity(.8),)):SizedBox(),
        SizedBox(height: widget.title!=null? 3:0,),
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
              color:_isTapped?null:AppColor.bgPrimary,
                gradient: _isTapped
                    ?
                    AppColor.drawerGradient: null,
              border:_isTapped? Border(left:BorderSide(width: 2,color: AppColor.primary),):Border()
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(widget.model.icon,color: _isTapped||showSublist?showSublist?AppColor.secondaryColor:AppColor.white:AppColor.white.withOpacity(.7),size: 15,),
                SizedBox(width: 10,),
                Expanded(child: AppText(text: "${widget.model.title}",fontSize: 12,color:showSublist||_isTapped?showSublist?AppColor.secondaryColor:AppColor.white:AppColor.white.withOpacity(.7),)),
                Icon(showSublist? Icons.keyboard_arrow_down:Icons.navigate_next_rounded,size: 20,color: showSublist||_isTapped?showSublist?AppColor.secondaryColor:AppColor.white:AppColor.white.withOpacity(.7),),
              ],
            ),
          ),
        ),
        if(showSublist && widget.model.subList!=null)
        Column(
          children: [
            ...List.generate(widget.model.subList!.length, (index) {
              return DrawarSubButtonWidget(model: widget.model.subList![index]);
            },)
          ],
        ),
      ],
    );
  }
}

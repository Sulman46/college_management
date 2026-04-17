// ignore_for_file: must_be_immutable

import 'package:college_management/core/constants/app_text_style.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CustomDescriptionTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? title;
  final String subTitle;
  EdgeInsetsGeometry? contentPadding;
  bool? isNeedLabelText;
  final String? prefixIcon;
  final String? sufixIcon;
  bool isBorderOnTap;
  TextInputAction? textInputAction;
  Widget? suffix;
  final int? minLines;
  final int? maxLines;
  final bool? isObSecure;
  bool? readOnly;
  VoidCallback? onTap;
  Color? borderColor;
  Color? bgColor;
  final String? Function(String?)? validator;
  double? borderRadius;
  void Function(String)? onChanged;
  bool? isError;
  double? suffixSize;
  double? borderSize;
  TextInputType? keyboardType;
  double? hintFontSize;
  final VoidCallback? onSuffixTap;
  CustomDescriptionTextField({
    super.key,
    this.textInputAction,
    required this.controller,
    this.onChanged,
    this.title,    this.isBorderOnTap=false,

    this.borderColor,
    this.contentPadding,
    this.minLines,
    this.keyboardType,
    this.hintFontSize,
    this.isNeedLabelText,
    this.suffixSize,
    this.readOnly=false,
    this.isError=false,
    this.onTap,
    this.bgColor,
    this.borderRadius,
    required this.subTitle,
    this.prefixIcon,
    this.sufixIcon,
    this.maxLines,
    this.isObSecure,
    this.suffix,
    this.borderSize,
    this.validator,
    this.onSuffixTap,
  });

  @override
  CustomDescriptionTextFieldState createState() => CustomDescriptionTextFieldState();
}

class CustomDescriptionTextFieldState extends State<CustomDescriptionTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(widget.title!=null)
          ...[
            AppText(
              text: widget.title??"",
              fontSize: 12,
              color: AppColor.grey,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 6),],
        TextFormField(
          onChanged: widget.onChanged??(val){},
          scrollPadding: EdgeInsets.zero,
          focusNode: _focusNode,
          textAlignVertical: TextAlignVertical.center,
          cursorColor: AppColor.primary,
          readOnly: widget.readOnly??false,
          onTap: widget.onTap,
          controller: widget.controller,
          obscureText: widget.isObSecure ?? false,
          validator: widget.validator,
          minLines: widget.minLines??1,
          maxLines: widget.maxLines ?? null,
          decoration: InputDecoration(
            contentPadding: widget.contentPadding??EdgeInsets.symmetric(horizontal: 5,vertical: 8),
            isDense: false,
            fillColor:widget.bgColor??AppColor.primary.withOpacity(.1),
            filled: true,floatingLabelAlignment:FloatingLabelAlignment.start ,floatingLabelBehavior: FloatingLabelBehavior.auto,
            // labelText:widget.isNeedLabelText==false?null:widget.subTitle,
            labelStyle: AppTextStyle.hintTextStyle(),
            // label:widget.readOnly==true? null: AppText(text: widget.subTitle,textAlign: TextAlign.left,fontWeight: FontWeight.w500,fontSize: widget.hintFontSize??16,color: AppColor.grey,fontFamily: 'nm'),
            hintText:widget.readOnly==true? widget.prefixIcon == null
                ? '\t\t${widget.subTitle}'
                : widget.subTitle:widget.subTitle,
            hintStyle: AppTextStyle.hintTextStyle(fontSize:widget.hintFontSize ),

            error:widget.isError==true? SizedBox():null,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
              borderSide:  BorderSide(color: widget.borderColor??AppColor.primary,width:widget.borderSize?? .5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
              borderSide:  BorderSide(color:widget.isBorderOnTap==true? AppColor.transparent:widget.borderColor??AppColor.primary.withOpacity(.5),width:widget.borderSize?? .5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color:widget.borderColor?? AppColor.primary,width: widget.borderSize??.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color:AppColor.red),
            ),
            suffix: widget.suffix,
          ),
          keyboardType:widget.keyboardType?? TextInputType.text,
          style: AppTextStyle.fieldTextStyle(),
          textInputAction: widget.textInputAction ?? TextInputAction.newline,
        ),
      ],
    );
  }
}

// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:college_management/core/constants/app_text_style.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/widgets/app_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? title;
  final String subTitle;
  final String? prefixIcon;
  void Function(String)? onChanged;
  final String? sufixIcon;
  TextInputAction? textInputAction;
  Widget? suffix;
  final int? maxLines;
  final bool? isObSecure;
  bool? readOnly;
  bool? isHintText;
  VoidCallback? onTap;
  Color? bgColor;
  final String? Function(String?)? validator;
  double? borderRadius;
  double? suffixSize;
  double? hintFontSize;
  Color? borderColor;
  double? borderSize;
  Color? suffixIconColor;
  bool? isError;
  final VoidCallback? onSuffixTap;
  bool? isSuffixCircle;
  EdgeInsetsGeometry? contentPadding;
  bool? isNeedLabelText;
  TextStyle? hintTextStyle;
  TextInputType? keyboardType;
  List<TextInputFormatter>? inputFormatters;
  bool? isBorderOnTap;
  CustomTextFormField({
    super.key,
    this.textInputAction,
    this.isError=false,
    this.isBorderOnTap=false,
    this.contentPadding,
    this.keyboardType,
    this.isNeedLabelText,
    this.isHintText=false,
    this.borderSize,
    this.borderColor,
    this.hintTextStyle,
    this.onChanged,
    this.suffixIconColor,
    this.inputFormatters,
    this.isSuffixCircle,
    required this.controller,
    this.title,
    this.hintFontSize,
    this.suffixSize,
    this.readOnly=false,
    this.onTap,
    this.bgColor,
    this.borderRadius,
    required this.subTitle,
    this.prefixIcon,
    this.sufixIcon,
    this.maxLines,
    this.isObSecure,
    this.suffix,
    this.validator,
    this.onSuffixTap,
  });

  @override
  CustomTextFormFieldState createState() => CustomTextFormFieldState();
}

class CustomTextFormFieldState extends State<CustomTextFormField> {
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
          scrollPadding: EdgeInsets.zero,
          focusNode: _focusNode,
          textAlignVertical: TextAlignVertical.center,
          cursorColor: AppColor.primary,
          readOnly: widget.readOnly??false,
          onTap: widget.onTap,
          controller: widget.controller,
          obscureText: widget.isObSecure ?? false,
          validator: widget.validator,
          maxLines: widget.maxLines ?? 1,
            inputFormatters:widget.inputFormatters,
          decoration: InputDecoration(
            contentPadding: widget.contentPadding??EdgeInsets.symmetric(horizontal: 5,vertical: 8),
            isDense: true,
            fillColor:widget.bgColor??AppColor.primary.withOpacity(.1),
            filled: true,
            labelText:widget.isHintText==true?null:widget.isNeedLabelText==false?null:widget.subTitle,
            // labelText:widget.isNeedLabelText==false?null:widget.readOnly==true? null:widget.subTitle,
            labelStyle: AppTextStyle.hintTextStyle(),
            hintText:widget.isHintText==false?"":widget.subTitle,
            // widget.readOnly==true? widget.prefixIcon == null
            //     ? '\t\t${widget.subTitle}'
            //     : widget.subTitle:widget.isNeedLabelText==false?widget.subTitle:widget.subTitle,
            hintStyle:widget.hintTextStyle?? AppTextStyle.hintTextStyle(fontSize:widget.hintFontSize ),
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          widget.prefixIcon!,
                          width: 18,
                          height: 18,
                          colorFilter: ColorFilter.mode(
                            _focusNode.hasFocus
                                ? AppColor.primary
                                :AppColor.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                  )
                : null,
            suffixIcon: widget.sufixIcon != null
                ? GestureDetector(
                    onTap: widget.onSuffixTap,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical:widget.isSuffixCircle==true? 10:0),
                      padding: const EdgeInsets.symmetric(horizontal:10.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration:widget.isSuffixCircle==true? BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.fieldYellowBorder
                        ):BoxDecoration(),
                        child: SvgPicture.asset(
                          widget.sufixIcon!,
                          width:widget.suffixSize==null?widget.isSuffixCircle==true? 12:18:widget.suffixSize,
                          height: widget.suffixSize==null?widget.isSuffixCircle==true? 12:18:widget.suffixSize,
                          colorFilter: ColorFilter.mode(
                            _focusNode.hasFocus
                                ?widget.suffixIconColor?? AppColor.grey
                                :widget.suffixIconColor?? AppColor.grey,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  )
                : null,
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
            error:widget.isError==true? SizedBox():null,
            suffix: widget.suffix,
          ),
          onChanged: widget.onChanged??(val){},
          keyboardType: widget.keyboardType??TextInputType.text,
          style: AppTextStyle.fieldTextStyle(),
          textInputAction: widget.textInputAction ?? TextInputAction.next,
        ),
      ],
    );
  }
}

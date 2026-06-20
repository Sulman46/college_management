import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/constants/constant_data.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/announcements/models/announcement_model.dart';
import 'package:college_management/features/admin/announcements/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/semesters/presentation/page/add_semester_screen.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/custom_description_text_field.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:college_management/widgets/custom_text_form.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../widgets/custom_button.dart';

class AddAnnouncementScreen extends StatefulWidget {
  AddAnnouncementScreen({super.key, this.announcementModel});
  AnnouncementModel? announcementModel;
  @override
  State<AddAnnouncementScreen> createState() => _AddAnnouncementScreenState();
}

class _AddAnnouncementScreenState extends State<AddAnnouncementScreen> {
  var _announcementCubit = DiContainer().sl<AnnouncementsCubit>();

  @override
  initState(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(widget.announcementModel!=null){
        titleController.text=widget.announcementModel?.title??"";
        postedByController.text=widget.announcementModel?.postedBy??"";
        descriptionController.text=widget.announcementModel?.content??"";
        feeInfoController.text=widget.announcementModel?.feeInfo??"";
        _announcementCubit.getAnnouncementModel(widget.announcementModel!);
      }else{
        _announcementCubit.getAnnouncementModel(AnnouncementModel());

      }
    },);
    super.initState();
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController postedByController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController feeInfoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder(
        bloc: _announcementCubit,
        builder: (context, stetabka) {
          return Column(
            children: [
              /// 🔹 TOP BAR
              CustomTopBar(text:"Announcement"),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenPaddingHori,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20),

                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            border: Border.all(
                              width: 1,
                              color: AppColor.grey.withOpacity(.6),
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: AppColor.shadowBlack,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppText(
                                text:widget.announcementModel!=null? "Update Announcement":"Create Announcement",
                                fontSize: 16,
                                color: AppColor.primary,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(height: 5),
                              AppText(
                                text:
                                    "${widget.announcementModel!=null?"Update":"Add a new"}  announcement to notify students and staff with important updates",
                                textAlign: TextAlign.center,
                                fontSize: 12,
                                color: AppColor.grey,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(height: 10),
                              CustomTextFormField(
                                controller: titleController,
                                subTitle: "Title..",
                                isHintText: true,
                                title: "Title",
                              ),
                              SizedBox(height: 10),
                              CustomPopMenuButton(
                                menus: ConstantData.announcementCategoryList,
                                onSelected: (p0) {
                                  _announcementCubit.getAnnouncementModel(
                                    _announcementCubit.addAnnouncementModel
                                        .copyWith(
                                          category: ConstantData
                                              .announcementCategoryList[p0],
                                        ),
                                  );
                                },
                                widget: DropDownFieldWidget(
                                  text:_announcementCubit.addAnnouncementModel.category?? "Select..",
                                  isFilled: false,
                                ),
                                title: "Category",
                              ),
                              SizedBox(height: 10),
                              CustomPopMenuButton(
                                menus: ConstantData.announcementPriorityList,
                                onSelected: (p0) {
                                  _announcementCubit.getAnnouncementModel(
                                    _announcementCubit.addAnnouncementModel
                                        .copyWith(
                                          priority: ConstantData
                                              .announcementPriorityList[p0],
                                        ),
                                  );
                                },
                                widget: DropDownFieldWidget(
                                  text:_announcementCubit.addAnnouncementModel.priority?? "Select..",
                                  isFilled: false,
                                ),
                                title: "Priority",
                              ),

                              SizedBox(height: 10),
                              CustomDescriptionTextField(
                                title: "Description",
                                maxLines: 6,
                                minLines: 3,
                                textInputAction: TextInputAction.newline,
                                keyboardType: TextInputType.multiline,
                                controller: descriptionController,
                                subTitle: "Description",
                              ),
                              SizedBox(height: 10),

                              CustomTextFormField(
                                isHintText: true,
                                controller: feeInfoController,
                                subTitle: "info..",
                                title: "Fee Info (Optional)",
                              ),

                              SizedBox(height: 10),

                              CustomTextFormField(
                                controller: postedByController,
                                isHintText: true,
                                subTitle: "Posted By..",
                                title: "Posted By",
                              ),
                              SizedBox(height: 10),
                              CustomElevatedButton(
                                onPressed: () async {
                                  if(_announcementCubit
                                      .addAnnouncementModel
                                      .priority==null ||  _announcementCubit
                                      .addAnnouncementModel
                                      .category==null || titleController.text.isEmpty ||
                                      descriptionController.text.isEmpty||
                                      postedByController.text.isEmpty){
                                    showMessage("Please fill all required fields");
                                    return;
                                  }

                                  if(widget.announcementModel!=null){
                                    AnnouncementModel value = AnnouncementModel(

                                      priority: _announcementCubit
                                          .addAnnouncementModel
                                          .priority,
                                      category: _announcementCubit
                                          .addAnnouncementModel
                                          .category,
                                      title: titleController.text,
                                      content: descriptionController.text,
                                      feeInfo: feeInfoController.text,
                                      postedBy: postedByController.text,
                                      isArchived: false,
                                      id: widget.announcementModel?.id ??"",
                                      attachment: widget.announcementModel?.attachment ??"",
                                      date: widget.announcementModel?.date ??"",
                                    );
                                    var response = await _announcementCubit.update(
                                      value,
                                    );
                                    if (response) {
                                      context.pop();
                                    }
                                  }else{


                                    AnnouncementModel value = AnnouncementModel(
                                      priority: _announcementCubit
                                          .addAnnouncementModel
                                          .priority,
                                      category: _announcementCubit
                                          .addAnnouncementModel
                                          .category,
                                      title: titleController.text,
                                      content: descriptionController.text,
                                      feeInfo: feeInfoController.text,
                                      postedBy: postedByController.text,
                                      isArchived: false,
                                    );
                                    var response = await _announcementCubit.post(
                                      value,
                                    );
                                    if (response) {
                                      context.pop();
                                    }
                                  }
                                },
                                text: "Submit",
                                width: mdWidth(context) * .6,
                              ),
                            ],
                          ),
                        ),
                        SafeArea(top: false, child: SizedBox(height: 30)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

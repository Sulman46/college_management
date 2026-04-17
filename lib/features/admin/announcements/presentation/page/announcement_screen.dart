import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/announcements/presentation/widgets/announcement_widget.dart';
import 'package:college_management/features/admin/announcements/presentation/widgets/filter_button_widget.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:college_management/widgets/custom_top_bar.dart';

import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text_form.dart';
import 'add_announcement_screen.dart';


class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  TextEditingController searchController = TextEditingController();



  double       top=mdHeight(navigatorKey.currentContext!)*.9;
  double left=mdWidth(navigatorKey.currentContext!)*.65;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            children: [
              /// 🔹 TOP BAR
              CustomTopBar(text: "Announcements"),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal:screenPaddingHori),
                    child: Column(
                      children: [
                        SizedBox(height: 10,),

                        /// 🔹 SEARCH
                        CustomTextFormField(
                          controller: searchController,
                          subTitle: "Search...",
                          isHintText: true,
                          onChanged: (p0) {},
                          borderSize: 1,
                          contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                        ),

                        SizedBox(height: 15,),

                        Row(
                          children: [
                            CustomPopMenuButton(menus: [
                              'Live Feed (10)','Archives (0)'
                            ],
                              offset: Offset(0, 25),
                              widget: Container(
                              padding: EdgeInsets.symmetric(horizontal: 9,vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(width: .5,color: AppColor.primary),
                                  color: AppColor.primary.withOpacity(.2)
                              ),
                              child: Icon(Icons.filter_list,size: 16,color: AppColor.primary,),
                            ),),
                            SizedBox(width: 5,),
                            Container(height: 23,width: 2,color: AppColor.primary,),
                            SizedBox(width: 5,),
                            FilterButtonWidget(text: "All", isSelected: true),
                            SizedBox(width: 5,),
                            FilterButtonWidget(text: "Urgent", isSelected: false),SizedBox(width: 5,),
                            FilterButtonWidget(text: "Sports", isSelected: false),SizedBox(width: 5,),
                          ],
                        ),

                        ...List.generate(5, (index) => AnnouncementWidget(),),

                        SafeArea(
                            top: false,
                            child: SizedBox(height: 30,)),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 100),
            top: top,
            left: left,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  top += details.delta.dy;
                  left += details.delta.dx;
                });
              },
              child: CustomElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddAnnouncementScreen(),));
                },
                text: "Add New",
                fontSize: 15,
                width: 110,
                height: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
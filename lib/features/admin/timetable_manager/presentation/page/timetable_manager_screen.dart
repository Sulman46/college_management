import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/timetable_manager/presentation/widgets/add_sheet.dart';
import 'package:college_management/features/admin/timetable_manager/presentation/widgets/sliver_header_filter_buttons.dart';
import 'package:college_management/features/admin/timetable_manager/presentation/widgets/time_table_sheet_widget.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/custom_animated_dialog.dart';
import 'package:flutter/material.dart';

class TimetableManagerScreen extends StatefulWidget {
  const TimetableManagerScreen({super.key});

  @override
  State<TimetableManagerScreen> createState() => _TimetableManagerScreenState();
}

class _TimetableManagerScreenState extends State<TimetableManagerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,

            pinned: true,
            backgroundColor: AppColor.primary,
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_outlined,size: 25,color: AppColor.white,)),
            // title:,
            centerTitle: true,
            title:  AppText(text: "Timetable Dashboard",fontSize: 13,color: AppColor.white,),
            actionsPadding: EdgeInsets.only(right: screenPaddingHori),
            actions: [
              InkWell(
                  onTap: () {
                    showDialog(context: context, builder: (context) => CustomAnimatedDialog(child: AddSheet()),);
                  },
                  child: Container(
                    padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 1,color: AppColor.white)
                      ),
                      child: Icon(Icons.add,size: 20,color: AppColor.white,))),
            ],
              
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20,),),
          SliverPersistentHeader(delegate: SliverHeaderFilterButtons(),pinned: true,),

          SliverToBoxAdapter(child: Column(
            children: [
              SizedBox(height: 10,),
              ...List.generate(10, (index) => TimeTableSheetWidget(),)
            ],
          ),)
        ],
      ),
    );
  }
}

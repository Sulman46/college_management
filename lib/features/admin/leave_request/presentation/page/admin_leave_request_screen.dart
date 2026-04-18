import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/features/admin/leave_request/presentation/widgets/leave_item.dart';
import 'package:college_management/features/admin/leave_request/presentation/widgets/leave_tab_widget.dart';
import 'package:flutter/material.dart';
import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';


class AdminLeaveRequestScreen extends StatefulWidget {
  const AdminLeaveRequestScreen({super.key});

  @override
  State<AdminLeaveRequestScreen> createState() =>
      _AdminLeaveRequestScreenState();
}

class _AdminLeaveRequestScreenState extends State<AdminLeaveRequestScreen> {

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [

          /// 🔷 HEADER (KEEP SAME)
          /// 🔷 ANIMATED HEADER
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            backgroundColor: AppColor.primary,
            elevation: 0,

            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColor.white),
              onPressed: () => Navigator.pop(context),
            ),

            /// 🔷 COLLAPSED TITLE (WHEN SCROLLED UP)
            title: AppText(
              text: "Leave Requests",
              color: AppColor.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            centerTitle: true,


            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Container(
                padding: EdgeInsets.symmetric(horizontal: screenPaddingHori),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColor.primary,
                      AppColor.primary.withOpacity(.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),

                child: SafeArea(
                  bottom: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SafeArea(
                          bottom: false,
                          child: SizedBox(height: 60)),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          boxShadow: AppColor.blackShadow,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(width: 1,color: AppColor.primary)
                        ),
                        child:Row(
                          children: [
                            Expanded(child: LeaveTabWidget(isSelected: true, text: "Teacher",
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5)),
                            )),
                            SizedBox(width: 2,),
                            Expanded(child: LeaveTabWidget(isSelected: false, text: "HOD View")),
                            SizedBox(width: 2,),
                            Expanded(child: LeaveTabWidget(isSelected: false, text: "Coordinator",
                              borderRadius: BorderRadius.only(topRight: Radius.circular(5),bottomRight: Radius.circular(5)),
                            )),
                          ],
                        )
                      ),

                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// 🔷 STATS ONLY (NO COLUMN)
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenPaddingHori),
              child: Column(
                children: [
                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StatCard(title: "Pending", value: "0", color: Colors.blue),
                      StatCard(title: "Approved", value: "0", color: Colors.green),
                      StatCard(title: "Reject", value: "0", color: Colors.red),
                    ],
                  ),


                  SizedBox(height: 5),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
              pinned: true,
              delegate: _RecentHeaderDelegate()),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return Padding(
                  padding:  EdgeInsets.symmetric(horizontal: screenPaddingHori),
                  child: LeaveItem(),
                );
              },
              childCount: 14,
            ),
          ),

          /// 🔷 BOTTOM SPACE
          SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
        ],
      ),
    );
  }
}


class StatCard extends StatelessWidget {
  StatCard({super.key,required this.title,required this.color,required this.value});
  String title; String value; Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: mdWidth(context) * .28,
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        children: [
          AppText(
            text: title,
            fontSize: 10,
            color: AppColor.grey,
          ),
          SizedBox(height: 5),
          AppText(
            text: value,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ],
      ),
    );
  }
}



class _RecentHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 40;

  @override
  double get maxExtent => 40;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColor.bgPrimary, // IMPORTANT: background color
      padding: EdgeInsets.symmetric(horizontal: screenPaddingHori),
      alignment: Alignment.centerLeft,
      child: AppText(
        text: "Recent Requests",
        fontSize: 12,
        color: AppColor.black,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}


import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/constants/constant_data.dart';
import 'package:college_management/features/admin/leave_request/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/leave_request/presentation/widgets/leave_item.dart';
import 'package:college_management/features/admin/leave_request/presentation/widgets/leave_tab_widget.dart';
import 'package:college_management/widgets/data_not_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

final _leaveCubit=DiContainer().sl<LeaveRequestCubit>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _leaveCubit.get();
    },);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder(
        bloc: _leaveCubit,
        builder: (context,statevj) {
          return CustomScrollView(
            slivers: [

              /// 🔷 HEADER (KEEP SAME)
              /// 🔷 ANIMATED HEADER
              SliverAppBar(
                expandedHeight: 140,
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
                              child: SizedBox(height: 50)),
                          // Container(
                          //   padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                          //   decoration: BoxDecoration(
                          //     color: AppColor.white,
                          //     boxShadow: AppColor.shadowBlack,
                          //     borderRadius: BorderRadius.circular(50),
                          //     border: Border.all(width: 1,color: AppColor.primary)
                          //   ),
                          //   child:Row(
                          //     children: [
                          //       Expanded(child: LeaveTabWidget(isSelected: true, text: "Teacher",
                          //         borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5)),
                          //       )),
                          //       SizedBox(width: 2,),
                          //       Expanded(child: LeaveTabWidget(isSelected: false, text: "HOD View")),
                          //       SizedBox(width: 2,),
                          //       Expanded(child: LeaveTabWidget(isSelected: false, text: "Coordinator",
                          //         borderRadius: BorderRadius.only(topRight: Radius.circular(5),bottomRight: Radius.circular(5)),
                          //       )),
                          //     ],
                          //   )
                          // ),
                          //
                          // SizedBox(height: 15),

                          Padding(
                                padding: EdgeInsets.symmetric(horizontal: screenPaddingHori),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: StatCard(title: "Pending", value: "${_leaveCubit.dataList.where((element) => element.status!.toLowerCase()=="pending",).length}", color: AppColor.blue)),
                                Expanded(child: StatCard(title: "Approved", value: "${_leaveCubit.dataList.where((element) => element.status!.toLowerCase()=="approved",).length}", color: AppColor.green)),
                                Expanded(child: StatCard(title: "Reject", value: "${_leaveCubit.dataList.where((element) => element.status!.toLowerCase()=="rejected",).length}", color: AppColor.red)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // /// 🔷 STATS ONLY (NO COLUMN)
              // SliverToBoxAdapter(
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(horizontal: screenPaddingHori),
              //     child: Column(
              //       children: [
              //         SizedBox(height: 20),
              //
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             StatCard(title: "Pending", value: "${_leaveCubit.dataList.where((element) => element.status!.toLowerCase()=="pending",).length}", color: AppColor.blue),
              //             StatCard(title: "Approved", value: "${_leaveCubit.dataList.where((element) => element.status!.toLowerCase()=="approved",).length}", color: AppColor.green),
              //             StatCard(title: "Reject", value: "${_leaveCubit.dataList.where((element) => element.status!.toLowerCase()=="rejected",).length}", color: AppColor.red),
              //           ],
              //         ),
              //
              //         SizedBox(height: 5),
              //       ],
              //     ),
              //   ),
              // ),

              SliverPersistentHeader(
                  pinned: true,
                  delegate: _RecentHeaderDelegate()),
              if( _leaveCubit.filterList.isNotEmpty)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: _leaveCubit.filterList.where((element) => element.status!.toLowerCase().toString().contains(_leaveCubit.selectedCategory.toLowerCase()),).length,
                      (context, index) {
                    return Padding(
                      padding:  EdgeInsets.symmetric(horizontal: screenPaddingHori),
                      child: LeaveItem(model: _leaveCubit.filterList.where((element) => element.status!.toLowerCase().toString().contains(_leaveCubit.selectedCategory.toLowerCase()),).toList()[index],),
                    );
                  },
                ),
              ),

              /// 🔷 BOTTOM SPACE
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    if( _leaveCubit.filterList.isEmpty)
                      DataNotFoundWidget(onTap: ()async{
                      await  _leaveCubit.get();
                      },),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          );
        }
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
      height: maxExtent,
      color: AppColor.white.withOpacity(.7),
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(horizontal: 16),

      child: BlocBuilder(
        bloc: _leaveCubit,
        builder: (context,statebkskjn) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(4, (index) => InkWell(
                  onTap: () {
                    String val=[ "All","Pending", "Approved", "Rejected"][index].toLowerCase();
                    _leaveCubit.getStatusVal(val=="all"?"":val);
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 5),
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                    decoration:_leaveCubit.selectedCategory==[ "","Pending", "Approved", "Rejected"][index].toLowerCase()?  AppColor.containerNeon:BoxDecoration(
                      color: AppColor.grey.withOpacity(.8), // glass tint
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: AppColor.primary.withOpacity(.5),
                        width: .5,
                      ),
                    ),child: AppText(text: [ "All","Pending", "Approved", "Rejected"][index],fontSize: 12,color: AppColor.white,),),
                )),
              ],
            ),
          );
        }
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}


final _leaveCubit=DiContainer().sl<LeaveRequestCubit>();


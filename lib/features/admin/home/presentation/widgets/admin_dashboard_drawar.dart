import 'package:cached_network_image/cached_network_image.dart';
import 'package:college_management/core/constants/app_assets.dart';
import 'package:college_management/core/models/admin_drawer_button_model.dart';
import 'package:college_management/features/admin/affiliated_university/presentation/page/affiliated_universities_screen.dart';
import 'package:college_management/features/admin/programs/presentation/page/admin_program_screen.dart';
import 'package:college_management/features/admin/university_profile/presentation/page/university_profile_screen.dart';
import 'package:college_management/widgets/custom_image_cache.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/constants/media_query.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../announcements/presentation/page/announcement_screen.dart';
import '../../../course_catalog/presentation/page/course_catalog_admin_screen.dart';
import '../../../course_mapping/presentation/page/course_mapping_screen.dart';
import '../../../departments/presentation/page/admin_department_screen.dart';
import '../../../neural_generator/presentation/page/neural_generator_screen.dart';
import '../../../semesters/presentation/page/semester_admin_screen.dart';
import '../../../teacher_records/presentation/page/teacher_records_admin_screen.dart';
import 'drawer_button_widget.dart';


class AdminDashboardDrawar extends StatefulWidget {
  const AdminDashboardDrawar({super.key});

  @override
  State<AdminDashboardDrawar> createState() => _AdminDashboardDrawarState();
}

class _AdminDashboardDrawarState extends State<AdminDashboardDrawar> {

  @override
  Widget build(BuildContext context) {
    List<AdminDrawerButtonModel> itemsList=[
      AdminDrawerButtonModel(title: "University", icon: Icons.account_balance_outlined,onTap: (){},
          subList: [
            SubDrawerButtonModel(title: "Profile", icon: Icons.manage_accounts,onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UniversityProfileScreen(),));
            },),
            SubDrawerButtonModel(title: "Affiliation", icon: Icons.connect_without_contact_outlined,onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AffiliatedUniversitiesScreen(),));

            },),
            SubDrawerButtonModel(title: "Attendance", icon: Icons.co_present_outlined,onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => AdminDepartmentScreen(),));

            },),
            SubDrawerButtonModel(title: "Setting", icon: Icons.settings),
          ]),
      AdminDrawerButtonModel(title: "Department", icon: Icons.category,onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AdminDepartmentScreen(),));

      }),
      AdminDrawerButtonModel(title: "Programs", icon: Icons.class_,onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AdminProgramScreen(),));

      }),
      AdminDrawerButtonModel(title: "Course Catalog", icon: Icons.menu_book_sharp,onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CourseCatalogAdminScreen(),));

      }),
      AdminDrawerButtonModel(title: "Course Mapping", icon: Icons.map,onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CourseMappingScreen(),));

      }),
      AdminDrawerButtonModel(title: "Semester", icon: Icons.calendar_month,onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => SemesterAdminScreen(),));

      }),
      AdminDrawerButtonModel(title: "Neural Generator", icon: Icons.flash_on_sharp,onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => NeuralGeneratorScreen(),));

      }),
      AdminDrawerButtonModel(title: "Announcements", icon: Icons.announcement,onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AnnouncementScreen(),));

      }),
      AdminDrawerButtonModel(title: "Teachers Record", icon: Icons.person_pin_rounded,onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherRecordsAdminScreen(),));

      }),
      AdminDrawerButtonModel(title: "Logout", icon: Icons.logout,onTap: (){}),
    ];
    return Drawer(
      width: mdWidth(context) * .7,
      // shape: Border(right: BorderSide(color: AppColor.primary.withOpacity(.5),width: 1)),
      backgroundColor: AppColor.bgPrimary,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColor.primary
            ),
            child: Column(
              children: [
                const SafeArea(child: SizedBox(height: 3)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 20,),
                    InkWell(
                      splashColor: AppColor.transparent,
                      hoverColor: AppColor.transparent,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.all(3),
                        child: const Icon(Icons.close, size: 20,color: AppColor.white,),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  splashColor: AppColor.transparent,
                  hoverColor: AppColor.transparent,
                  onTap: () {},
                  child: CustomImageCache(url: AppAssets.profileImage),
                ),

                const SizedBox(height: 10),
                AppText(
                  text: "College Name",
                  fontSize: 15,
                  color: AppColor.white,
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Column(
                    children: List.generate(itemsList.length, (index) {
                      bool isLast = index == itemsList.length - 1;
                      return DrawerButtonWidget(
                        title: index==0?"Main":index==9?"Misc":null,
                        model: itemsList[index],
                      );
                    }),
                  ),
                  SafeArea(
                      top: false,
                      child: SizedBox(height: 20,)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



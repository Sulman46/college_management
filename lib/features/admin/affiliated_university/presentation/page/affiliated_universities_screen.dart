import 'package:college_management/core/constants/app_assets.dart';
import 'package:college_management/features/admin/affiliated_university/presentation/widgets/affiliated_university_widget.dart';
import 'package:college_management/widgets/custom_image_cache.dart';
import 'package:flutter/material.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/custom_text_form.dart';
import 'package:college_management/widgets/custom_top_bar.dart';

import '../../data/models/affiliated_university_model.dart';

class AffiliatedUniversitiesScreen extends StatefulWidget {
  const AffiliatedUniversitiesScreen({super.key});

  @override
  State<AffiliatedUniversitiesScreen> createState() =>
      _AffiliatedUniversitiesScreenState();
}

class _AffiliatedUniversitiesScreenState
    extends State<AffiliatedUniversitiesScreen> {

  TextEditingController searchController = TextEditingController();

  List<CollegeModel> filteredList = [];
  List<CollegeModel> collegeList = [
    CollegeModel(
      name: "ABC College",
      image: AppAssets.profileImage,
      status: "Active",
    ),
    CollegeModel(
      name: "ABC College",
      image: AppAssets.profileImage,
      status: "Active",
    ),
    CollegeModel(
      name: "ABC College",
      image: AppAssets.profileImage,
      status: "Active",
    ),
    CollegeModel(
      name: "ABC College",
      image: AppAssets.profileImage,
      status: "Active",
    ),
    CollegeModel(
      name: "XYZ Institute",
      image: AppAssets.profileImage,
      status: "Inactive",
    ),
    CollegeModel(
      name: "City College",
      image: AppAssets.profileImage,
      status: "Active",
    ),
  ];
  @override
  void initState() {
    filteredList = collegeList;
    super.initState();
  }

  void onSearch(String value) {
    setState(() {
      filteredList = collegeList
          .where((e) =>
          e.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          /// 🔹 TOP BAR
          CustomTopBar(text: "Affiliated Colleges"),

          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  /// 🔹 SEARCH
                  CustomTextFormField(
                    controller: searchController,
                    subTitle: "Search...",
                    isHintText: true,
                    onChanged: onSearch,
                    borderSize: 1,
                    contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                  ),


                  /// 🔹 LIST
                  Expanded(
                    child: filteredList.isEmpty
                        ? Center(
                      child: AppText(
                        text: "No college found",
                        color: AppColor.grey,
                      ),
                    )
                        : ListView.builder(
                      padding: EdgeInsets.only(top: 20),
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        return AffiliatedUniversityWidget(model:filteredList[index]);
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
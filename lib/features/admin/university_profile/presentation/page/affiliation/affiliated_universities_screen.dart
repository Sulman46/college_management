import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/app_assets.dart';
import 'package:college_management/features/Authentication/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/university_profile/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/university_profile/presentation/widgets/widgets/affiliated_university_widget.dart';
import 'package:college_management/widgets/custom_image_cache.dart';
import 'package:college_management/widgets/data_not_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/custom_text_form.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../widgets/custom_button.dart';
import '../../../models/affil/college_model.dart';


class AffiliatedUniversitiesScreen extends StatefulWidget {
  const AffiliatedUniversitiesScreen({super.key});

  @override
  State<AffiliatedUniversitiesScreen> createState() =>
      _AffiliatedUniversitiesScreenState();
}

class _AffiliatedUniversitiesScreenState
    extends State<AffiliatedUniversitiesScreen> {
  var _universityCubit=DiContainer().sl<UniversityProfileCubit>();

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
     await _universityCubit.getUniversitySetup();
    },);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
     resizeToAvoidBottomInset: false,
      body: BlocBuilder(
        bloc: _universityCubit,
        builder: (context,statesbjbkl) {
          return Stack(
            children: [
              Column(
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
                            onChanged: (p0) {
                              _universityCubit.filterData(p0);
                            },
                            borderSize: 1,
                            contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                          ),
              

                          if(_universityCubit.universityModel==null)
                            DataNotFoundWidget(onTap:  ()async {
                              await _universityCubit.getUniversitySetup();
                            })
                            else
                          /// 🔹 LIST
                          Expanded(
                            child:  _universityCubit.affiliationFilterList.isEmpty
                                ? Center(
                              child: AppText(
                                text: "No college found",
                                color: AppColor.grey,
                              ),
                            )
                                : ListView.builder(
                              padding: EdgeInsets.only(top: 20),
                              itemCount: _universityCubit.affiliationFilterList.length,
                              itemBuilder: (context, index) {
                                return AffiliatedUniversityWidget(model: _universityCubit.affiliationFilterList[index]);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              
              AnimatedPositioned(
                duration: Duration(milliseconds: 100),
                top: _universityCubit.top,
                right: _universityCubit.right,
                child: GestureDetector(
                  onPanUpdate: (details) {

                    _universityCubit.getButtonPosition(topVal:details.delta.dy, rightVal: details.delta.dx);
                  },
                  child: CustomElevatedButton(
                    onPressed: () {
                      _universityCubit.getUpdateModel(null);
                      context.push("/Admin-affiliation-create");
                    },
                    text: "Add New",
                    fontSize: 15,
                    width: 110,
                    height: 50,
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}



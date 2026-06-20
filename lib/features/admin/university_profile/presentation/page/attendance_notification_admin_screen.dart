import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/university_profile/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/university_profile/presentation/widgets/attendance_widgets/add_attendance_alert_dialog.dart';
import 'package:college_management/features/admin/university_profile/presentation/widgets/attendance_widgets/attendance_alert_card_widget.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/custom_button.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:college_management/widgets/data_not_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceNotificationAdminScreen extends StatefulWidget {
  const AttendanceNotificationAdminScreen({super.key});

  @override
  State<AttendanceNotificationAdminScreen> createState() =>
      _AttendanceNotificationAdminScreenState();
}

class _AttendanceNotificationAdminScreenState
    extends State<AttendanceNotificationAdminScreen> {
  var _universitySetupCubit = DiContainer().sl<UniversityProfileCubit>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      await _universitySetupCubit.getUniversitySetup();
    },);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        bloc: _universitySetupCubit,
        builder: (context,staevua) {
          return Stack(
            children: [
              Column(
                children: [
                  CustomTopBar(text: "Attendance Escalation"),
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: screenPaddingHori,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20),

                        Align(
                          alignment: AlignmentGeometry.centerLeft,
                          child: AppText(
                            text:
                                "Manage Automated trigger for attendance warnings and terminations.",
                            fontSize: 12,
                            color: AppColor.grey,
                          ),
                        ),
                        SizedBox(height: 15),

                        if(_universitySetupCubit
                            .universityModel!=null&& _universitySetupCubit
                            .universityModel
                            !.attendancePolicyModel!.isNotEmpty)
                        ...List.generate(
                          _universitySetupCubit
                                  .universityModel
                                  ?.attendancePolicyModel
                                  ?.length ??
                              0,
                          (index) => AttendanceAlertCardWidget(
                            model: _universitySetupCubit
                                .universityModel!
                                .attendancePolicyModel![index],
                          ),
                        )
                        else
                          ...[
                            SizedBox(height: 10),
                            AppText(
                            text: "Data not found",
                            color: AppColor.grey,
                          )],
                        SafeArea(top: false, child: SizedBox(height: 20)),
                      ],
                    ),
                  ),
                ],
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 100),
                top: _universitySetupCubit.top,
                right: _universitySetupCubit.right,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    _universitySetupCubit.getButtonPosition(topVal: details.delta.dy, rightVal: details.delta.dx);

                  },
                  child: CustomElevatedButton(
                    onPressed: () {
                      showDialog(context: context, builder: (context) => AddAttendanceAlertDialog(),);
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

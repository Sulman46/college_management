
import 'package:college_management/core/controllers/dio_helper.dart';
import 'package:college_management/widgets/custom_animated_dialog.dart';
import 'package:college_management/widgets/custom_text_form.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../widgets/app_text.dart';
import '../../../widgets/custom_button.dart';
import '../../helper/show_message.dart';
import '../../theme/AppColor.dart';
import '../app_apis.dart';

class ServerConfigDialog {
  ServerConfigDialog._();

  static Future<bool?> show(BuildContext context) async {


    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return CustomAnimatedDialog(child: GetIpDialog());
      },
    );
  }
}


class GetIpDialog extends StatefulWidget {
  const GetIpDialog({super.key});

  @override
  State<GetIpDialog> createState() => _GetIpDialogState();
}

class _GetIpDialogState extends State<GetIpDialog> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async {
      final prefs = await SharedPreferences.getInstance();
      final ip = prefs.getString("server_ip") ?? "10.234.210.161:9500";
      controller.text=ip;
      controller.text=AppApis.baseUrl;
    },);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: AppColor.primary.withOpacity(.12),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.dns_rounded,
            color: AppColor.primary,
            size: 34,
          ),
        ),

        const SizedBox(height: 18),

        AppText(
          text: "Server Configuration",
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),

        const SizedBox(height: 6),

        AppText(
          text:
          "Enter your local server address.\nExample: 192.168.1.105:9500",
          textAlign: TextAlign.center,
          color: Colors.grey,
          fontSize: 13,
        ),

        const SizedBox(height: 24),

        CustomTextFormField(
          controller: controller,
          subTitle: "192.168.1.105:9500",
        ),

        const SizedBox(height: 25),

        Row(
          children: [

            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text("Cancel"),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: CustomElevatedButton(
                text: "Save",
                onPressed: () async {
                  final address = controller.text.trim();

                  if (address.isEmpty) {
                    showMessage("Please enter server address.",
                        isError: true
                    );
                    return;
                  }

                  if (!address.contains(":")) {
                    showMessage(
                        "Please enter address with port.\nExample: 192.168.1.105:9500",
                        isError: true
                    );
                    return;
                  }

                  await AppApis.setBaseUrl(address);

                  DioHelper.refresh();

                  Navigator.pop(context, true);

                  showMessage(
                    "Server updated successfully.",
                  );
                },
              ),
            ),

          ],
        ),
      ],
    );
  }
}

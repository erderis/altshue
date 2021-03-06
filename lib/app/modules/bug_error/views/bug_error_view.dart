import 'package:altshue/app/constants/colors.dart';
import 'package:altshue/app/widgets/button_global.dart';
import 'package:altshue/app/widgets/header_bar.dart';
import 'package:altshue/app/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import '../controllers/bug_error_controller.dart';
import 'components/list_field.dart';

class BugErrorView extends GetView<BugErrorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.white,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Column(
              children: [
                HeaderBar(
                  title: 'Bug Error Report'.tr,
                ),
                SizedBox(height: 20),
                ListField(
                  controller: controller,
                ),
                SizedBox(height: 108),
                SizedBox(
                  width: 186,
                  height: 41,
                  child: Obx(
                    () => ButtonGlobal(
                      onTap: controller.isLoadingButton.value
                          ? () {}
                          : () => controller.report(),
                      radius: 8,
                      fontSize: 14,
                      title: 'REPORT'.tr,
                      child: controller.isLoadingButton.value
                          ? SpinKitThreeBounce(
                              color: Colors.white,
                              size: 20.0,
                            )
                          : null,
                    ),
                  ),
                ),
              ],
            ),
            NavigationBar(
              index: 4,
            )
          ],
        ));
  }
}

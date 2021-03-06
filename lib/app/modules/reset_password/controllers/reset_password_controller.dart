import 'package:altshue/app/modules/reset_password/providers/reset_password_provider.dart';
import 'package:altshue/app/routes/app_pages.dart';
import 'package:altshue/app/utils/ui/dialog_password.dart';
import 'package:altshue/app/utils/ui/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  final TextEditingController? passwordC = TextEditingController();
  final TextEditingController? passwordConfirmC = TextEditingController();

  final isErrorPW = false.obs;
  final isErrorPWC = false.obs;

  final formGlobalKey = GlobalKey<FormState>();

  final isLoadingButton = false.obs;

  final arg = Get.arguments;

  void reset() {
    if (formGlobalKey.currentState!.validate() &&
        !isErrorPW.value &&
        !isErrorPWC.value) {
      if (passwordC!.text == passwordConfirmC!.text) {
        isLoadingButton.value = true;
        Map dataResetPassword = {
          'MemberId': arg['member_id'],
          'password': passwordC!.text,
        };

        ResetPasswordProvider()
            .resetPassword(dataResetPassword: dataResetPassword)
            .then((response) {
          isLoadingButton.value = false;

          if (response.status == 200) {
            //show dialog
            showDialogPW(
                icon: Icons.verified_user,
                onTap: () {
                  Get.offAllNamed(Routes.LOGIN);
                },
                text: "Password changed successfully",
                textButton: 'GO BACK',
                isDismissible: false);
          } else {
            showToasts(text: response.message);
          }
        });
      } else {
        showToasts(text: 'Password tidak sama');
      }
    }
  }

  @override
  void dispose() {
    passwordC!.dispose();
    passwordConfirmC!.dispose();
    super.dispose();
  }
}

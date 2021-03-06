import 'package:altshue/app/constants/colors.dart';
import 'package:altshue/app/constants/asset_path.dart';
import 'package:altshue/app/modules/register/controllers/register_controller.dart';

import 'package:altshue/app/widgets/button_global.dart';
import 'package:altshue/app/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

class FormRegister extends StatelessWidget {
  const FormRegister({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: controller.formGlobalKey,
          child: ListView(
            padding: EdgeInsets.only(
              left: 50.0,
              right: 50,
            ),
            children: [
              SizedBox(
                height: 30,
              ),
              Image.asset(AssetName.shoes, height: 75),
              SizedBox(
                height: 44,
              ),
              Text('REGISTER',
                  style: TextStyle(
                      color: Palette.white,
                      fontSize: 20,
                      fontFamily: AppFontStyle.montserratBold)),
              SizedBox(
                height: 25,
              ),
              Stack(
                children: [
                  SizedBox(
                    height: 48,
                    child: InputField(
                      controller: controller.namaC,
                      hintText: 'Nama Lengkap'.tr,
                      validator: (String? text) {
                        if (text == null || text.isEmpty) {
                          controller.isErrornama.value = true;
                        } else {
                          controller.isErrornama.value = false;
                        }
                        return null;
                      },
                    ),
                  ),
                  Positioned(
                      top: 0,
                      bottom: 5,
                      left: 19,
                      child: Icon(
                        Icons.account_circle,
                        size: 20,
                        color: Palette.darkTan,
                      )),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Obx(
                () => Visibility(
                  visible: controller.isErrornama.value,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Nama Lengkap is required',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontFamily: AppFontStyle.montserratBold)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  SizedBox(
                    height: 48,
                    child: InputField(
                      controller: controller.emailC,
                      hintText: 'Email'.tr,
                      validator: (String? text) {
                        if (text == null || text.isEmpty) {
                          controller.isErrorEmail.value = true;
                        } else {
                          controller.isErrorEmail.value = false;
                        }
                        return null;
                      },
                    ),
                  ),
                  Positioned(
                      top: 0,
                      bottom: 5,
                      left: 19,
                      child: Icon(
                        Icons.email,
                        size: 20,
                        color: Palette.darkTan,
                      )),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Obx(
                () => Visibility(
                  visible: controller.isErrorEmail.value,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Email is Required',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontFamily: AppFontStyle.montserratBold)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  SizedBox(
                    height: 48,
                    child: InputField(
                      controller: controller.notelpC,
                      hintText: 'Nomor Telepon'.tr,
                      validator: (String? text) {
                        if (text == null || text.isEmpty) {
                          controller.isErrorNoTelp.value = true;
                        } else {
                          controller.isErrorNoTelp.value = false;
                        }
                        return null;
                      },
                    ),
                  ),
                  Positioned(
                      top: 0,
                      bottom: 5,
                      left: 19,
                      child: Icon(
                        Icons.local_phone,
                        size: 20,
                        color: Palette.darkTan,
                      )),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Obx(
                () => Visibility(
                  visible: controller.isErrorNoTelp.value,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Nomor Telepon is required',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontFamily: AppFontStyle.montserratBold)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  SizedBox(
                    height: 48,
                    child: InputField(
                      controller: controller.passwordC,
                      obscureText: true,
                      hintText: 'Password'.tr,
                      validator: (String? text) {
                        if (text == null || text.isEmpty) {
                          controller.isErrorPassword.value = true;
                        } else {
                          controller.isErrorPassword.value = false;
                        }
                        return null;
                      },
                    ),
                  ),
                  Positioned(
                      top: 0,
                      bottom: 5,
                      left: 19,
                      child: Icon(
                        Icons.lock,
                        size: 20,
                        color: Palette.darkTan,
                      )),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Obx(
                () => Visibility(
                  visible: controller.isErrorPassword.value,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Password is required',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontFamily: AppFontStyle.montserratBold)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  SizedBox(
                    height: 48,
                    child: InputField(
                      controller: controller.ulangiPasswordC,
                      obscureText: true,
                      hintText: 'Ulangi Password'.tr,
                      validator: (String? text) {
                        if (text == null || text.isEmpty) {
                          controller.isErrorUlangiPassword.value = true;
                        } else {
                          controller.isErrorUlangiPassword.value = false;
                        }
                        return null;
                      },
                    ),
                  ),
                  Positioned(
                      top: 0,
                      bottom: 5,
                      left: 19,
                      child: Icon(
                        Icons.lock,
                        size: 20,
                        color: Palette.darkTan,
                      )),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Obx(
                () => Visibility(
                  visible: controller.isErrorUlangiPassword.value,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Ulangi Password is required',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontFamily: AppFontStyle.montserratBold)),
                  ),
                ),
              ),
              SizedBox(height: 36),
              Obx(
                () => ButtonGlobal(
                  onTap: controller.isLoadingButton.value
                      ? () {}
                      : () => controller.register(),
                  title: 'SUBMIT'.tr,
                  child: controller.isLoadingButton.value
                      ? SpinKitThreeBounce(
                          color: Colors.white,
                          size: 20.0,
                        )
                      : null,
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

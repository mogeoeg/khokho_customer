import 'package:ev/utils/image.strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ev/controller/otp_controller.dart';
import 'package:ev/common/button.dart';
import 'package:ev/utils/colors.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final OtpController controller = Get.find<OtpController>();

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 60,
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border(bottom: BorderSide(color: TColors.primary, width: 2)),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar( elevation: 0,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Image
            Container(
              height: 250,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(TImages.otpImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text(
                    'Verification Code',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "We have sent the 6-digit OTP to your phone",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 30),

                  // Pinput for OTP
                  Pinput(
                    length: 6,
                    controller: controller.hiddenController,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    onChanged: (value) {
                      controller.updateOtpValue(value);
                    },
                    onCompleted: (pin) {
                      controller.submitOtp();
                    },
                    showCursor: true,
                    autofillHints: [AutofillHints.oneTimeCode], // optional for iOS
                    // androidSmsAutofillMethod:
                    //     AndroidSmsAutofillMethod.smsRetrieverApi,
                    // showCursor: true,
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => Text.rich(
                          TextSpan(
                            children:
                                controller.secondsRemaining.value > 0
                                    ? [
                                      const TextSpan(
                                        text: "Resend OTP in  ",
                                        style: TextStyle(color: Colors.grey,  fontWeight: FontWeight.w700),
                                      ),
                                      TextSpan(
                                        text:
                                            "${controller.secondsRemaining.value}s",
                                        style: const TextStyle(
                                          color: TColors.primary,
                                           fontWeight: FontWeight.bold,
                                          
                                        ),
                                      ),
                                    ]
                                    : [
                                      const TextSpan(
                                        text: "Didn't receive OTP?",
                                        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w700),
                                      ),
                                    ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Obx(
                        () => Visibility(
                          visible: controller.secondsRemaining.value == 0,
                          child: TextButton(
                            onPressed:
                                controller.isResending.value
                                    ? null
                                    : controller.resendOtp,
                            child: Text(
                              controller.isResending.value
                                  ? "Sending..."
                                  : "Resend OTP",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                  // Submit button
                  Obx(
                    () => TNavigationButton(
                      buttonTitle: "Verify OTP",
                      isDisabled: controller.isLoading.value,
                      onTap: controller.submitOtp,
                      child:
                          controller.isLoading.value
                              ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                              : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

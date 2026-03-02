// // ignore_for_file: avoid_print

// import 'package:ev/common/button.dart';
// import 'package:ev/controller/profile_creation_controller.dart';
// import 'package:ev/view/auth/address/widgets/address_details_form.dart';
// import 'package:ev/view/auth/auth_widgets_common/auth_header.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AddressDetails extends StatelessWidget {
//   const AddressDetails({super.key});

//   @override
//   Widget build(BuildContext context) {
//     UserController controller = Get.put(UserController());
//     return Scaffold(
//       appBar: AppBar(automaticallyImplyLeading: true),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 14),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TAuthHeader(
//                 title: 'Address Details',
//                 subTitle: 'Provide your company Address details',
//               ),
//               SizedBox(height: 32),
//               AddressDetailsForm(),
//               SizedBox(height: 24),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: SafeArea(
//         bottom: true,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
//           child: TNavigationButton(
//             buttonTitle: "Register",
//             onTap: () => controller.submitProfile(),
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'package:ev/common/button.dart';
import 'package:ev/controller/profile_creation_controller.dart';
import 'package:ev/view/auth/address/widgets/address_details_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressDetails extends StatelessWidget {
  const AddressDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());

    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(automaticallyImplyLeading: true, elevation: 0,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                          'Address Details',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                         'Provide your company address details',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
              const SizedBox(height: 32),
              AddressDetailsForm(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
          child: Obx(() => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : TNavigationButton(
                  buttonTitle: "Register",
                  
                  onTap: () => controller.submitProfile(),
                )),
        ),
      ),
    );
  }
}

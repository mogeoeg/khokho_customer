// ignore_for_file: avoid_print

import 'package:ev/common/body_title.dart';
import 'package:ev/common/t_circular_image.dart';
import 'package:ev/controller/profile_data_controller.dart';
import 'package:ev/helper/routes/navigation.dart';
import 'package:ev/utils/image.strings.dart';
import 'package:ev/view/profile/widgets/profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileUserController controller = Get.find<ProfileUserController>();

    // final controller controller = Get.put(
    //   controller(),
    // );
    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        appBar: AppBar(title: Text("Profile Info")),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text(controller.errorMessage.value));
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  //profile picture
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TCircularImage(
                          image: TImages.defaultdp,
                          width: 80,
                          height: 80,
                        ),
                        TextButton(
                          onPressed: () async {
                            final updated = await Get.toNamed(
                              AppRoutes.editProfileInfoScreen,
                            );
                            if (updated == true) {
                              controller.fetchUserInfo();
                              print("=== Profile Details Screen Refreshed ===");
                              print("Name: ${controller.name.value}");
                              print("Email: ${controller.email}");
                              print("Company: ${controller.companyName.value}");
                              print("GST: ${controller.gstDetails.value}");
                              print(
                                "Address Line: ${controller.addressLine.value}",
                              );
                              print("City: ${controller.city.value}");
                              print("State: ${controller.state.value}");
                              print(
                                "Nationality: ${controller.nationality.value}",
                              );
                            }
                          },

                          // onPressed:
                          //     () => Get.toNamed(AppRoutes.editProfileInfoScreen),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Edit Profile Info', style: TextStyle(fontWeight: FontWeight.bold),),
                              SizedBox(width: 4),
                              Icon(Iconsax.edit_2),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Details
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 16),

                  Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile Information -- Info 1
                        const TBodyTitle(
                          // showActionButton: false,
                          title: 'Profile Information',
                        ),
                        const SizedBox(height: 16),

                        TProfileMenu(
                          title: 'name',
                          value:
                              controller.name.value.isNotEmpty
                                  ? controller.name.value
                                  : "Not Available",
                        ),

                        TProfileMenu(
                          title: 'Email',
                          value:
                              controller.email.value.isNotEmpty
                                  ? controller.email.value
                                  : "Not Available",
                        ),

                        // TProfileMenu(
                        //   title: 'Phone Number',
                        //   value:
                        //       controller.phone.value.isEmpty
                        //           ? 'Add Mobile Number'
                        //           : controller.phone.value,
                        // ),

                        // TProfileMenu(
                        //   title: 'Mail ID',
                        //   value: controller.email.value,
                        //   icon: Iconsax.copy,
                        // ),

                        // Divider
                        const SizedBox(height: 8),
                        const Divider(),
                        const SizedBox(height: 16),

                        // Personal Information -- info 2
                        const TBodyTitle(
                          // showActionButton: false,
                          title: 'Company Details',
                        ),
                        const SizedBox(height: 16),
                        TProfileMenu(
                          title: 'Company Name',
                          value:
                              controller.companyName.value.isNotEmpty
                                  ? controller.companyName.value
                                  : "Not Available",
                        ),

                        TProfileMenu(
                          title: 'GST Number',
                          value:
                              controller.gstDetails.value.isNotEmpty
                                  ? controller.gstDetails.value
                                  : "Not Available",
                        ),

                        // Divider
                        const SizedBox(height: 8),
                        const Divider(),
                        const SizedBox(height: 16),

                        // Profile Information -- Info 1
                        const TBodyTitle(
                          // showActionButton: false,
                          title: 'Address Details',
                        ),
                        const SizedBox(height: 16),

                        TProfileMenu(
                          title: 'Address Line',
                          value:
                              controller.addressLine.value.isNotEmpty
                                  ? controller.addressLine.value
                                  : "Not Available",
                        ),
                        TProfileMenu(
                          title: 'City',
                          value:
                              controller.city.value.isNotEmpty
                                  ? controller.city.value
                                  : "Not Available",
                        ),
                        TProfileMenu(
                          title: 'State',
                          value:
                              controller.state.value.isNotEmpty
                                  ? controller.state.value
                                  : "Not Available",
                        ),
                        TProfileMenu(
                          title: 'Nationality',
                          value:
                              controller.nationality.value.isNotEmpty
                                  ? controller.nationality.value
                                  : "Not Available",
                        ),

                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

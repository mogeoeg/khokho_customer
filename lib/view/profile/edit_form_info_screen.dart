// import 'package:ev/common/body_title.dart';
// import 'package:ev/common/button.dart';
// import 'package:ev/controller/profile_creation_controller.dart';
// import 'package:ev/controller/profile_data_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';

// class EditProfileInfoScreen extends StatefulWidget {
//   const EditProfileInfoScreen({super.key});

//   @override
//   State<EditProfileInfoScreen> createState() => _EditProfileInfoScreenState();
// }

// class _EditProfileInfoScreenState extends State<EditProfileInfoScreen> {
//   final formKey = GlobalKey<FormState>();
//   final isLoading = false.obs;
//   final UserController controller = Get.put(
//     UserController(),
//   )..isEditMode = true;

//   @override
//   void initState() {
//     super.initState();
//     controller.loadProfileData();
//   }

//   // Future<void> _saveProfile() async {
//   //   if (formKey.currentState!.validate()) {
//   //     await controller.submitProfile();
//   //   }
//   // }

//   Future<void> _saveProfile() async {
//   if (controller.formKey.currentState!.validate()) {
//     isLoading = true;
//     final success = await controller.submitProfile();
//     isLoading = false;

//     if (success) {
//       // refresh profile data
//       final profileUserController = Get.find<profileUserController>();
//       profileUserController.fetchProfileData();
//       Get.back();
//     }
//   }
// }

//   // Future<void> _saveProfile() async {
//   //   if (formKey.currentState!.validate()) {
//   //     isLoading = true;
//   //     final success = await controller.submitProfile();
//   //     isLoading = false;
//   //     if (success) {
//   //       // refresh profile data
//   //       final profileUserController = Get.find<profileUserController>();
//   //       profileUserController.fetchProfileData(); // ✅ update reactive fields

//   //       Get.back(); // go back to ProfileDetailsScreen// go back to ProfileView
//   //     }
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     // final email = PreferenceUtils.getUserEmail();

//     return Scaffold(
//       appBar: AppBar(title: const Text('Edit Profile Info')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: controller.formKey,
//           child: ListView(
//             children: [
//               /// Profile Info
//               const TBodyTitle(title: 'Profile Information'),
//               const SizedBox(height: 16),
//               const Text(
//                 "Name",
//                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//               ),
//               const SizedBox(height: 8),

//               TextFormField(
//                 controller: controller.nameController,
//                 decoration: const InputDecoration(hintText: 'Full Name'),
//                 validator:
//                     (value) => value!.isEmpty ? 'Please enter your name' : null,
//               ),
//               const SizedBox(height: 16),
//               const Text(
//                 "Phone Number",
//                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//               ),
//               const SizedBox(height: 8),

//               TextFormField(
//                 controller: controller.phoneController,
//                 decoration: const InputDecoration(
//                   hintText: 'Phone Number',
//                   counterText: '',
//                 ),
//                 keyboardType: TextInputType.phone,
//                 maxLength: 10,
//                 inputFormatters: [FilteringTextInputFormatter.digitsOnly],

//                 // validator: (value) {
//                 //   if (value == null || value.isEmpty) {
//                 //     return 'Please enter a phone number';
//                 //   } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
//                 //     return 'Phone number must be exactly 10 digits';
//                 //   }
//                 //   return null;
//                 // },
//                 validator: (value) {
//                   if (value == null || value.trim().isEmpty) {
//                     return 'Enter Receiver Phone Number';
//                   } else if (!RegExp(r'^\d{10}$').hasMatch(value.trim())) {
//                     return 'Phone number must be 10 digits';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 24),

//               /// Company Info
//               const TBodyTitle(title: 'Company Details'),
//               const SizedBox(height: 16),
//               const Text(
//                 "Company Name",
//                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//               ),
//               const SizedBox(height: 8),

//               TextFormField(
//                 controller: controller.companyNameController,
//                 decoration: const InputDecoration(hintText: 'Company Name'),
//                 validator:
//                     (value) =>
//                         value!.isEmpty
//                             ? 'Please enter your Company Name'
//                             : null,
//               ),
//               const SizedBox(height: 16),
//               const Text(
//                 "GST Number",
//                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//               ),
//               const SizedBox(height: 8),

//               TextFormField(
//                 controller: controller.gstController,
//                 decoration: const InputDecoration(hintText: 'GST Number'),
//                 validator:
//                     (value) =>
//                         value!.isEmpty ? 'Enter a valid GST Number' : null,
//               ),
//               const SizedBox(height: 24),

//               // Divider(color: Colors.grey.shade200,),

//               /// Address Info
//               const TBodyTitle(title: 'Address Details'),
//               const SizedBox(height: 16),
//               const Text(
//                 "Address Line",
//                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//               ),
//               const SizedBox(height: 8),

//               TextFormField(
//                 controller: controller.addressLineController,
//                 decoration: const InputDecoration(hintText: 'Address Line'),
//                 validator:
//                     (value) =>
//                         value!.isEmpty ? 'Please enter your Address' : null,
//               ),
//               const SizedBox(height: 16),
//               const Text(
//                 "City",
//                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//               ),
//               const SizedBox(height: 8),

//               TextFormField(
//                 controller: controller.cityController,
//                 decoration: const InputDecoration(hintText: 'City'),
//                 validator: (value) => value!.isEmpty ? 'Enter a City' : null,
//               ),
//               const SizedBox(height: 16),
//               const Text(
//                 "State",
//                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//               ),
//               const SizedBox(height: 8),

//               TextFormField(
//                 controller: controller.stateController,
//                 decoration: const InputDecoration(hintText: 'State'),
//                 validator: (value) => value!.isEmpty ? 'Enter a State' : null,
//               ),
//               const SizedBox(height: 16),
//               const Text(
//                 "Nationality",
//                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//               ),
//               const SizedBox(height: 8),

//               TextFormField(
//                 controller: controller.countryController,
//                 decoration: const InputDecoration(hintText: 'Nationality'),
//                 validator:
//                     (value) => value!.isEmpty ? 'Enter a Nationality' : null,
//               ),
//               const SizedBox(height: 32),
//             ],
//           ),
//         ),
//       ),

//       /// Save Button
//       bottomNavigationBar: SafeArea(
//         top: false,
//         bottom: true,
//         child: Padding(
//           padding: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
//           child: Obx(
//             () => TNavigationButton(
//               buttonTitle: isLoading ? "Saving..." : "Save Changes",
//               onTap: () {
//                 if (!isLoading) _saveProfile();
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: avoid_print, deprecated_member_use

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ev/common/body_title.dart';
import 'package:ev/common/button.dart';
import 'package:ev/common/required_lable_title.dart';
import 'package:ev/controller/city_state_controller.dart';
import 'package:ev/controller/profile_creation_controller.dart';
import 'package:ev/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ev/controller/profile_data_controller.dart';
import 'package:iconsax/iconsax.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final UserController userController = Get.put(UserController());

  final ProfileUserController profileUserController =
      Get.find<ProfileUserController>();

  final locationController = Get.put(CityStateController());

  @override
  void initState() {
    super.initState();
    locationController.fetchLocations(); // ✅ fetch locations
    // Prefill selected state/city
    userController.selectedState.value = profileUserController.state.value;
    userController.selectedCity.value = profileUserController.city.value;
  }

  Future<void> _saveProfile() async {
    await userController.updateUser(isEditMode: true);
    if (!userController.isLoading.value &&
        userController.userModel.value != null) {
      // Refresh profile controller
      await profileUserController.fetchUserInfo();

      print("=== Fetched from Preferences ===");
      print("Name: ${profileUserController.name}");
      print("Email: ${profileUserController.email}");
      print("Company: ${profileUserController.companyName}");
      print("GST: ${profileUserController.gstDetails}");
      print("Address Line: ${profileUserController.addressLine}");
      print("City: ${profileUserController.city}");
      print("State: ${profileUserController.state}");
      print("Nationality: ${profileUserController.nationality}");

      // Navigate back to Profile Details
      Get.back(result: true);
    }
  }

  // ================= VALIDATORS =================
  String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter Full Name";
    } else if (!RegExp(r"^[a-zA-Z ]+$").hasMatch(value.trim())) {
      return "Name can only contain letters";
    } else if (value.trim().length < 3) {
      return "Name must be at least 3 characters long";
    }
    return null;
  }

  String? validateCompanyName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter Company Name";
    } else if (value.trim().split(" ").length < 2) {
      return "Enter full company name";
    }
    return null;
  }

   String? validateGST(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter GST Number";
    } else if (value.trim().length != 15) {
      return "GST Number must be exactly 15 characters";
    } else if (!RegExp(
      r"^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$",
    ).hasMatch(value.trim())) {
      return "Enter valid GST Number (15 characters, correct format)";
    }
    return null;
  }

 String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Enter Email ID";
  } else if (!RegExp(
    r"^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$", // only lowercase letters
  ).hasMatch(value.trim())) {
    return "Enter valid Email Address (lowercase only)";
  }
  return null;
}

  // ==============================================
  @override
  Widget build(BuildContext context) {
    // Pre-fill controllers with existing values
    userController.nameController.text = profileUserController.name.value;
    userController.emailController.text = profileUserController.email.value;
    userController.companyController.text =
        profileUserController.companyName.value;
    userController.gstController.text = profileUserController.gstDetails.value;
    userController.addressLineController.text =
        profileUserController.addressLine.value;
    userController.selectedCity = profileUserController.city;
    userController.selectedState = profileUserController.state;
    userController.nationalityController.text =
        profileUserController.nationality.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile Info"),
        // centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: 70,
        ),
        child: Form(
          key: userController.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TBodyTitle(
                // showActionButton: false,
                title: 'Profile Information',
              ),
              const SizedBox(height: 16),
              const RequiredFieldLableTitle(label: "Name"),
              //const SizedBox(height: 4),
              buildTextField(
                "Name",
                userController.nameController,
                validator: validateFullName,
                icon: Iconsax.profile_2user5,
              ),
              const RequiredFieldLableTitle(label: "Email"),

              // const SizedBox(height: 8),
              buildTextField(
                "Email Address",
                userController.emailController,
                validator: validateEmail,
                icon: Icons.email,
              ),
              // buildTextField(
              //   "Phone Number",
              //   userController.phoneController,
              //   keyboard: TextInputType.phone,
              // ),
              const SizedBox(height: 16),
              const TBodyTitle(
                // showActionButton: false,
                title: 'Company Details',
              ),
              const SizedBox(height: 16),
              const RequiredFieldLableTitle(label: "Company Name"),
              // const SizedBox(height: 8),
              buildTextField(
                "Company Name",
                userController.companyController,
                validator: validateCompanyName,
                icon: Icons.business,
              ),
              const RequiredFieldLableTitle(label: "GST Number"),
              // const SizedBox(height: 8),
              buildTextField(
                "GST Number",
                userController.gstController,
                validator: validateGST,
                icon: Icons.confirmation_number,
              ),

              const SizedBox(height: 16),
              const TBodyTitle(
                // showActionButton: false,
                title: 'Address Details',
              ),
              const SizedBox(height: 16),
              const RequiredFieldLableTitle(label: "Address Line"),
              // const SizedBox(height: 8),
              buildTextField(
                "Address Line",
                userController.addressLineController,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? "Enter Address Line"
                            : null,
                icon: Icons.location_on,
              ),

              // buildTextField(
              //   "City",
              //   userController.selectedCity,
              //   validator:
              //       (value) =>
              //           value == null || value.isEmpty ? "Enter City" : null,
              // ),
              // buildTextField(
              //   "State",
              //   userController.stateController,
              //   validator:
              //       (value) =>
              //           value == null || value.isEmpty ? "Enter State" : null,
              // ),
              buildStateDropdown(),
              const SizedBox(height: 8),
              buildCityDropdown(),
              const SizedBox(height: 8),
              const RequiredFieldLableTitle(label: "Pincode"),

               const SizedBox(height: 8),
              TextFormField(
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                controller: userController.nationalityController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // ✅ only numbers
                  LengthLimitingTextInputFormatter(6), // ✅ max 6 digits
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Pincode';
                  } else if (value.length != 6) {
                    return 'Pincode must be exactly 6 digits';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.public, color: TColors.primary),
                  hintText: 'e.g. 620003',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              //   buildTextField(
              //     "Pincode",
              //     userController.nationalityController,
              //     inputFormatters: [
              //   FilteringTextInputFormatter.digitsOnly, // ✅ only numbers
              //   LengthLimitingTextInputFormatter(6), // ✅ max 6 digits
              // ],
              //     validator: (value) {
              //       if (value == null || value.isEmpty) {
              //         return 'Enter Pincode';
              //       } else if (value.length != 6) {
              //         return 'Pincode must be exactly 6 digits';
              //       }
              //       return null;
              //     },

              //     icon: Icons.public,
              //   ),
              const SizedBox(height: 20),

              // Obx(
              //   () => ElevatedButton(
              //     onPressed:
              //         userController.isLoading
              //             ? null
              //             : () => userController.submitProfile(),
              //     child:
              //         userController.isLoading
              //             ? const CircularProgressIndicator(color: Colors.white)
              //             : const Text("Save Changes"),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
          child: Obx(
            () => TNavigationButton(
              buttonTitle:
                  userController.isLoading.value ? "Saving..." : "Save Changes",
              onTap: () async {
                // if (userController.isLoading.value) return;
                // await _saveProfile();
                if (userController.isLoading.value) return;
                if (userController.formKey.currentState?.validate() ?? false) {
                  await _saveProfile();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  // Add this above buildTextField in EditProfileScreen
  Widget buildStateDropdown() {
    return Obx(() {
      //   if (locationController.locations.isEmpty) {
      //   // show loading until data is fetched
      //   return const Center(child: CircularProgressIndicator());
      // }

      final uniqueStates =
          locationController.locations.map((e) => e.stateName).toSet().toList();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RequiredFieldLableTitle(label: "State"),
          const SizedBox(height: 8),
          DropdownButtonFormField2<String>(
            dropdownStyleData: DropdownStyleData(
              maxHeight: 300, // Controls dropdown popup height
              padding: EdgeInsets.symmetric(vertical: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: Offset(0, 2), // Slight vertical drop
                  ),
                ],
              ),
            ),
            menuItemStyleData: MenuItemStyleData(
              height: 40, // Reduce item height here
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            ),
            isExpanded: true,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.location_city,
                color: TColors.primary,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            hint: const Text('Select State'),
            value:
                uniqueStates.contains(userController.selectedState.value)
                    ? userController.selectedState.value
                    : null,
            items:
                uniqueStates
                    .map(
                      (state) => DropdownMenuItem(
                        value: state,
                        child: Text(state, overflow: TextOverflow.ellipsis),
                      ),
                    )
                    .toList(),
            onChanged: (value) {
              userController.selectedState.value = value ?? '';
              userController.selectedCity.value = ''; // reset city
            },
            validator:
                (value) =>
                    (value == null || value.isEmpty) ? "Select State" : null,
          ),
        ],
      );
    });
  }

  Widget buildCityDropdown() {
    return Obx(() {
      // if (locationController.locations.isEmpty) {
      //   return const SizedBox(); // no cities yet
      // }

      final cities =
          locationController.locations
              .where((e) => e.stateName == userController.selectedState.value)
              .map((e) => e.districtName)
              .toList();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RequiredFieldLableTitle(label: "City"),
          const SizedBox(height: 8),
          DropdownButtonFormField2<String>(
            dropdownStyleData: DropdownStyleData(
              maxHeight: 300, // Controls dropdown popup height
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
            menuItemStyleData: MenuItemStyleData(
              height: 40, // Reduce item height here
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
            isExpanded: true,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.location_city,
                color: TColors.primary,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            hint: const Text('Select City'),
            value:
                cities.contains(userController.selectedCity.value)
                    ? userController.selectedCity.value
                    : null,
            items:
                cities
                    .map(
                      (city) => DropdownMenuItem(
                        value: city,
                        child: Text(city, overflow: TextOverflow.ellipsis),
                      ),
                    )
                    .toList(),
            onChanged: (value) {
              userController.selectedCity.value = value ?? '';
            },
            validator:
                (value) =>
                    (value == null || value.isEmpty) ? "Select City" : null,
          ),
        ],
      );
    });
  }

  Widget buildTextField(
    String label,

    TextEditingController controller, {

    TextInputType keyboard = TextInputType.text,
    String? Function(String?)? validator,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        controller: controller,
        keyboardType: keyboard,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: TColors.primary),
          hintText: label,

          border: const OutlineInputBorder(),
        ),
        validator:
            validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return "$label cannot be empty";
              }
              return null;
            },
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return "$label cannot be empty";
        //   }
        //   return null;
        // },
      ),
    );
  }
}

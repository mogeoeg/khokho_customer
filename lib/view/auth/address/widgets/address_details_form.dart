// ignore_for_file: deprecated_member_use

import 'package:ev/common/required_lable_title.dart';
import 'package:ev/controller/city_state_controller.dart';
import 'package:ev/controller/profile_creation_controller.dart';
import 'package:ev/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AddressDetailsForm extends StatefulWidget {
  const AddressDetailsForm({super.key});

  @override
  State<AddressDetailsForm> createState() => _AddressDetailsFormState();
}

class _AddressDetailsFormState extends State<AddressDetailsForm> {
  final controller = Get.find<UserController>();
  final locationController = Get.put(CityStateController());

  String? selectedState;
  String? selectedCity;

  @override
  void initState() {
    super.initState();
    locationController.fetchLocations(); // fetch locations initially
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            "Address Line",
            controller.addressLineController,
            "e.g. 123, MG Road, Sector 4",
            Icons.location_on,
          ),
          const SizedBox(height: 16),

          // STATE Dropdown
          _buildStateDropdown(),

          const SizedBox(height: 16),

          // CITY Dropdown
          _buildCityDropdown(),

          const SizedBox(height: 16),
          RequiredFieldLableTitle(label: "Pincode"),
        const SizedBox(height: 8),

          // Inside your TextFormField for Pincode:
          TextFormField(
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            controller: controller.nationalityController,
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

          // _buildTextField(
          //   "Pincode",
          //   controller.nationalityController,
          //   "e.g. 620003",
          //   Icons.public,
          //   keyboard: TextInputType.number,
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Enter Pincode';
          //     } else if (!RegExp(r'^\d{6}$').hasMatch(value)) {
          //       return 'Pincode must be exactly 6 digits';
          //     }
          //     return null;
          //   },
          // ),
        ],
      ),
    );
  }

  // // STATE Dropdown

  Widget _buildStateDropdown() {
    return Obx(() {
      final uniqueStates =
          locationController.locations.map((e) => e.stateName).toSet().toList();

    //        if (uniqueStates.isEmpty) {
    //   return const Text('No states available');
    // }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RequiredFieldLableTitle(label: "State"),
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
            isExpanded: true, // let it expand full width if needed
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.location_city,
                color: TColors.primary,
              ), // ✅ PREFIX ICON
              // This keeps it like a normal TextFormField
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),

            hint: const Text('Select State'),
            // value:
            //     uniqueStates.contains(controller.selectedState.value)
            //         ? controller.selectedState.value
            //         : null,


             value: uniqueStates.contains(controller.selectedState.value) &&
                 controller.selectedState.value.isNotEmpty
              ? controller.selectedState.value
              : null,

            items:
                uniqueStates.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item, overflow: TextOverflow.ellipsis),
                  );
                }).toList(),
            onChanged: (value) {
              controller.selectedState.value = value ?? '';
              controller.selectedCity.value = ''; // reset city
            },
            validator:
                (value) =>
                    (value == null || value.isEmpty) ? "Select State" : null,
          ),
        ],
      );
    });
  }

  // CITY Dropdown

  Widget _buildCityDropdown() {
    return Obx(() {
      final cities =
          locationController.locations
              .where((e) => e.stateName == controller.selectedState.value)
              .map((e) => e.districtName)
              .toList();

      //  final displayCities = ['-- Select City --', ...cities];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RequiredFieldLableTitle(label: "City"),
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
            isExpanded: true, // let it expand full width if needed
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.location_city,
                color: TColors.primary,
              ), // ✅ PREFIX ICON

              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            hint: const Text('Select City'),
            value:
                cities.contains(controller.selectedCity.value)
                    ? controller.selectedCity.value
                    : null,

            // value: selectedCity,
            items:
                cities.map((city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city, overflow: TextOverflow.ellipsis),
                  );
                }).toList(),
            onChanged: (value) {
              controller.selectedCity.value = value ?? '';
            },
            validator:
                (value) =>
                    (value == null || value.isEmpty) ? "Select City" : null,
          ),
        ],
      );
    });
  }

  Widget _buildTextField(
    String label,
    TextEditingController ctrl,
    String hint,
    IconData icon,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RequiredFieldLableTitle(label: label),
        const SizedBox(height: 8),
        TextFormField(
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          maxLines: 1,
          controller: ctrl,
          validator: (value) => value!.isEmpty ? 'Enter $label' : null,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: TColors.primary, size: 22),
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomDropdownFormField<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String label;
  final Function(T?) onChanged;
  final String? Function(T?)? validator;
  final String Function(T) itemAsString;

  const CustomDropdownFormField({
    super.key,
    required this.value,
    required this.items,
    required this.label,
    required this.onChanged,
    this.validator,
    required this.itemAsString,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      isExpanded: true,
      value: value,
      onChanged: onChanged,

      items:
          items
              .map(
                (item) => DropdownMenuItem<T>(
                  value: item,
                  child: Text(
                    itemAsString(item),
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ),
              )
              .toList(),
      validator:
          validator ?? (value) => value == null ? 'Please select $label' : null,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 12,
        ),
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 300,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 48,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),

      dropdownSearchData: DropdownSearchData(
        // searchController: _tableSearchController,
        searchInnerWidget: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 2),

          child: TextField(
            //controller: _tableSearchController,
            decoration: InputDecoration(
              hintText: 'Search...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
        searchInnerWidgetHeight: 60,
        searchMatchFn: (item, searchValue) {
          final value = item.value;
          if (value == null) return false;
          return itemAsString(
            value,
          ).toLowerCase().contains(searchValue.toLowerCase());
        },
      ),
    );
  }
}

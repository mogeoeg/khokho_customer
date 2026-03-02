// // ignore_for_file: avoid_print

// import 'package:ev/helper/model/create_user_model.dart';

// class LoginUserModel {
//   final int? id;
//   final String? name;
//   final String? email;
//   final String? token;
//   final String? companyName;
//   final String? gstDetails;
//   final Address? address; 

//   LoginUserModel({
//     this.id,
//     this.name,
//     this.email,
//     this.token,
//     this.companyName,
//     this.gstDetails,
//      this.address, 
//   });

//   factory LoginUserModel.fromJson(Map<String, dynamic> json) {
//     print("👤 Parsing User: $json");
//     return LoginUserModel(
//       id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()),
//       name: json['name']?.toString(),
//       email: json['email']?.toString(),
//       token: json['token']?.toString(),
//       companyName: json['company_name']?.toString(),
//       gstDetails: json['gst_details']?.toString(),
//       address: json['address'] != null
//           ? Address.fromJson(json['address'])
//           : null, // ✅ Parse address
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'email': email,
//       'token': token,
//       'company_name': companyName,
//       'gst_details': gstDetails,
//        'address': address?.toJson(),
//     };
//   }
// }




// ignore_for_file: avoid_print

import 'package:ev/helper/model/create_user_model.dart';

class LoginUserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? token;
  final String? companyName;
  final String? gstDetails;
  final Address? address;

  LoginUserModel({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.token,
    this.companyName,
    this.gstDetails,
    this.address,
  });

  factory LoginUserModel.fromJson(Map<String, dynamic> json) {
    print("👤 Parsing User: $json");
    return LoginUserModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()),
      name: json['name']?.toString(),
      email: json['email']?.toString(),
      phoneNumber: json['phone_number']?.toString(),
      token: json['mobile_token']?.toString(), // API returns mobile_token
      companyName: json['company_name']?.toString(),
      gstDetails: json['gst_details']?.toString(),
      address: json['address'] != null
          ? Address.fromJson(json['address'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'token': token,
      'company_name': companyName,
      'gst_details': gstDetails,
      'address': address?.toJson(),
    };
  }
}

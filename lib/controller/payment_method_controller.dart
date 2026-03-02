// // controller/payment_method_controller.dart
// import 'package:get/get.dart';

// class PaymentMethodController extends GetxController {
//   // 0 = Card, 1 = UPI, 2 = Cash
//   RxInt selectedMethodId = 0.obs;

//   void setPaymentMethod(int id) {
//     selectedMethodId.value = id;
//   }

//   String get paymentMethodName {
//     switch (selectedMethodId.value) {
//       case 0:
//         return 'Credit / Debit Card';
//       case 1:
//         return 'UPI / BHIM';
//       case 2:
//         return 'Cash / Pay at Pickup';
//       default:
//         return 'Unknown';
//     }
//   }
// }




import 'package:get/get.dart';

// class PaymentMethodController extends GetxController {
//   // 🔢 0 = Card, 1 = UPI, 2 = Cash
//   RxInt selectedMethodId = 0.obs;

//   // 🔢 Payment Status: 0 = Pending, 1 = Success, 2 = Failed, 3 = Cancelled
//   RxInt paymentStatus = 0.obs;

//   /// ✅ Select payment method (Card / UPI / Cash)
//   void setPaymentMethod(int id) {
//     selectedMethodId.value = id;
//   }

//   /// ✅ Update payment status
//   void setPaymentStatus(int status) {
//     paymentStatus.value = status;
//   }

//   /// ✅ Returns name of the selected payment method
//   String get paymentMethodName {
//     switch (selectedMethodId.value) {
//       case 0:
//         return 'Credit / Debit Card';
//       case 1:
//         return 'UPI / BHIM';
//       case 2:
//         return 'Cash / Pay at Pickup';
//       default:
//         return 'Unknown';
//     }
//   }

//   /// ✅ Returns user-friendly payment status text
//   String get paymentStatusText {
//     switch (paymentStatus.value) {
//       case 0:
//         return 'Pending';
//       case 1:
//         return 'Paid';
//       case 2:
//         return 'Failed';
//       case 3:
//         return 'Cancelled';
//       default:
//         return 'Unknown';
//     }
//   }

//   /// ✅ Returns color for payment status text (for UI)
//   String get paymentStatusEmoji {
//     switch (paymentStatus.value) {
//       case 1:
//         return "✅"; // Success
//       case 2:
//         return "❌"; // Failed
//       case 3:
//         return "🚫"; // Cancelled
//       default:
//         return "⏳"; // Pending
//     }
//   }
// }




class PaymentMethodController extends GetxController {
  RxInt selectedMethodId = (-1).obs; // default -1 = not selected
  RxInt paymentStatus = 0.obs; // 0 = Pending, 1 = Success, 2 = Failed

  void setPaymentMethod(int id) {
    selectedMethodId.value = id;
  }

  void setPaymentStatus(int status) {
    paymentStatus.value = status;
  }

  /// ✅ Add this method (fixes your error)
  String getPaymentMethodName(int methodId) {
    switch (methodId) {
      case 0:
        return "Credit / Debit Card";
      case 1:
        return "UPI / BHIM";
      case 2:
        return "Cash on Delivery";
      default:
        return "Unknown Payment Method";
    }
  }
}


import 'package:ev/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Login screen shows header, phone input and Continue button',
      (WidgetTester tester) async {
    // Build app with LoginScreen as home
    await tester.pumpWidget(const EvCourier(
      isLoggedIn: false,
      isProfileComplete: false,
    ));

    // Wait for rendering
    await tester.pumpAndSettle();

    // ✅ Check for header container with background image
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).image?.image
                is AssetImage &&
            ((widget.decoration as BoxDecoration).image!.image as AssetImage)
                    .assetName ==
                'assets/images/login.png', // <-- make sure this matches TImages.loginImage
      ),
      findsOneWidget,
    );

    // ✅ Check for phone number input (your TLoginForm has a TextField inside)
    expect(find.byType(TextField), findsOneWidget);

    // ✅ Check for "Continue" button
    expect(find.text('Continue'), findsOneWidget);
  });
}

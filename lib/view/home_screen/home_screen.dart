// ignore_for_file: deprecated_member_use, avoid_print

import 'dart:async';

import 'package:ev/common/body_title.dart';
import 'package:ev/controller/banner_controller.dart';
import 'package:ev/controller/fetch_order_controller.dart';
import 'package:ev/helper/routes/navigation.dart';
import 'package:ev/utils/colors.dart';
import 'package:ev/utils/image.strings.dart';
import 'package:ev/view/home_screen/widgets/build_feature.dart';
import 'package:ev/view/home_screen/widgets/build_order_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  final String? locationText;

  const HomeScreen({super.key, this.locationText});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _fetchOrderController = Get.find<FetchOrderController>();

  final BannerController _bannerController = Get.put(BannerController());

//  final RxInt _currentIndex = 0.obs;

  // @override
  // void initState() {
  //   super.initState();

  //   Get.find<FetchOrderController>().fetchOrders();
  // }

  @override
  void initState() {
    super.initState();
    Get.find<BannerController>().fetchBannerData();
    if (_fetchOrderController.orders.isEmpty) {
      _fetchOrderController.fetchOrders();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8), // 🔘 round the image
              child: Image.asset(
                TImages.appLogo,
                height: 36,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),

            Text("Kho-Kho"),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Iconsax.notification, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // // Search Bar
            Material(
              color: Colors.grey.shade50,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: TColors.primary),
              ),
              child: InkWell(
                onTap: () => Get.toNamed(AppRoutes.createOrderLocaitonEntry),
                borderRadius: BorderRadius.circular(12), // must match!
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  height: 56,
                  child: Row(
                    children: const [
                      Icon(Iconsax.search_normal),
                      SizedBox(width: 16),
                      Text(
                        "Destination Location...",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            Obx(() {
              if (_bannerController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (_bannerController.banners.isEmpty) {
                return const SizedBox.shrink();
              }

              final imageList =
                  _bannerController.banners
                      .map(
                        (b) => b.imageUrls.isNotEmpty ? b.imageUrls.first : "",
                      )
                      .where((url) => url.isNotEmpty)
                      .toList();

              return BannerCarousel(images: imageList);
            }),

            // Obx(() {
            //   if (_bannerController.isLoading.value) {
            //     return const Center(child: CircularProgressIndicator());
            //   }

            //   // 🔒 Don't render anything if banner list is empty
            //   if (_bannerController.banners.isEmpty) {
            //     return const SizedBox.shrink();
            //   }

            //   return Column(
            //     children: [
            //       CarouselSlider.builder(
            //         itemCount: _bannerController.banners.length,
            //         itemBuilder: (context, index, realIndex) {
            //           final banner = _bannerController.banners[index];
            //           final imageUrl =
            //               banner.imageUrls.isNotEmpty
            //                   ? banner.imageUrls.first
            //                   : null;

            //           return ClipRRect(
            //             borderRadius: BorderRadius.circular(12),
            //             child:
            //                 imageUrl != null
            //                     ? Image.network(
            //                       imageUrl,
            //                       width: double.infinity,
            //                       fit: BoxFit.fill,
            //                     )
            //                     : const SizedBox.shrink(),
            //           );
            //         },
            //         options: CarouselOptions(
            //           onPageChanged:
            //               (index, reason) => _currentIndex.value = index,
            //           height: 180,
            //           autoPlay: true,
            //           enlargeCenterPage: true,
            //           viewportFraction: 0.98,
            //           enableInfiniteScroll: true,
            //           autoPlayInterval: const Duration(seconds: 3),
            //           autoPlayAnimationDuration: const Duration(
            //             milliseconds: 800,
            //           ),
            //         ),
            //       ),
            //       const SizedBox(height: 8),
            //       Obx(
            //         () => Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: List.generate(
            //             _bannerController.banners.length,
            //             (index) => Container(
            //               margin: const EdgeInsets.symmetric(
            //                 horizontal: 4,
            //                 vertical: 8,
            //               ),
            //               width: 8,
            //               height: 8,
            //               decoration: BoxDecoration(
            //                 shape: BoxShape.circle,
            //                 color:
            //                     _currentIndex.value == index
            //                         ? TColors.primary
            //                         : Colors.grey.shade300,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   );
            // }),
            SizedBox(height: 16),

            TBodyTitle(title: "Features"),

            // Features
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                TBuildFeature(
                  icon: Iconsax.box,
                  title: 'Create Order',
                  onTap: () => Get.toNamed(AppRoutes.createOrderLocaitonEntry),
                ),
                 const SizedBox(width: 12),

                TBuildFeature(
                  icon: Iconsax.dollar_circle,
                  title: 'Check Rates',
                  onTap: () => Get.toNamed(AppRoutes.checkRates),
                ),
                const SizedBox(width: 12),
                TBuildFeature(
                  icon: Iconsax.message_question,
                  title: 'Help Center',

                  // onTap: () {

                  // },
                  onTap: () => Get.toNamed(AppRoutes.helpCenter),
                ),
               
                
              ],
            ),
            const SizedBox(height: 24),
            TBodyTitle(title: "Your Recent Orders"),

            const SizedBox(height: 12),
            Obx(() {
              final orders = _fetchOrderController.orders;

              if (_fetchOrderController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (orders.isEmpty) {
                return const Text('No recent orders found.');
              }

              // Sort by most recent date
              final sortedOrders = List.of(orders)..sort((a, b) {
                final dateA =
                    DateTime.tryParse(a.updatedAt ?? '') ?? DateTime(0);
                final dateB =
                    DateTime.tryParse(b.updatedAt ?? '') ?? DateTime(0);
                return dateB.compareTo(dateA); // Descending
              });

              // Take top 3 recent orders
              final recentOrders = sortedOrders.take(3).toList();

              return ListView.builder(
                itemCount: recentOrders.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final order = recentOrders[index];
                  // Format orderDate for home UI
                  final rawDateStr = order.updatedAt ?? '';
                  final utcDate = DateTime.parse(
                    "${rawDateStr}Z",
                  ); // Now parsed as UTC
                  final istDate = utcDate.add(
                    const Duration(hours: 5, minutes: 30),
                  );

                  print(
                    "🕒 Raw: $rawDateStr | Parsed UTC: $utcDate | IST: $istDate",
                  );

                  final formattedDate = DateFormat(
                    'dd MMM yyyy • h:mm a',
                  ).format(istDate);

                  return TBuildOrderTile(
                    id: order.orderNumber ?? 'Unknown',
                    status: order.statusText,
                    time: formattedDate,
                    fromAddress:
                        order.fromLocation ?? 'From Location', // ✅ pass fromLocation
                    toAddress: order.destinationLocation ?? 'To Location',
                    onTap:
                        () => Get.toNamed(
                          AppRoutes.orderStatus,
                          arguments: order,
                        ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

class BannerCarousel extends StatefulWidget {
  final List<String> images;
  const BannerCarousel({super.key, required this.images});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.95);

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients && widget.images.isNotEmpty) {
        _currentPage++;
        if (_currentPage >= widget.images.length) {
          _currentPage = 0;
        }
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.images.length,
        itemBuilder: (context, index) {
          final imageUrl = widget.images[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder:
                    (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 50),
              ),
            ),
          );
        },
      ),
    );
  }
}

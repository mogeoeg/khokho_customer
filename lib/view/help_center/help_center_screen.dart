import 'package:ev/controller/help_controller.dart';
import 'package:ev/utils/launcher_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HelpController controller = Get.put(HelpController());

    final List<Map<String, String>> faqs = [
      {
        'question': 'How do I create a new order?',
        'answer':
            'Go to the Home screen, tap "Create Order", select pickup and delivery addresses, then confirm the details.',
      },
      {
        'question': 'How can I track my delivery?',
        'answer':
            'Go to "My Orders", tap the ongoing order to see live tracking and delivery status updates.',
      },
      {
        'question': 'Why is my tracking status not updating?',
        'answer':
            'Tracking may delay due to scanning/network issues. Try refreshing after a few minutes.',
      },
      {
        'question': 'Can I change my delivery address after placing the order?',
        'answer':
            'Currently, address changes are not allowed after confirmation. Cancel and create a new order if needed.',
      },
      {
        'question': 'What payment methods are supported?',
        'answer':
            'We support UPI, credit/debit cards, net banking, and cash on delivery in select regions.',
      },
      {
        'question': 'How do I cancel my order?',
        'answer':
            'Go to "My Orders", select the order, and tap "Cancel Order" if the option is still available.',
      },
      {
        'question': 'What are Tracky’s insurance terms?',
        'answer':
            'Basic insurance is included. For high-value shipments, select premium insurance during checkout.',
      },
      {
        'question': 'What if my package is lost or damaged?',
        'answer':
            'Contact support immediately via WhatsApp or Email. Provide order ID and issue details.',
      },
      {
        'question': 'How long does delivery take?',
        'answer':
            'Standard delivery takes 1-2 business days. Delivery time depends on pickup and destination locations.',
      },
      {
        'question': 'Can I schedule a pickup for later?',
        'answer':
            'Yes. During order creation, you can choose a preferred pickup time slot.',
      },
      {
        'question': 'Is there a weight or size limit for orders?',
        'answer':
            'Yes. Each delivery type has a max weight and dimension limit. See details during order setup.',
      },
      {
        'question': 'Why was my order cancelled automatically?',
        'answer':
            'Orders may be cancelled if the pickup fails multiple times or if there’s an issue with the address.',
      },
      {
        'question': 'Can I save frequent pickup addresses?',
        'answer':
            'Yes. Use the address book feature when entering locations to save for future use.',
      },
      {
        'question': 'Do I get notified during the delivery process?',
        'answer':
            'Yes. You’ll receive push notifications for status changes: pickup, transit, and delivery.',
      },
      {
        'question': 'How do I report a late delivery?',
        'answer':
            'If your delivery is significantly delayed, contact support through Help Center options below.',
      },
      {
        'question': 'What if I’m not available during delivery?',
        'answer':
            'You can reschedule via the order screen or assign someone else to receive the package.',
      },
      {
        'question': 'Can I create multiple orders at once?',
        'answer':
            'Currently, orders must be created one at a time. Bulk shipments support is coming soon.',
      },
      {
        'question': 'What are your delivery zones?',
        'answer':
            'We currently deliver across major cities. You can check service availability by entering addresses.',
      },
      {
        'question': 'How can I contact support?',
        'answer':
            'Scroll to the bottom of this screen and contact us via WhatsApp or Email.',
      },
      {
        'question': 'Is cash on delivery (COD) available?',
        'answer':
            'COD is available in select serviceable areas. It will show up as an option if eligible.',
      },
    ];

    // Filtered FAQs using search text
    return Scaffold(
      appBar: AppBar(title: const Text('Help Center')),
      backgroundColor: Colors.white,
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                 // LauncherUtils.launchWhatsApp(context, "919514232418");
                 const supportNumber = "+919514232418";
                   ContactUtils.openWhatsApp(supportNumber);
                },
                icon: const Icon(Iconsax.sms),
                label: const Text("Contact Via Whatsapp"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: () {
                  // LauncherUtils.launchDialPad(context, "+919514232418");
                  const supportNumber = "+91 9514232418";
                ContactUtils.makeCall(supportNumber.replaceAll(' ', ''));
                },
                icon: const Icon(Icons.call),
                label: const Text("Contact Via Call"),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  side: const BorderSide(color: Colors.black12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: TextStyle(fontWeight: FontWeight.w600),
                onChanged: controller.updateSearchText,
                decoration: const InputDecoration(
                  hintText: 'Search FAQ...',
                  hintStyle: TextStyle(fontWeight: FontWeight.w500),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Popular Searched',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),

            // FAQ list
            Obx(() {
              final filteredFaqs =
                  faqs
                      .where(
                        (faq) =>
                            faq['question']!.toLowerCase().contains(
                              controller.searchText.value.toLowerCase(),
                            ) ||
                            faq['answer']!.toLowerCase().contains(
                              controller.searchText.value.toLowerCase(),
                            ),
                      )
                      .toList();

              return ListView.builder(
                itemCount: filteredFaqs.length,
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(), // prevent nested scroll
                itemBuilder: (context, index) {
                  final isExpanded = controller.expandedIndex.value == index;
                  return Theme(
                    data: Theme.of(
                      context,
                    ).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(horizontal: 14.0),
                      childrenPadding: const EdgeInsets.only(
                        left: 14.0,
                        right: 18.0,
                        bottom: 8.0,
                      ),
                      title: Text(
                        filteredFaqs[index]['question']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      initiallyExpanded: isExpanded,
                      backgroundColor: Colors.white,
                      collapsedBackgroundColor: Colors.white,
                      onExpansionChanged: (_) => controller.toggleExpand(index),
                      children: [
                        Text(
                          filteredFaqs[index]['answer']!,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
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

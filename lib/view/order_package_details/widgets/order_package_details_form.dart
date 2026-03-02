import 'package:ev/common/required_lable_title.dart';
import 'package:ev/helper/model/service_model.dart';
import 'package:ev/utils/colors.dart';
import 'package:ev/view/order_package_details/widgets/service_bottom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class OrderPackageDetailsForm extends StatefulWidget {
  final TextEditingController? goodsController;
  final void Function(ServiceModel)? onServiceSelected;

  // 🔽 Add key parameter for parent to access form
  final GlobalKey<FormState>? formKey;

  const OrderPackageDetailsForm({
    super.key,
    this.onServiceSelected,
    this.goodsController,
    this.formKey,
  });

  @override
  State<OrderPackageDetailsForm> createState() =>
      _OrderPackageDetailsFormState();
}

class _OrderPackageDetailsFormState extends State<OrderPackageDetailsForm> {
  //final _formKey = GlobalKey<FormState>();
  late final TextEditingController goodsController;

  final TextEditingController serviceController = TextEditingController();

  ServiceModel? selectedService;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    goodsController = widget.goodsController ?? TextEditingController();
    _formKey = widget.formKey ?? GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               RequiredFieldLableTitle(label: "Services"),
              
              const SizedBox(height: 8),
              Material(
                color: Colors.grey.shade50,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  //  side: BorderSide(color: TColors.primary),
                ),

                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    showServiceSelectionBottomSheet(context, (service) {
                      setState(() {
                        selectedService = service;
                        //serviceController.text = service.serviceName;
                        serviceController.text =
                            service.vehicleType ?? "Unknown Service";
                      });

                      if (widget.onServiceSelected != null) {
                        widget.onServiceSelected!(service);
                      }
                    });
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                       style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                      controller: serviceController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Select Service';
                        }
                        return null;
                      },
                      // validator:
                      //     (value) => value!.isEmpty ? 'Select Service' : null,
                      decoration: InputDecoration(
                        
                        suffixIcon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black54,
                        ),
                        prefixIcon: Icon(
                          Iconsax.box,
                          size: 22,
                          color: TColors.primary,
                        ),
                        hintText: 'Select Services',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               RequiredFieldLableTitle(label:  "Goods Type"),
             
              const SizedBox(height: 8),
              TextFormField(
                 style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                controller: goodsController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Select Goods Type';
                  }
                  return null;
                },
                // validator:
                //     (value) => value!.isEmpty ? 'Select Goods Type' : null,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Iconsax.box,
                    size: 22,
                    color: TColors.primary,
                  ),
                  hintText: 'Select Goods Type',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

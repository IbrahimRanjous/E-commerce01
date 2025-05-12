import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rjs_store/core/widgets/Appbar/appbar.dart';
import '../../../core/utils/constants/sizes.dart';
import '../data/cubit/update_phone_controller.dart';

class ChangePhone extends StatelessWidget {
  const ChangePhone({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatePhoneController());

    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Text(
          'Change Phone Number',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your new phone number below.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            Form(
              key: controller.updatePhoneFormKey,
              child: TextFormField(
                controller: controller.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your phone number';
                  }
                  // Additional validation (e.g., numeric length) can be added here.
                  return null;
                },
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updatePhone(),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

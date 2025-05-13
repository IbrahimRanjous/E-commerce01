import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rjs_store/core/widgets/Appbar/appbar.dart';
import '../../../core/utils/constants/sizes.dart';
import '../data/controllers/update_email_controller.dart';

class ChangeEmail extends StatelessWidget {
  const ChangeEmail({super.key});

  @override
  Widget build(BuildContext context) {
    // Using GetX to create or retrieve the UpdateEmailController instance.
    final controller = Get.put(UpdateEmailController());

    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Text(
          'Change Email',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your new email address below.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            Form(
              key: controller.updateEmailFormKey,
              child: TextFormField(
                controller: controller.email,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your email address';
                  }
                  // You can add further regex validation if required.
                  return null;
                },
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            // Save button to trigger the update.
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateEmail(),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
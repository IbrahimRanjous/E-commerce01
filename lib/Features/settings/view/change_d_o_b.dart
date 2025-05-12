import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rjs_store/core/widgets/Appbar/appbar.dart';
import '../../../core/utils/constants/sizes.dart';
import '../data/cubit/update_d_o_b_controller.dart';

class ChangeDOB extends StatelessWidget {
  const ChangeDOB({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateDOBController());

    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Text(
          'Change Date of Birth',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your date of birth.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            Form(
              key: controller.updateDOBFormKey,
              child: TextFormField(
                controller: controller.dob,
                readOnly: true, // Set readOnly to launch date picker
                decoration: const InputDecoration(
                  labelText: 'Date of Birth',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your date of birth';
                  }
                  return null;
                },
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    controller.dob.text =
                        pickedDate.toLocal().toString().split(' ')[0];
                  }
                },
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateDOB(),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

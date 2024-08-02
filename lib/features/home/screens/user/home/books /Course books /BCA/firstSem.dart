import 'package:book_Verse/common/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../../../../utils/constants/sizes.dart';

import '../widgets/courseMenu.dart';
import 'firstSem/firstBooks.dart';

class firstSem extends StatelessWidget {
  const firstSem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,

      ),
      body: Padding(
        padding: EdgeInsets.only(left: TSizes.defaultSpace,right: TSizes.defaultSpace),
        child: Column(
          children: [
            TSectionHeading(title: '| BCA ',showActionButton: false , onPressed: (){},),
            const SizedBox(height: TSizes.spaceBtwItems),
            ///----> 1st Sem Books
            TCourseMenu(onPressed: () => Get.to(()=>firstBooks()), title: '1st Semester', value: '',),
            Divider(),
            SizedBox(height: TSizes.spaceBtwItems),
            ///----> 2nd Sem Books
            TCourseMenu(onPressed: () {  }, title: '2nd Semester', value: '',),
            Divider(),
            SizedBox(height: TSizes.spaceBtwItems),
            ///----> 3rd Sem Books
            TCourseMenu(onPressed: () {  }, title: '3rd Semester', value: '',),
            Divider(),
            SizedBox(height: TSizes.spaceBtwItems),
            ///----> 4th Sem Books
            TCourseMenu(onPressed: () {  }, title: '4th Semester', value: '',),
            Divider(),
            SizedBox(height: TSizes.spaceBtwItems),
            ///----> 5th Sem Books
            TCourseMenu(onPressed: () {  }, title: '5th Semester', value: '',),
            Divider(),
            SizedBox(height: TSizes.spaceBtwItems),
            ///----> 6th Sem Books
            TCourseMenu(onPressed: () {  }, title: '6th Semester', value: '',),
            Divider(),
            SizedBox(height: TSizes.spaceBtwItems),
            ///----> 7th Sem Books
            TCourseMenu(onPressed: () {  }, title: '7th Semester', value: '',),
            Divider(),
            SizedBox(height: TSizes.spaceBtwItems),
            ///----> 8th Sem Books
            TCourseMenu(onPressed: () {  }, title: '8th Semester', value: '',),


          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../common/network_check/network_manager.dart';
import '../../../../data/authentication/repository/adminRepo.dart';
import '../../../../data/authentication/repository/authentication/admin_auth_repo.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/popups/fullscreen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/models/adminModels.dart';
import '../../screens/signup/admin_verify_email.dart';

class AdminSignupController extends GetxController {
  static AdminSignupController get instance => Get.find();

  /// ----> Variables
  final hidePassword = true.obs;
  final privacyPolicy = false.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final firstName = TextEditingController();
  final adminId = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  final userName = TextEditingController();
  GlobalKey<FormState> adminsignupFormKey = GlobalKey<FormState>();

  void signup() async {
    // Start loading
    TFullScreenLoader.openLoadingDialogue(
        'We are processing your information....',
        TImages.checkRegistration);

    // Check Internet Connectivity
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      TLoaders.errorSnackBar(
          title: 'No Internet Connection',
          message: 'Please check your internet connection and try again.');
      TFullScreenLoader.stopLoading();
      return;
    }

    // Form Validation
    if (!adminsignupFormKey.currentState!.validate()) {
      TFullScreenLoader.stopLoading();
      return;
    }

    // Privacy policy check

    try {
      // Register admin in the Firebase authentication
      final userCredential = await AdminAuthenticationRepository.instance.registerWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      // Save Authenticated admin data in Firebase Firestore
      final newAdmin = AdminModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        userName: userName.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
        role: 'Admin', permissions: [],
      );

      final adminRepo = Get.put(AdminRepository());
      await adminRepo.saveAdminRecord(newAdmin);

      // Show success message
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your admin account has been created! Please verify it.');

      // Move to verify screen
      Get.to(() => AdminVerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      // Show error message
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}

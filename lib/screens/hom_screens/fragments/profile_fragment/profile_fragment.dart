import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:invoice_builder/services/authentification.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/firestore_key.dart';
import 'package:invoice_builder/shared/style.dart';
import 'package:invoice_builder/shared/widgets/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({super.key});

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  final preferences = SharedPreferences.getInstance();
  String fullname = 'Random User', profileImg = 'assets/google.png', email = "@user";

  getInfo() async {
    final SharedPreferences pref = await preferences;
    final sharedName = (pref.getString(FirestoreConstantsKey.nickname));
    final sharedEmail = (pref.getString(FirestoreConstantsKey.email));
    final sharedPhotoUrl = (pref.getString(FirestoreConstantsKey.photoUrl));
    setState(() {
      fullname = sharedName!;
      email = sharedEmail!;
      profileImg = sharedPhotoUrl!;
    });
  }

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthentificationProvider authProvider = Provider.of<AuthentificationProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: AppColors.cPrimary),
                      shape: BoxShape.circle),
                  child: Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: AppColors.cWhite),
                        color: Colors.blue,
                        image: DecorationImage(image: NetworkImage(profileImg), fit: BoxFit.cover),
                        shape: BoxShape.circle),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5.0, bottom: 8),
                  child: Image.asset('assets/google.png', width: 25, height: 25),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          Text(
            fullname,
            style: AppTextStyle.textStyle1(),
          ),
          Text(
            email,
            style: AppTextStyle.textStyle3(weight: FontWeight.w500),
          ),
          const SizedBox(height: 40.0),
          Bounce(
              duration: const Duration(milliseconds: 180),
              onPressed: () {
                authProvider.handleSignOut();
                Get.offAndToNamed('/login_screen');
                messageWithSnackbar(context: context, message: 'Sign Out success !');
              },
              child: Text('Sign Out', style: AppTextStyle.textStyle3()))
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invoice_builder/screens/hom_screens/fragments/profile_fragment/widgets/setting_option.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/firestore_key.dart';
import 'package:invoice_builder/shared/style.dart';
import 'package:invoice_builder/shared/strings.dart';
import 'package:invoice_builder/shared/widgets/button.dart';
import 'package:invoice_builder/shared/widgets/text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({super.key});

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  final preferences = SharedPreferences.getInstance();
  String fullname = AppStrings.defaultUsername;
  String email = AppStrings.defaultNotifEmail;
  String profileImg = AppStrings.defaultProfileImage;

  @override
  void initState() {
    getInfo();
    super.initState();
  }

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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _profile(),
            const SizedBox(height: 20.0),
            _contentModel(title: 'Content', children: [
              SettingOption(title: 'Favorites', leadingIcon: CupertinoIcons.heart, threaling: [
                Icon(
                  Icons.arrow_right_alt_sharp,
                  size: 30,
                  color: AppColors.cPrimary,
                )
              ]),
              SettingOption(
                  title: 'Downloads',
                  leadingIcon: CupertinoIcons.cloud_download,
                  threaling: [
                    Icon(
                      Icons.arrow_right_alt_sharp,
                      size: 28,
                      color: AppColors.cPrimary.withOpacity(.70),
                    )
                  ]),
            ]),
            _contentModel(title: 'Preferences', children: [
              SettingOption(title: 'Languages', leadingIcon: Icons.language, threaling: [
                AppText(
                  text: 'English',
                  style: AppTextStyle.textStyle6(),
                ),
                const SizedBox(width: 5),
                Icon(
                  Icons.arrow_right_alt_sharp,
                  size: 28,
                  color: AppColors.cPrimary.withOpacity(.70),
                )
              ]),
              SettingOptionSwitch(
                  title: 'Dark Mode', leadingIcon: CupertinoIcons.moon, value: false),
              SettingOptionSwitch(
                  title: 'Only Download via Wi-Fi', leadingIcon: CupertinoIcons.wifi, value: true),
              SettingOptionSwitch(
                  title: 'Auto Sync Cloud', leadingIcon: CupertinoIcons.arrow_up_doc, value: false),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _profile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CachedNetworkImage(
              imageUrl: profileImg,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        AppText(
          text: fullname,
          style: AppTextStyle.textStyle2(),
        ),
        AppText(
          text: email,
          style: AppTextStyle.textStyle5(),
        ),
        const SizedBox(height: 12.0),
        AppBtn(
            label: 'Edit Profile',
            action: () {},
            color: AppColors.cPrimary,
            textColor: AppColors.cWhite)
      ],
    );
  }

  Widget _contentModel({required String title, required List<Widget> children}) {
    return Column(
      children: [
        Container(
            width: double.infinity,
            color: AppColors.cGreyLow,
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
            alignment: Alignment.centerLeft,
            child: AppText(
              text: title.toUpperCase(),
              style: AppTextStyle.textStyle4(weight: FontWeight.w600),
            )),
        const SizedBox(height: 15.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/style.dart';
import 'package:invoice_builder/shared/widgets/text.dart';

class SettingOption extends StatefulWidget {
  final String title;
  final IconData leadingIcon;
  final List<Widget> threaling;
  const SettingOption(
      {super.key, required this.title, required this.leadingIcon, required this.threaling});

  @override
  State<SettingOption> createState() => _SettingOptionState();
}

class _SettingOptionState extends State<SettingOption> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.leadingIcon,
                size: 25.0,
                color: AppColors.cPrimary.withOpacity(.70),
              ),
              const SizedBox(width: 8.0),
              AppText(
                text: widget.title,
                style: AppTextStyle.textStyle4(
                  color: AppColors.cPrimary.withOpacity(.70),
                ),
              )
            ],
          ),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: widget.threaling)
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class SettingOptionSwitch extends StatefulWidget {
  final String title;
  final IconData leadingIcon;
  bool value;
  SettingOptionSwitch(
      {super.key, required this.title, required this.leadingIcon, required this.value});

  @override
  State<SettingOptionSwitch> createState() => _SettingOptionSwitchState();
}

class _SettingOptionSwitchState extends State<SettingOptionSwitch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.leadingIcon,
                size: 25.0,
                color: AppColors.cPrimary.withOpacity(.80),
              ),
              const SizedBox(width: 8.0),
              AppText(
                text: widget.title,
                style: AppTextStyle.textStyle4(
                  color: AppColors.cPrimary.withOpacity(.80),
                ),
              )
            ],
          ),
          Switch(
              // Parce que nous sommes sous Android 😒, Si vous ete sur IOS, alors rajouter simplement .adaptive(), apres le nom du widget
              value: widget.value,
              onChanged: (value) {
                setState(() {
                  widget.value = value;
                });
              })
        ],
      ),
    );
  }
}

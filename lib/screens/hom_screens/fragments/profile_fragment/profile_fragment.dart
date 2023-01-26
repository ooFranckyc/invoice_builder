import 'package:flutter/material.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({super.key});

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Profile Fragment',
        style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w700),
      ),
    );
  }
}

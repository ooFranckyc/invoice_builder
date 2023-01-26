import 'package:flutter/material.dart';

class TemplateFragment extends StatefulWidget {
  const TemplateFragment({super.key});

  @override
  State<TemplateFragment> createState() => _TemplateFragmentState();
}

class _TemplateFragmentState extends State<TemplateFragment> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Template Fragment',
        style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w700),
      ),
    );
  }
}

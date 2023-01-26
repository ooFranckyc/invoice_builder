import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:invoice_builder/env/routing.dart';
import 'package:invoice_builder/services/authentification.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: AppColors.cWhite,
  ));
  SharedPreferences preferences = await SharedPreferences.getInstance();
  runApp(InvoiceBuilderMainActivity(preferences: preferences));
}

class InvoiceBuilderMainActivity extends StatelessWidget {
  InvoiceBuilderMainActivity({super.key, required this.preferences});

  final SharedPreferences preferences;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthentificationProvider>(
          create: (_) => AuthentificationProvider(
              firebaseAuth: FirebaseAuth.instance,
              googleSignIn: GoogleSignIn(),
              preferences: preferences,
              firebaseFirestore: firebaseFirestore),
        )
      ],
      child: GetMaterialApp(
        title: 'Invoice Creator',
        theme: ThemeData(primarySwatch: Colors.grey),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        getPages: AppRouting.routing,
      ),
    );
  }
}

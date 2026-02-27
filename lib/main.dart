import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:waslet_khier/feature/Forgetpassword/data/presentation/views_model/changepassword_view.dart';
import 'package:waslet_khier/feature/Forgetpassword/data/presentation/views_model/forget_password_view.dart';
import 'package:waslet_khier/feature/Forgetpassword/data/presentation/views_model/verifycode_view.dart';
import 'package:waslet_khier/feature/create_acc/create_acc_view.dart';
import 'package:waslet_khier/featureAuth/auth/data/presintation/view_model/login_view.dart';
import 'package:waslet_khier/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Waslet_Khier());
}

class Waslet_Khier extends StatelessWidget {
  const Waslet_Khier({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "ForgetPassword()": (context) => ForgetPassword(),
        "VerifycodeView()": (context) => VerifycodeView(),
        "ChangepasswordView()": (context) => ChangepasswordView(),
        "CreateAccView()": (context) => CreateAccView(),
      },
      home: LoginView(),
      debugShowCheckedModeBanner: false,
    );
  }
}

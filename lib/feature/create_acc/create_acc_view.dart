import 'package:flutter/material.dart';
import 'package:waslet_khier/feature/Forgetpassword/data/presentation/views_model/widget/CustomAppbar.dart';
import 'package:waslet_khier/feature/create_acc/widget/create_acc_body.dart';

class CreateAccView extends StatelessWidget {
  const CreateAccView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: Custom_Appbar()),
      body: CreateAccBody(),
    );
  }
}

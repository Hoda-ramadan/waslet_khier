import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/featureAuth/auth/data/cubit/loginCubit.dart';
import 'package:waslet_khier/featureAuth/auth/data/cubit/states.dart';
import 'package:waslet_khier/featureAuth/auth/data/login_response_repo.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/custom_textfild.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/check_haveing_acc.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/custombuttom.dart';
import 'package:waslet_khier/featureAuth/authprovider.dart/authprovider.dart';

class LoginviewBody extends StatelessWidget {
  const LoginviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(LoginRepo(ApiService(Dio()))),
      child: const _LoginviewBodyContent(),
    );
  }
}

class _LoginviewBodyContent extends StatefulWidget {
  const _LoginviewBodyContent();

  @override
  State<_LoginviewBodyContent> createState() => _LoginviewBodyContentState();
}

class _LoginviewBodyContentState extends State<_LoginviewBodyContent> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginSuccess) {
          await Provider.of<AuthProvider_info>(
            context,
            listen: false,
          ).setAuthData(
            token: state.loginResponse.token?.toString(),
            donor: state.loginResponse.donor,
            admin: state.loginResponse.admin,
          );

          if (!context.mounted) return;

          final roles = state.loginResponse.roles ?? [];

          if (roles.contains('Admin') || roles.contains('SuperAdmin')) {
            final charityId = state.loginResponse.admin?.charityId ?? 0;
            context.go('/admin/$charityId'); // ✅ charityId in URL
          } else {
            context.go('/home');
          }
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Image.asset(
                    'assets/images/Group 80.png',
                    width: 151,
                    height: 151,
                  ),
                  const SizedBox(height: 30),

                  CustomTextField(
                    controller: emailController,
                    labelText: 'البريد الالكتروني',
                    hintTtxt: '',
                    prefxIcon: Icons.email_outlined,
                    isSuffixIcon: false,
                    validator: (v) => v == null || v.isEmpty
                        ? 'أدخل البريد الإلكتروني'
                        : null,
                  ),
                  const SizedBox(height: 10),

                  CustomTextField(
                    controller: passwordController,
                    labelText: 'كلمة المرور',
                    hintTtxt: '',
                    prefxIcon: Icons.lock_outline,
                    isSuffixIcon: true,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'أدخل كلمة المرور' : null,
                  ),
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () =>
                            context.push('/profile/logout/forgetpassword'),
                        child: Text(
                          'نسيت كلمة المرور؟',
                          style: TextStyle(color: appcolor, fontSize: 13),
                        ),
                      ),
                      Row(
                        children: [
                          const Text('تذكرني', style: TextStyle(fontSize: 13)),
                          Checkbox(
                            value: _rememberMe,
                            activeColor: appcolor,
                            onChanged: (val) {
                              setState(() => _rememberMe = val ?? false);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return CircularProgressIndicator(color: appcolor);
                      }
                      return Custombuttom(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<LoginCubit>().login(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                          }
                        },
                        text: 'تسجيل الدخول',
                        color: appcolor,
                        textcolor: Colors.white,
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  checkhavingAcc(
                    text1: 'ليس لديك حساب؟ ',
                    text2: 'تسجيل حساب',
                    textcolor1: Colors.black,
                    textcolor2: Colors.deepOrange,
                    path: '/profile/logout/createacc',
                  ),
                  const SizedBox(height: 20),

                  Custombuttom(
                    onPressed: () => context.go('/home'),
                    text: 'الدخول كزائر',
                    color: Colors.white,
                    textcolor: appcolor,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

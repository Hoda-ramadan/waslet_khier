import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/featureAuth/authprovider.dart/authprovider.dart';
import 'package:waslet_khier/features/Donation_feature/data/cubit/donation_cubit%20(1).dart';
import 'package:waslet_khier/features/Donation_feature/data/cubit/donation_state%20(1).dart';
import 'package:waslet_khier/features/Donation_feature/views/donation_amount_selector%20(2).dart';
import 'package:waslet_khier/features/Donation_feature/views/donation_summary%20(1).dart';
import 'package:waslet_khier/features/Donation_feature/views/instapay_dialog%20(1).dart';
import 'package:waslet_khier/features/Donation_feature/views/payment_method_selector%20(1).dart';
import 'package:waslet_khier/features/Donation_feature/views/visa_dialog%20(2).dart';
import 'package:waslet_khier/features/Donation_feature/views/vodafone_cash_dialog%20(1).dart';
import 'package:waslet_khier/features/cases_feature/data/models/caseModeljson/case_model/case_model.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/persoinalinfo_view.dart';

class DonationView extends StatelessWidget {
  final CaseModel casee;

  const DonationView({super.key, required this.casee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: CustomAppBar(),
      body: _DonationBody(casee: casee),
    );
  }
}

class _DonationBody extends StatefulWidget {
  final CaseModel casee;
  const _DonationBody({required this.casee});

  @override
  State<_DonationBody> createState() => _DonationBodyState();
}

class _DonationBodyState extends State<_DonationBody> {
  double _amount = 200;
  PaymentMethod _method = PaymentMethod.instapay;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DonationCubit, DonationState>(
      listener: (context, state) {
        if (state is DonationSuccess) {
          _showSuccessDialog(context);
        } else if (state is DonationFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // عنوان الصفحة
              customappbar(text: "التبرع"),
              const SizedBox(height: 20),

              // اختيار المبلغ
              DonationAmountSelector(
                onAmountChanged: (val) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) setState(() => _amount = val);
                  });
                },
              ),
              const SizedBox(height: 24),

              // اختيار وسيلة الدفع
              PaymentMethodSelector(
                onMethodChanged: (val) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) setState(() => _method = val);
                  });
                },
              ),
              const SizedBox(height: 24),

              // ملخص التبرع
              DonationSummary(
                caseTitle: widget.casee.title ?? "",
                amount: _amount,
                method: _method,
              ),
              const SizedBox(height: 30),

              // أزرار رجوع وإتمام الدفع
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "رجوع",
                        style: TextStyle(color: Colors.black87, fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: BlocBuilder<DonationCubit, DonationState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: state is DonationLoading
                              ? null
                              : () => _onDonate(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE8A870),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: state is DonationLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  "إتمام الدفع",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  void _onDonate(BuildContext context) {
    switch (_method) {
      case PaymentMethod.vodafoneCash:
        showDialog(
          context: context,
          builder: (_) => VodafoneCashDialog(
            caseTitle: widget.casee.title ?? "",
            amount: _amount,
            onConfirm: () => _callDonateApi(context),
          ),
        );
        break;

      case PaymentMethod.instapay:
        showDialog(
          context: context,
          builder: (_) => InstapayDialog(
            caseTitle: widget.casee.title ?? "",
            amount: _amount,
            onConfirm: () => _callDonateApi(context),
          ),
        );
        break;

      case PaymentMethod.visa:
        showDialog(
          context: context,
          builder: (_) => VisaDialog(
            caseTitle: widget.casee.title ?? "",
            amount: _amount,
            onConfirm: () => _callDonateApi(context),
          ),
        );
        break;
    }
  }

  void _callDonateApi(BuildContext context) {
    final donorId =
        Provider.of<AuthProvider_info>(context, listen: false).donor?.id ?? 0;
    context.read<DonationCubit>().donate(
      donorId: donorId,
      caseId: widget.casee.id ?? 0,
      amount: _amount,
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 60),
              const SizedBox(height: 12),
              const Text(
                "تم التبرع بنجاح!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "شكراً لتبرعك بمبلغ ${_amount.toStringAsFixed(0)} ج.م",
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: appcolor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "حسناً",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

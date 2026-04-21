import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/Donation_feature/views/payment_method_selector%20(1).dart';

class DonationSummary extends StatelessWidget {
  final String caseTitle;
  final double amount;
  final PaymentMethod method;

  const DonationSummary({
    super.key,
    required this.caseTitle,
    required this.amount,
    required this.method,
  });

  String get _methodName {
    switch (method) {
      case PaymentMethod.vodafoneCash:
        return "فودافون كاش";
      case PaymentMethod.visa:
        return "فيزا";
      case PaymentMethod.instapay:
        return "انستا باي";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  "ملخص التبرع",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 6),
                Icon(Icons.receipt_long, color: appcolor, size: 18),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            _summaryRow("الحالة", caseTitle),
            const SizedBox(height: 8),
            _summaryRow("وسيلة الدفع", _methodName),
            const SizedBox(height: 8),
            _summaryRow("نوع التبرع", "متبرع مسجل"),
            const SizedBox(height: 8),
            _summaryRow(
              "المبلغ",
              "${amount.toStringAsFixed(0)} ج.م",
              valueColor: appcolor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: valueColor ?? Colors.black87,
          ),
        ),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}

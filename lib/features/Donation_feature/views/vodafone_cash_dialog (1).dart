import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waslet_khier/const.dart';

class VodafoneCashDialog extends StatefulWidget {
  final String caseTitle;
  final double amount;
  final VoidCallback onConfirm;

  const VodafoneCashDialog({
    super.key,
    required this.caseTitle,
    required this.amount,
    required this.onConfirm,
  });

  @override
  State<VodafoneCashDialog> createState() => _VodafoneCashDialogState();
}

class _VodafoneCashDialogState extends State<VodafoneCashDialog> {
  final TextEditingController _phoneController = TextEditingController();
  static const String _walletNumber = "01027010383";

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // هيدر
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: Colors.red, size: 22),
                  ),
                  Row(
                    children: [
                      const Text(
                        "الدفع عبر فودافون كاش",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.phone_android,
                            color: Colors.red, size: 20),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                "حول المبلغ إلى الرقم التالي ثم أدخل رقم العملية للتأكيد",
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // الحالة والمبلغ
              _infoRow("الحالة", widget.caseTitle),
              const SizedBox(height: 8),
              _infoRow("المبلغ", "${widget.amount.toStringAsFixed(0)} ج.م",
                  valueColor: appcolor),
              const SizedBox(height: 12),

              // رقم المحفظة
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "أدخل رقم المحفظة",
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                            const ClipboardData(text: _walletNumber));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("تم النسخ")),
                        );
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.copy, size: 16, color: Colors.grey),
                          SizedBox(width: 4),
                          Text("نسخ",
                              style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ),
                    Text(
                      _walletNumber,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // أزرار
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text("إغلاق",
                          style: TextStyle(color: Colors.black87)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.onConfirm();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE8A870),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: const Icon(Icons.check_circle_outline,
                          color: Colors.white, size: 18),
                      label: const Text(
                        "تأكيد التحويل",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: valueColor ?? Colors.black87,
          ),
        ),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}

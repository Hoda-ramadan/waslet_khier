import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';

class VisaDialog extends StatefulWidget {
  final String caseTitle;
  final double amount;
  final VoidCallback onConfirm;

  const VisaDialog({
    super.key,
    required this.caseTitle,
    required this.amount,
    required this.onConfirm,
  });

  @override
  State<VisaDialog> createState() => _VisaDialogState();
}

class _VisaDialogState extends State<VisaDialog> {
  final _nameController = TextEditingController();
  final _cardController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _cardController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
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
                    child:
                        const Icon(Icons.close, color: Colors.red, size: 22),
                  ),
                  Row(
                    children: [
                      const Text(
                        "الدفع بالبطاقة",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue.shade100),
                        ),
                        child: const Text(
                          "VISA",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                "أدخل بيانات البطاقة لإتمام عملية الشراء",
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // بطاقة وهمية
              _buildFakeCard(),
              const SizedBox(height: 16),

              // اسم حامل البطاقة
              _buildLabel("اسم حامل البطاقة"),
              const SizedBox(height: 6),
              _buildTextField(_nameController, "NOURHAN FAISAL HAMDAN"),

              const SizedBox(height: 12),

              // رقم البطاقة
              _buildLabel("رقم البطاقة"),
              const SizedBox(height: 6),
              _buildTextField(_cardController, "4356 XXXX XXXX 1342",
                  keyboardType: TextInputType.number),

              const SizedBox(height: 12),

              // تاريخ الانتهاء و CVV
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildLabel("CVV"),
                        const SizedBox(height: 6),
                        _buildTextField(_cvvController, "***",
                            obscure: true,
                            keyboardType: TextInputType.number),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildLabel("تاريخ الانتهاء"),
                        const SizedBox(height: 6),
                        _buildTextField(_expiryController, "06/24"),
                      ],
                    ),
                  ),
                ],
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
                      icon: const Icon(Icons.credit_card,
                          color: Colors.white, size: 18),
                      label: const Text(
                        "ادفع الآن",
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

  Widget _buildFakeCard() {
    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4B3A8C), Color(0xFF7B5EA7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "BANK",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              letterSpacing: 2,
            ),
          ),
          const Text(
            "4356  XXXX  XXXX  1342",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              letterSpacing: 2,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "06/24",
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "CARD HOLDER",
                    style: TextStyle(color: Colors.white54, fontSize: 9),
                  ),
                  Text(
                    "J.Williams",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        text,
        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade400),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: appcolor),
        ),
      ),
    );
  }
}

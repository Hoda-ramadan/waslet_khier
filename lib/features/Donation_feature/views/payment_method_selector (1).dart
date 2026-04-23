import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';

enum PaymentMethod { vodafoneCash, visa, instapay }

class PaymentMethodSelector extends StatefulWidget {
  final Function(PaymentMethod) onMethodChanged;

  const PaymentMethodSelector({super.key, required this.onMethodChanged});

  @override
  State<PaymentMethodSelector> createState() => _PaymentMethodSelectorState();
}

class _PaymentMethodSelectorState extends State<PaymentMethodSelector> {
  PaymentMethod _selected = PaymentMethod.instapay;

  @override
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text(
                "اختر وسيلة الدفع",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 6),
              Icon(Icons.payment, color: appcolor, size: 18),
            ],
          ),
          const SizedBox(height: 12),
          _buildOption(
            method: PaymentMethod.vodafoneCash,
            title: "فودافون كاش",
            subtitle: "الدفع عبر محفظة فودافون كاش",
            icon: _vodafoneIcon(),
          ),
          const SizedBox(height: 8),
          _buildOption(
            method: PaymentMethod.visa,
            title: "فيزا",
            subtitle: "الدفع باستخدام البطاقات البنكية",
            icon: _visaIcon(),
          ),
          const SizedBox(height: 8),
          _buildOption(
            method: PaymentMethod.instapay,
            title: "انستا باي",
            subtitle: "تحويل مباشر عبر انستا باي",
            icon: _instapayIcon(),
          ),
        ],
      ),
    );
  }

  Widget _buildOption({
    required PaymentMethod method,
    required String title,
    required String subtitle,
    required Widget icon,
  }) {
    final isSelected = _selected == method;
    return GestureDetector(
      onTap: () {
        setState(() => _selected = method);
        widget.onMethodChanged(method);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? appcolor : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            // راديو
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? appcolor : Colors.grey,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: appcolor,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 10),

            // النص
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),

            // أيقونة وسيلة الدفع
            icon,
          ],
        ),
      ),
    );
  }

  Widget _vodafoneIcon() => Container(
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: Colors.red.shade50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Icon(Icons.phone_android, color: Colors.red, size: 20),
  );

  Widget _visaIcon() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(8),
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
  );

  Widget _instapayIcon() => Container(
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: Colors.orange.shade50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Text(
      "i>",
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.orange,
      ),
    ),
  );
}

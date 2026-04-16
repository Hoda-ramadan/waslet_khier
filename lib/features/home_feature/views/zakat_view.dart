import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';

class ZakatCalculatorScreen extends StatefulWidget {
  const ZakatCalculatorScreen({super.key});
 
  @override
  State<ZakatCalculatorScreen> createState() => _ZakatCalculatorScreenState();
}
 
class _ZakatCalculatorScreenState extends State<ZakatCalculatorScreen> {
  final _moneyCtrl = TextEditingController();
  final _stocksCtrl = TextEditingController();
  final _bondsCtrl = TextEditingController();
  final _profitsCtrl = TextEditingController();
 
  double _parse(TextEditingController c) =>
      double.tryParse(c.text.replaceAll(',', '')) ?? 0;
 
  void _calculate() {
    final money = _parse(_moneyCtrl);
    final stocks = _parse(_stocksCtrl);
    final bonds = _parse(_bondsCtrl);
    final profits = _parse(_profitsCtrl);
 
    final zakatMoney = money * 0.025;
    final zakatAmlak = (stocks + bonds + profits) * 0.025;
    final total = zakatMoney + zakatAmlak;
 
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ZakatResultSheet(
        zakatMoney: zakatMoney,
        zakatAmlak: zakatAmlak,
        total: total,
      ),
    );
  }
 
  @override
  void dispose() {
    _moneyCtrl.dispose();
    _stocksCtrl.dispose();
    _bondsCtrl.dispose();
    _profitsCtrl.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            const ZakatAppBar(),
            const ZakatIllustration(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 8),
                    const ZakatSectionLabel(label: 'زكاة المال'),
                    const SizedBox(height: 8),
                    ZakatTextField(
                      controller: _moneyCtrl,
                      hint: '5000',
                    ),
                    const SizedBox(height: 14),
                    ZakatTextField(controller: _stocksCtrl, hint: 'ادخل قيمة الأسهم التي تمتلكها في السوق'),
                    const SizedBox(height: 14),
                    ZakatTextField(controller: _bondsCtrl, hint: 'ادخل قيمة السندات التي تمتلكها في السوق'),
                    const SizedBox(height: 14),
                    ZakatTextField(controller: _profitsCtrl, hint: 'ادخل قيمة الارباح التي حصلت عليها'),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            ZakatCalculateButton(onPressed: _calculate),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
 
// ─── App Bar ─────────────────────────────────────────────────────────────────
class ZakatAppBar extends StatelessWidget {
  const ZakatAppBar({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            'حساب الزكاة',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector
           
          (
            onTap: () {
              (context).pop() ;
            },
            child: Icon(Icons.chevron_right, color: orangcolor, size: 28)),
        ],
      ),
    );
  }
}
 
// ─── Illustration ─────────────────────────────────────────────────────────────
class ZakatIllustration extends StatelessWidget {
  const ZakatIllustration({super.key});
 
  @override
  Widget build(BuildContext context) {
    return
   
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 180, 
                height:  180,
                child: Image.asset('assets/images/pana.png')),
              _CalculatorIllustration(),
            ],
          );
     
  }
}
 
class _Circle extends StatelessWidget {
  final double size;
  final double opacity;
  const _Circle({required this.size, required this.opacity});
 
  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: appcolor.withOpacity(opacity),
        ),
      );
}
 
class _CalculatorIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 130,
      decoration: BoxDecoration(
        color: appcolor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: appcolor.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          // Screen
          Container(
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: const Text(
              '1234.45',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: appcolor,
              ),
            ),
          ),
          const SizedBox(height: 6),
          // Buttons grid
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                9,
                (i) => Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(i == 8 ? 0.5 : 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// ─── Section Label ────────────────────────────────────────────────────────────
class ZakatSectionLabel extends StatelessWidget {
  final String label;
  const ZakatSectionLabel({super.key, required this.label});
 
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      textDirection: TextDirection.rtl,
    );
  }
}
 
// ─── Text Field ───────────────────────────────────────────────────────────────
class ZakatTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
 
  const ZakatTextField({
    super.key,
    required this.controller,
    required this.hint,
  });
 
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
        suffixText: 'ج.م',
        suffixStyle: TextStyle(
          color: Colors.grey.shade500,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: const Color.fromARGB(197, 61, 60, 60)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: const Color.fromARGB(54, 61, 57, 57)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: appcolor, width: 1.5),
        ),
      ),
    );
  }
}
 
// ─── Calculate Button ─────────────────────────────────────────────────────────
class ZakatCalculateButton extends StatelessWidget {
  final VoidCallback onPressed;
  const ZakatCalculateButton({super.key, required this.onPressed});
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: appcolor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 0,
          ),
          child: const Text(
            'احسب قيمة الزكاة',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
 
// ─── Result Bottom Sheet ──────────────────────────────────────────────────────
class ZakatResultSheet extends StatelessWidget {
  final double zakatMoney;
  final double zakatAmlak;
  final double total;
 
  const ZakatResultSheet({
    super.key,
    required this.zakatMoney,
    required this.zakatAmlak,
    required this.total,
  });
 
  String _fmt(double v) => '${v.toStringAsFixed(0)} ج.م';
 
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 30,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.black54),
                ),
                const Text(
                  'قيمة الزكاة',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
 
            const SizedBox(height: 20),
 
            // Zakat Money Row
            ZakatResultRow(label: 'زكاة المال', value: _fmt(zakatMoney)),
            const SizedBox(height: 12),
 
            // Zakat Amlak Row
            ZakatResultRow(label: 'زكاة الأملاك', value: _fmt(zakatAmlak)),
 
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Divider(color: Color(0xFFEEEEEE), thickness: 1.5),
            ),
 
            // Total Row
            ZakatResultRow(
              label: 'اجمالي مبلغ الزكاة',
              value: _fmt(total),
              isTotal: true,
            ),
 
            const SizedBox(height: 24),
 
            // Donate Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor:orangcolor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'تبرع الان',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
 
// ─── Result Row ───────────────────────────────────────────────────────────────
class ZakatResultRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;
 
  const ZakatResultRow({
    super.key,
    required this.label,
    required this.value,
    this.isTotal = false,
  });
 
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal ? appcolor : Colors.black87,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w400,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
 
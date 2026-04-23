import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';

class DonationAmountSelector extends StatefulWidget {
  final Function(double) onAmountChanged;

  const DonationAmountSelector({super.key, required this.onAmountChanged});

  @override
  State<DonationAmountSelector> createState() => _DonationAmountSelectorState();
}

class _DonationAmountSelectorState extends State<DonationAmountSelector> {
  final List<double> _presets = [50, 100, 200, 300];
  double? _selectedPreset = 200;
  final TextEditingController _customController = TextEditingController();

  @override
  void dispose() {
    _customController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // عنوان
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text(
                "اختر مبلغ التبرع",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 6),
              Icon(Icons.volunteer_activism, color: appcolor, size: 18),
            ],
          ),
          const SizedBox(height: 12),

          // أزرار المبالغ المحددة مسبقاً
          Row(
            children: _presets.reversed.map((amount) {
              final isSelected = _selectedPreset == amount;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedPreset = amount;
                        _customController.clear();
                      });
                      widget.onAmountChanged(amount);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? appcolor : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected ? appcolor : Colors.grey.shade300,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "${amount.toInt()} ج.م",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // أو أدخل مبلغ مخصص
          Align(
            alignment: Alignment.centerRight,
            child: const Text(
              "أو أدخل مبلغا مخصصا",
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ),
          const SizedBox(height: 8),

          TextField(
            controller: _customController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: "أدخل مبلغ آخر",
              hintStyle: const TextStyle(fontSize: 13),
              suffixText: "ج.م",
              suffixStyle: const TextStyle(color: appcolor),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: appcolor),
              ),
            ),
            onChanged: (val) {
              final parsed = double.tryParse(val);
              if (parsed != null && parsed > 0) {
                setState(() => _selectedPreset = null);
                widget.onAmountChanged(parsed);
              }
            },
          ),
        ],
      ),
    );
  }
}

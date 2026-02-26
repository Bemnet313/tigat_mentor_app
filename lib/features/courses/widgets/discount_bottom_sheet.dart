import 'package:flutter/material.dart';
import 'package:tigat_mentor_app/core/design/tokens.dart';

class DiscountBottomSheet extends StatefulWidget {
  const DiscountBottomSheet({super.key});

  @override
  State<DiscountBottomSheet> createState() => _DiscountBottomSheetState();
}

class _DiscountBottomSheetState extends State<DiscountBottomSheet> {
  DateTime? _expiryDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppTokens.primaryOlive,
              onPrimary: Colors.white,
              onSurface: AppTokens.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _expiryDate) {
      setState(() {
        _expiryDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTokens.backgroundLight,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: AppTokens.textTertiary.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: AppTokens.spacingLg),
          const Text(
            "Add Course Discount",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTokens.textPrimary),
          ),
          const SizedBox(height: AppTokens.spacingXl),
          
          const TextField(
            decoration: InputDecoration(
              labelText: "Discount Title",
              hintText: "e.g., Ramadan Special",
            ),
          ),
          const SizedBox(height: AppTokens.spacingLg),

          const TextField(
            decoration: InputDecoration(
              labelText: "Description",
              hintText: "Briefly explain the offer",
            ),
          ),
          const SizedBox(height: AppTokens.spacingLg),

          Row(
            children: [
              const Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Percentage Off (%)",
                    hintText: "25",
                  ),
                ),
              ),
              const SizedBox(width: AppTokens.spacingLg),
              Expanded(
                child: InkWell(
                  onTap: () => _selectDate(context),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: "Expiry Date",
                    ),
                    child: Text(
                      _expiryDate != null 
                        ? "${_expiryDate!.day}/${_expiryDate!.month}/${_expiryDate!.year}"
                        : "Select Date",
                      style: TextStyle(
                        color: _expiryDate != null ? AppTokens.textPrimary : AppTokens.textSecondary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTokens.spacingXl),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Apply Discount"),
            ),
          ),
        ],
      ),
    );
  }
}

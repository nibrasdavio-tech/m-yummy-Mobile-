import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

/// Input field rounded (pill) khas m'Yummy dengan prefix icon berwarna biru.
///
/// Mendukung:
/// - Prefix icon biru di sisi kiri
/// - Toggle visibilitas password (suffix icon)
/// - Validasi form
/// - Keyboard type yang sesuai konteks (nomor HP, teks, password)
class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.inputFormatters,
    this.textInputAction = TextInputAction.next,
  });

  /// Teks placeholder di dalam field.
  final String hintText;

  /// Icon prefix di sisi kiri field.
  final IconData prefixIcon;

  /// Controller untuk mengelola teks input.
  final TextEditingController? controller;

  /// Jika true, teks disamarkan (untuk password). Default: false.
  final bool obscureText;

  /// Tipe keyboard yang ditampilkan (angka untuk No.HP, teks untuk nama, dll).
  final TextInputType keyboardType;

  /// Fungsi validasi form.
  final String? Function(String?)? validator;

  /// Formatter untuk membatasi input (misal hanya angka).
  final List<TextInputFormatter>? inputFormatters;

  /// Aksi keyboard (next / done).
  final TextInputAction textInputAction;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isObscured,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      inputFormatters: widget.inputFormatters,
      textInputAction: widget.textInputAction,
      style: const TextStyle(
        fontSize: 14,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: AppColors.primaryBlue,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16, right: 12),
          child: Icon(
            widget.prefixIcon,
            color: AppColors.primaryBlue,
            size: AppSizes.inputIconSize,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 0,
          minHeight: 0,
        ),
        // Toggle visibilitas password (hanya untuk field password)
        suffixIcon: widget.obscureText
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(
                    _isObscured
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.textHint,
                    size: 20,
                  ),
                ),
              )
            : null,
        suffixIconConstraints: const BoxConstraints(
          minWidth: 0,
          minHeight: 0,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
      ),
    );
  }
}

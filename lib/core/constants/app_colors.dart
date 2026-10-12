import 'package:flutter/material.dart';

/// Palet warna terpusat untuk seluruh aplikasi m'Yummy.
///
/// Semua warna diambil langsung dari spesifikasi desain referensi
/// untuk menjaga konsistensi visual di setiap layar.
class AppColors {
  AppColors._(); // Mencegah instansiasi

  // ─── Primary ───────────────────────────────────────────────
  /// Biru royal utama – digunakan pada tombol, border input, dan link.
  static const Color primaryBlue = Color(0xFF2B56F5);

  /// Biru gelap – untuk teks link hover / pressed state.
  static const Color primaryBlueDark = Color(0xFF1D3FBF);

  // ─── Accent ────────────────────────────────────────────────
  /// Oranye/amber hangat – digunakan pada back button & elemen aksen.
  static const Color accentOrange = Color(0xFFF5A623);

  /// Kuning emas lembut – untuk ilustrasi maskot di splash.
  static const Color accentGold = Color(0xFFF5C04A);

  // ─── Background & Decoration ──────────────────────────────
  /// Putih bersih – latar belakang utama seluruh layar.
  static const Color backgroundWhite = Color(0xFFFFFFFF);

  /// Peach/krem sangat lembut – blob dekoratif di splash screen.
  static const Color blobPeach = Color(0xFFFDE8D0);

  /// Hijau sage lembut – warna dedaunan/ornamen botani.
  static const Color leafSage = Color(0xFFB0C4A8);

  // ─── Text ──────────────────────────────────────────────────
  /// Hitam pekat – judul utama (Selamat Datang, Daftar Akun).
  static const Color textPrimary = Color(0xFF1A1A2E);

  /// Abu-abu medium – subtitle / placeholder.
  static const Color textSecondary = Color(0xFF6B7280);

  /// Abu-abu terang – hint text di dalam input field.
  static const Color textHint = Color(0xFF9CA3AF);

  // ─── Border ────────────────────────────────────────────────
  /// Biru lembut untuk outline input field.
  static const Color inputBorder = Color(0xFF2B56F5);

  /// Abu-abu terang untuk border input saat tidak fokus.
  static const Color inputBorderIdle = Color(0xFFD1D5DB);
}

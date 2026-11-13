/// Konstanta ukuran & dimensi terpusat untuk seluruh aplikasi m'Yummy.
///
/// Menjaga konsistensi spacing, border radius, dan dimensi elemen UI
/// agar tidak ada magic numbers yang tersebar di berbagai file.
class AppSizes {
  AppSizes._();

  // ─── Padding & Margin ─────────────────────────────────────
  static const double paddingXS = 4.0;
  static const double paddingSM = 8.0;
  static const double paddingMD = 16.0;
  static const double paddingLG = 24.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 48.0;

  /// Padding horizontal standar untuk konten layar.
  static const double screenHorizontalPadding = 28.0;

  // ─── Border Radius ────────────────────────────────────────
  /// Radius pill / oval penuh untuk input dan tombol.
  static const double radiusPill = 30.0;

  /// Radius medium untuk card & container.
  static const double radiusMD = 16.0;

  /// Radius kecil untuk elemen minor.
  static const double radiusSM = 8.0;

  // ─── Input Field ──────────────────────────────────────────
  /// Tinggi standar input field.
  static const double inputHeight = 56.0;

  /// Lebar border input field.
  static const double inputBorderWidth = 1.5;

  // ─── Button ───────────────────────────────────────────────
  /// Tinggi standar tombol utama.
  static const double buttonHeight = 54.0;

  // ─── Icon ─────────────────────────────────────────────────
  /// Ukuran icon di dalam input field prefix.
  static const double inputIconSize = 24.0;

  /// Ukuran icon back button.
  static const double backButtonIconSize = 28.0;

  // ─── Spacing Antar Elemen ─────────────────────────────────
  /// Jarak antar input field.
  static const double inputSpacing = 16.0;

  /// Jarak antara form dan tombol aksi.
  static const double formToButtonSpacing = 32.0;

  /// Jarak antara tombol dan footer text.
  static const double buttonToFooterSpacing = 20.0;
}

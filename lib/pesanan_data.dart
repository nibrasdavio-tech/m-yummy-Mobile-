class PesananData {
  static bool adaPesanan = false;

  static String namaPaket = 'Paket Mingguan';
  static String hariPengantaran = '';
  static String waktuPengantaran = '';

  // Menyimpan seluruh jadwal paket mingguan
  static List<Map<String, String>> jadwalPengantaran = [];

  static List<Map<String, dynamic>> menuTambahan = [];

  static int totalPembayaran = 250000;

  static String status = 'Menunggu Konfirmasi';

  static void simpanPesanan({
    required String nama,
    required String hari,
    required String waktu,
    required List<Map<String, dynamic>> tambahan,
    required int total,
  }) {
    namaPaket = nama;
    hariPengantaran = hari;
    waktuPengantaran = waktu;

    menuTambahan = tambahan
        .map((item) => Map<String, dynamic>.from(item))
        .toList();

    totalPembayaran = total;
    status = 'Menunggu Konfirmasi';
    adaPesanan = true;
  }
}
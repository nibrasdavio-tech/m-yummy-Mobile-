
import 'package:flutter/material.dart';
import '../pembayaran.dart';

class PesananTambahanPage extends StatefulWidget {
  const PesananTambahanPage({super.key});

  @override
  State<PesananTambahanPage> createState() =>
      _PesananTambahanPageState();
}

class _PesananTambahanPageState extends State<PesananTambahanPage> {
  static const blue = Color(0xFF2449D8);

  // Harga dasar paket mingguan
  static const int hargaPaketMingguan = 250000;

  String hariAktif = 'Senin';
  String waktu = '10.00 - 13.00';

  final List<String> hariList = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
  ];

  final List<Map<String, dynamic>> menuTambahan = [
    {
      'nama': 'Ayam Teriyaki',
      'gambar': 'assets/images/ayam_teriyaki.jpg',
      'harga': 25000,
    },
    {
      'nama': 'Ayam Katsu',
      'gambar': 'assets/images/ayam_katsu.jpg',
      'harga': 28000,
    },
    {
      'nama': 'Beef Teriyaki',
      'gambar': 'assets/images/beef_teriyaki.jpg',
      'harga': 35000,
    },
    {
      'nama': 'Ikan Asam Manis',
      'gambar': 'assets/images/ikan_asam_manis.jpg',
      'harga': 30000,
    },
    {
      'nama': 'Ikan Balado',
      'gambar': 'assets/images/ikan_balado.jpg',
      'harga': 25000,
    },
  ];

  final Map<String, int> tambahan = {};

  // Menghitung total harga menu tambahan
  int get totalTambahan {
    int total = 0;

    for (final item in menuTambahan) {
      final nama = item['nama'] as String;
      final harga = item['harga'] as int;
      final jumlah = tambahan[nama] ?? 0;

      total += harga * jumlah;
    }

    return total;
  }

  // Menghitung total pembayaran paket + menu tambahan
  int get totalPembayaran {
    return hargaPaketMingguan + totalTambahan;
  }

  int get totalPorsi {
    return tambahan.values.fold(
      0,
      (sum, value) => sum + value,
    );
  }

  // Menyiapkan daftar menu tambahan untuk dikirim ke pembayaran
  List<Map<String, dynamic>> get daftarTambahanTerpilih {
    return menuTambahan
        .where((item) {
          final nama = item['nama'] as String;
          return (tambahan[nama] ?? 0) > 0;
        })
        .map((item) {
          final nama = item['nama'] as String;

          return {
            'nama': nama,
            'harga': item['harga'],
            'jumlah': tambahan[nama] ?? 0,
          };
        })
        .toList();
  }

  String formatRupiah(int nominal) {
    return 'Rp${nominal.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    )}';
  }

  void tambahPorsi(String nama) {
    setState(() {
      tambahan[nama] = (tambahan[nama] ?? 0) + 1;
    });
  }

  void kurangiPorsi(String nama) {
    setState(() {
      final jumlah = tambahan[nama] ?? 0;

      if (jumlah > 1) {
        tambahan[nama] = jumlah - 1;
      } else {
        tambahan.remove(nama);
      }
    });
  }

  Widget pilihanHari() {
    return Row(
      children: hariList.map((hari) {
        final selected = hariAktif == hari;

        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                hariAktif = hari;
              });
            },
            child: Container(
              height: 44,
              margin: const EdgeInsets.only(right: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF5684EB)
                    : const Color(0xFFE0E4EC),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                hari,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: selected ? Colors.white : Colors.black,
                  fontWeight: selected
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget kartuMenu(Map<String, dynamic> item) {
    final nama = item['nama'] as String;
    final gambar = item['gambar'] as String;
    final harga = item['harga'] as int;
    final jumlah = tambahan[nama] ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: jumlah > 0
              ? blue
              : const Color(0xFFDCE2EF),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              gambar,
              width: 55,
              height: 55,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  formatRupiah(harga),
                  style: const TextStyle(
                    fontSize: 11,
                    color: blue,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: jumlah > 0
                ? () => kurangiPorsi(nama)
                : null,
            icon: const Icon(Icons.remove_circle_outline),
            color: blue,
            iconSize: 21,
          ),

          Text(
            '$jumlah',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),

          IconButton(
            onPressed: () => tambahPorsi(nama),
            icon: const Icon(Icons.add_circle),
            color: blue,
            iconSize: 21,
          ),
        ],
      ),
    );
  }

  void konfirmasiPesanan() {
    // Jika tidak memilih menu tambahan
    if (totalPorsi == 0) {
      showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Pesanan Dilanjutkan'),
            content: const Text(
              'Anda tidak memilih menu tambahan.\n\n'
              'Paket mingguan tetap dilanjutkan '
              'tanpa biaya tambahan.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Pembayaran(
                        totalPembayaran: totalPembayaran,
                        hariPengantaran: hariAktif,
                        waktuPengantaran: waktu,
                        menuTambahan: daftarTambahanTerpilih,
                      ),
                    ),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

      return;
    }

    // Daftar nama menu yang dipilih
    final daftarPesanan = menuTambahan
        .where((item) {
          final nama = item['nama'] as String;
          return (tambahan[nama] ?? 0) > 0;
        })
        .map((item) {
          final nama = item['nama'] as String;
          final jumlah = tambahan[nama] ?? 0;

          return '$nama ($jumlah porsi)';
        })
        .join('\n');

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Pesanan Ditambahkan'),
          content: Text(
            'Hari pengantaran: $hariAktif\n'
            'Waktu: $waktu\n\n'
            'Menu tambahan:\n'
            '$daftarPesanan\n\n'
            'Total porsi: $totalPorsi\n'
            'Total tambahan: ${formatRupiah(totalTambahan)}\n\n'
            'Total pembayaran: ${formatRupiah(totalPembayaran)}',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Pembayaran(
                      totalPembayaran: totalPembayaran,
                      hariPengantaran: hariAktif,
                      waktuPengantaran: waktu,
                      menuTambahan: daftarTambahanTerpilih,
                    ),
                  ),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pesanan Tambahan',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Pilih Menu Tambahan (Opsional)',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  'Kamu bisa menambahkan menu jika ingin. '
                  'Jika tidak, langsung lanjutkan saja.',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 16),

                ...menuTambahan.map(kartuMenu),

                // BAGIAN JADWAL HANYA MUNCUL
                // JIKA PENGGUNA MEMILIH MENU TAMBAHAN
                if (totalPorsi > 0) ...[
                  const SizedBox(height: 15),

                  const Text(
                    'Pilih Hari Pengantaran',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  pilihanHari(),

                  const SizedBox(height: 18),

                  const Text(
                    'Waktu Pengantaran',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  DropdownButtonFormField<String>(
                    value: waktu,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: '10.00 - 13.00',
                        child: Text('10.00 - 13.00'),
                      ),
                      DropdownMenuItem(
                        value: '16.00 - 19.00',
                        child: Text('16.00 - 19.00'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          waktu = value;
                        });
                      }
                    },
                  ),

                  const SizedBox(height: 18),
                ],

                // JUMLAH PORSI
                const Text(
                  'Jumlah Porsi',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Container(
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFFDCE2EF),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'Total porsi tambahan',
                        style: TextStyle(fontSize: 12),
                      ),
                      const Spacer(),
                      Text(
                        '$totalPorsi',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // TOTAL BIAYA TAMBAHAN
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF0FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Total Biaya Tambahan',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        formatRupiah(totalTambahan),
                        style: const TextStyle(
                          color: blue,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: konfirmasiPesanan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  totalPorsi > 0
                      ? 'Tambah ke Pesanan'
                      : 'Lanjutkan',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

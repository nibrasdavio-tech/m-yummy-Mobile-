
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: const RingkasanPesanan(),
    );
  }
}

const biru = Color(0xFF2055D6);
const navy = Color.fromARGB(255, 2, 50, 155);
const latar = Color(0xFFF0F4FF);

const int hargaPaket = 250000;
const int penyesuaianMenu = 176000;
const int hargaTambahan = 25000;

String rupiah(int angka) {
  return 'Rp${angka.toString().replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
    (m) => '${m[1]}.',
  )}';
}

class RingkasanPesanan extends StatelessWidget {
  const RingkasanPesanan({super.key});

  Widget judul(String teks) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(
          teks,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: navy,
          ),
        ),
      );

  Widget kartu({
    required Widget isi,
    Color warna = Colors.white,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: warna,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE1E8F7)),
      ),
      child: isi,
    );
  }

  Widget barisMenu(String hari, String menu) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60,
            child: Text(
              hari,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Text('•  '),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(menu),
                const SizedBox(height: 5),
                const Text(
                  '2 porsi • 11.30',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Text(
            'Rp50.000',
            style: TextStyle(
              color: biru,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget biaya(String nama, int harga) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            nama,
            style: const TextStyle(color: Colors.blueGrey),
          ),
          Text(
            rupiah(harga),
            style: const TextStyle(color: biru),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int totalHarga =
        hargaPaket + penyesuaianMenu + hargaTambahan;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: navy,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: biru),
        title: const Text(
          'Ringkasan Pesanan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            judul('Paket Dipilih'),

            kartu(
              warna: latar,
              isi: Row(
                children: [
                  Container(
                    width: 90,
                    height: 115,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCE8D5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/paket_mingguan.jpg',
                        width: 90,
                        height: 115,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Paket Mingguan',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: navy,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Senin, 06 Okt – Jumat, 10 Okt',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          '10 kali makan • 2 kali per hari',
                          style: TextStyle(fontSize: 12),
                        ),
                        Divider(),
                        Text(
                          'Harga paket',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Rp250.000',
                          style: TextStyle(
                            color: biru,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            kartu(
              isi: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  judul('Menu & Jadwal Pengantaran'),
                  barisMenu('Senin', 'Ayam Teriyaki'),
                  const Divider(height: 1),
                  barisMenu('Selasa', 'Beef Teriyaki'),
                  const Divider(height: 1),
                  barisMenu('Rabu', 'Ayam Katsu'),
                  const Divider(height: 1),
                  barisMenu('Kamis', 'Ikan Balado'),
                  const Divider(height: 1),
                  barisMenu('Jumat', 'Ikan Asam Manis'),
                ],
              ),
            ),

            kartu(
              isi: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  judul('Pesanan Tambahan'),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: latar,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: biru,
                          size: 28,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Sabtu • Ayam Teriyaki (1 porsi)\n12.00',
                            style: TextStyle(height: 1.6),
                          ),
                        ),
                        Text(
                          'Rp25.000',
                          style: TextStyle(
                            color: biru,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Jika tidak ada tambahan, bagian ini tidak ditampilkan.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            kartu(
              warna: latar,
              isi: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  judul('Rincian Biaya'),
                  biaya('Harga paket', hargaPaket),
                  biaya('Penyesuaian menu', penyesuaianMenu),
                  biaya('Pesanan tambahan', hargaTambahan),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Harga',
                        style: TextStyle(
                          color: navy,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        rupiah(totalHarga),
                        style: const TextStyle(
                          color: biru,
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Tombol pembayaran
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Pesanan siap dilanjutkan ke pembayaran',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF204FE0),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Lanjut ke Pembayaran',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 12),
                    Icon(Icons.arrow_forward, size: 24),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            const Center(
              child: Text(
                '🔒 Pesanan akan dikonfirmasi sebelum pembayaran',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 11,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
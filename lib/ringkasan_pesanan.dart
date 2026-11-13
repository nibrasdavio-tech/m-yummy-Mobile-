import 'package:flutter/material.dart';
import 'pembayaran.dart';

const biru = Color(0xFF2055D6);
const navy = Color.fromARGB(255, 2, 50, 155);
const latar = Color(0xFFF0F4FF);

class RingkasanPesanan extends StatelessWidget {
  const RingkasanPesanan({super.key});

  @override
  Widget build(BuildContext context) {
    int hargaPaket = 250000;
    int penyesuaianMenu = 176000;
    int hargaTambahan = 25000;
    int totalHarga = hargaPaket + penyesuaianMenu + hargaTambahan;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.orange),
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
            const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text(
                'Paket Dipilih',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 18),
              decoration: BoxDecoration(
                color: latar,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE1E8F7)),
              ),
              child: Row(
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE1E8F7)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Menu & Jadwal Pengantaran',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const SizedBox(
                        width: 60,
                        child: Text(
                          'Senin',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Text('•  '),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ayam Teriyaki'),
                            SizedBox(height: 5),
                            Text(
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
                  const Divider(height: 20),
                  Row(
                    children: [
                      const SizedBox(
                        width: 60,
                        child: Text(
                          'Selasa',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Text('•  '),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Beef Teriyaki'),
                            SizedBox(height: 5),
                            Text(
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
                  const Divider(height: 20),
                  Row(
                    children: [
                      const SizedBox(
                        width: 60,
                        child: Text(
                          'Rabu',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Text('•  '),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ayam Katsu'),
                            SizedBox(height: 5),
                            Text(
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
                  const Divider(height: 20),
                  Row(
                    children: [
                      const SizedBox(
                        width: 60,
                        child: Text(
                          'Kamis',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Text('•  '),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ikan Balado'),
                            SizedBox(height: 5),
                            Text(
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
                  const Divider(height: 20),
                  Row(
                    children: [
                      const SizedBox(
                        width: 60,
                        child: Text(
                          'Jumat',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Text('•  '),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ikan Asam Manis'),
                            SizedBox(height: 5),
                            Text(
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
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE1E8F7)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pesanan Tambahan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 12),
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 18),
              decoration: BoxDecoration(
                color: latar,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE1E8F7)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rincian Biaya',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Harga paket',
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                      Text(
                        'Rp${hargaPaket ~/ 1000}.000',
                        style: const TextStyle(color: biru),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Penyesuaian menu',
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                      Text(
                        'Rp176.000',
                        style: TextStyle(color: biru),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pesanan tambahan',
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                      Text(
                        'Rp25.000',
                        style: TextStyle(color: biru),
                      ),
                    ],
                  ),
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
                        'Rp${totalHarga ~/ 1000}.${(totalHarga % 1000).toString().padLeft(3, '0')}',
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
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => const Pembayaran(),
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
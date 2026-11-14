import 'package:flutter/material.dart';

import 'pesanan_tambahan_page.dart';

class JadwalPengantaranPage extends StatelessWidget {
  final String makan1;
  final String makan2;
  final String alamat;

  const JadwalPengantaranPage({
    super.key,
    required this.makan1,
    required this.makan2,
    required this.alamat,
  });

  static const blue = Color(0xFF2449D8);

  final List<String> hariList = const [
    'Senin, 01 Okt',
    'Selasa, 02 Okt',
    'Rabu, 03 Okt',
    'Kamis, 04 Okt',
    'Jumat, 05 Okt',
  ];

  Widget jadwalMakan({
    required String judul,
    required String waktu,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.circle,
          size: 9,
          color: Color(0xFF6486F5),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$judul - $waktu',
                style: const TextStyle(fontSize: 11),
              ),
              const SizedBox(height: 4),
              const Text(
                'Menu paket',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFDCE5FA),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'Dijadwalkan',
            style: TextStyle(
              color: Color(0xFF5279F5),
              fontSize: 9,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jadwal Pengantaran',
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
                Container(
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFFDCE2EF),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: blue,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Jadwal Paket Mingguan\n1 Okt - 5 Okt 2026',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: blue,
                        size: 19,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Alamat Pengantaran',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              alamat,
                              style: const TextStyle(fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                ...hariList.map((hari) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFDCE2EF),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hari,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        jadwalMakan(
                          judul: 'Makan 1',
                          waktu: makan1,
                        ),
                        const SizedBox(height: 20),
                        jadwalMakan(
                          judul: 'Makan 2',
                          waktu: makan2,
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PesananTambahanPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Lihat Detail Semua'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'jadwal_pengantaran_page.dart';

class PesanPaketPage extends StatefulWidget {
  const PesanPaketPage({super.key});

  @override
  State<PesanPaketPage> createState() => _PesanPaketPageState();
}

class _PesanPaketPageState extends State<PesanPaketPage> {
  static const Color blue = Color(0xFF2449D8);

  String makan1 = '10.00 - 12.00';
  String makan2 = '16.00 - 18.00';

  final TextEditingController alamatController =
      TextEditingController();

  @override
  void dispose() {
    alamatController.dispose();
    super.dispose();
  }

  Widget pilihanWaktu({
    required String judul,
    required String value,
    required List<String> pilihan,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          judul,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6F7787),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
              items: pilihan.map((waktu) {
                return DropdownMenuItem<String>(
                  value: waktu,
                  child: Text(
                    waktu,
                    style: const TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  void lanjutJadwal() {
    if (alamatController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Alamat pengantaran harus diisi',
          ),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JadwalPengantaranPage(
          makan1: makan1,
          makan2: makan2,
          alamat: alamatController.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FC),

      appBar: AppBar(
        backgroundColor: blue,
        foregroundColor: Colors.white,
        title: const Text(
          'Pesan Paket',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Atur Jadwal Makan',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6F7787),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Pilih waktu pengantaran untuk setiap jadwal makan.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 24),

            // PILIHAN MAKAN 1
            pilihanWaktu(
              judul: 'Makan 1',
              value: makan1,
              pilihan: const [
                '10.00 - 12.00',
                '12.00 - 14.00',
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    makan1 = value;
                  });
                }
              },
            ),

            const SizedBox(height: 24),

            // PILIHAN MAKAN 2
            pilihanWaktu(
              judul: 'Makan 2',
              value: makan2,
              pilihan: const [
                '16.00 - 18.00',
                '18.00 - 20.00',
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    makan2 = value;
                  });
                }
              },
            ),

            const SizedBox(height: 28),

            const Text(
              'Alamat Pengantaran',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6F7787),
              ),
            ),

            const SizedBox(height: 10),

            // INPUT ALAMAT PENGANTARAN
            TextField(
              controller: alamatController,
              maxLines: 3,

              // PERBAIKAN WARNA TEKS
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),

              cursorColor: blue,
              keyboardType: TextInputType.streetAddress,
              textCapitalization: TextCapitalization.sentences,

              decoration: InputDecoration(
                hintText: 'Masukkan alamat lengkap...',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),

                filled: true,
                fillColor: Colors.white,

                contentPadding: const EdgeInsets.all(16),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: blue,
                  ),
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: blue,
                    width: 1.5,
                  ),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: blue,
                    width: 2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: lanjutJadwal,
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Lihat Jadwal Pengantaran',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'pesanan_data.dart';

class Pembayaran extends StatefulWidget {
  final int totalPembayaran;
  final String hariPengantaran;
  final String waktuPengantaran;
  final List<Map<String, dynamic>> menuTambahan;

  const Pembayaran({
    super.key,
    this.totalPembayaran = 250000,
    this.hariPengantaran = '',
    this.waktuPengantaran = '',
    this.menuTambahan = const [],
  });

  @override
  State<Pembayaran> createState() => _PembayaranState();
}

class _PembayaranState extends State<Pembayaran> {
  static const Color biru = Color(0xFF2055D6);

  String metodeDipilih = 'Transfer Bank';

  Uint8List? buktiPembayaran;

  bool sedangMemproses = false;

  // Memilih gambar bukti pembayaran dari galeri
  Future<void> pilihGambar() async {
    try {
      final ImagePicker picker = ImagePicker();

      final XFile? gambar = await picker.pickImage(
        source: ImageSource.gallery,
      );

      if (gambar != null) {
        final bytes = await gambar.readAsBytes();

        if (!mounted) return;

        setState(() {
          buktiPembayaran = bytes;
        });
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Gagal memilih gambar. Silakan coba kembali.',
          ),
        ),
      );
    }
  }

  // Format nominal menjadi Rupiah
  String formatRupiah(int nominal) {
    return 'Rp ${nominal.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    )}';
  }

  // Konfirmasi pembayaran dan menyimpan data pesanan
  void konfirmasiPembayaran() {
    if (sedangMemproses) return;

    if (buktiPembayaran == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Silakan unggah bukti pembayaran terlebih dahulu.',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      sedangMemproses = true;
    });

    try {
      // Menyimpan informasi pesanan
      PesananData.simpanPesanan(
        nama: 'Paket Mingguan',
        hari: widget.hariPengantaran,
        waktu: widget.waktuPengantaran,
        tambahan: widget.menuTambahan,
        total: widget.totalPembayaran,
      );

      // Kembali ke Home dan membuka tab Pesanan
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home-pesanan',
        (route) => false,
      );
    } catch (e) {
      setState(() {
        sedangMemproses = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Gagal menyimpan pesanan: $e',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.orange,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Pembayaran',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Column(
        children: [
          // Bagian isi pembayaran
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Metode Pembayaran',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Informasi rekening
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8EEFC),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Column(
                      children: [
                        Text(
                          "Rekening m'Yummy",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Bank: 13412090 (BNI)\n'
                          'E-Wallet: 081351271004\n'
                          '(GoPay/Dana/Ovo)',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Pilihan Transfer Bank
                  pilihanPembayaran(
                    nama: 'Transfer Bank',
                    keterangan: 'BNI, BCA, Mandiri',
                    ikon: Icons.account_balance,
                  ),

                  const SizedBox(height: 8),

                  // Pilihan E-Wallet
                  pilihanPembayaran(
                    nama: 'E-Wallet',
                    keterangan: 'GoPay, Dana, OVO',
                    ikon: Icons.account_balance_wallet,
                  ),

                  const SizedBox(height: 20),

                  // Judul upload
                  const Text(
                    'Upload Bukti Pembayaran',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Kotak upload bukti pembayaran
                  InkWell(
                    onTap: sedangMemproses ? null : pilihGambar,
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: biru,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: buktiPembayaran == null
                          ? const Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.cloud_upload_outlined,
                                  size: 32,
                                  color: Colors.black54,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Upload Bukti Transfer\n(jpg, png)',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            )
                          : ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(11),
                              child: Image.memory(
                                buktiPembayaran!,
                                width: double.infinity,
                                height: 150,
                                fit: BoxFit.contain,
                              ),
                            ),
                    ),
                  ),

                  if (buktiPembayaran != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        const Expanded(
                          child: Text(
                            'Bukti pembayaran berhasil dipilih.',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              buktiPembayaran = null;
                            });
                          },
                          child: const Text(
                            'Hapus',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Total pembayaran
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Pembayaran',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    formatRupiah(widget.totalPembayaran),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: biru,
                    ),
                  ),

                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),

          // Tombol konfirmasi
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: sedangMemproses
                    ? null
                    : konfirmasiPembayaran,
                style: ElevatedButton.styleFrom(
                  backgroundColor: biru,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: sedangMemproses
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Konfirmasi Pembayaran',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget pilihan metode pembayaran
  Widget pilihanPembayaran({
    required String nama,
    required String keterangan,
    required IconData ikon,
  }) {
    final bool terpilih = metodeDipilih == nama;

    return InkWell(
      onTap: () {
        setState(() {
          metodeDipilih = nama;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: terpilih
                ? biru
                : const Color(0xFFD5DCE8),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              ikon,
              color: Colors.black87,
              size: 24,
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    keterangan,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            Radio<String>(
              value: nama,
              groupValue: metodeDipilih,
              activeColor: biru,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    metodeDipilih = value;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

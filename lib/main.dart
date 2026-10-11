
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyummyApp(),
    ),
  );
}

const Color biru = Color(0xFF2864F0);
const Color biruMuda = Color(0xFFF1F6FF);
const Color teks = Color(0xFF172B4D);
const Color abu = Color(0xFF718096);

class MyummyApp extends StatelessWidget {
  const MyummyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Myummy',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: biru),
      ),
      home: const DetailPesananPage(),
    );
  }
}

// Data makanan
class Menu {
  final String nama;
  final int harga;
  final String gambar;

  const Menu(this.nama, this.harga, this.gambar);
}

// Menu makan siang
const List<Menu> menuSiang = [
  Menu('Ayam Bakar', 0, 'photo-1546069901-ba9599a7e63c'),
  Menu('Ayam Teriyaki', 0, 'photo-1547592180-85f173990554'),
  Menu('Ikan Balado', 0, 'photo-1512621776951-a57141f2eefd'),
  Menu('Ayam Katsu', 0, 'photo-1626082927389-6cd097cdc6ec'),
  Menu('Ikan Asam Manis', 0, 'photo-1467003909585-2f8a72700288'),
];

// Menu makan malam
const List<Menu> menuMalam = [
  Menu('Ayam Bakar', 0, 'photo-1546069901-ba9599a7e63c'),
  Menu('Sate', 0, 'photo-1547592180-85f173990554'),
  Menu('Ayam Balado', 0, 'photo-1512621776951-a57141f2eefd'),
  Menu('Ikan Bakar', 0, 'photo-1467003909585-2f8a72700288'),
];

// Menu tambahan
const List<Menu> menuTambahan = [
  Menu('Ayam Katsu', 12000, 'photo-1626082927389-6cd097cdc6ec'),
  Menu('Ayam Teriyaki', 15000, 'photo-1547592180-85f173990554'),
  Menu('Ayam Bakar', 15000, 'photo-1546069901-ba9599a7e63c'),
  Menu('Ikan Asam Manis', 15000, 'photo-1467003909585-2f8a72700288'),
  Menu('Ikan Balado', 12000, 'photo-1512621776951-a57141f2eefd'),
];

// Format harga ke rupiah
String rupiah(int angka) {
  final hasil = angka.toString();
  final buffer = StringBuffer();

  for (int i = 0; i < hasil.length; i++) {
    buffer.write(hasil[i]);
    final sisa = hasil.length - i - 1;

    if (sisa > 0 && sisa % 3 == 0) {
      buffer.write('.');
    }
  }

  return 'Rp $buffer';
}

class DetailPesananPage extends StatefulWidget {
  const DetailPesananPage({super.key});

  @override
  State<DetailPesananPage> createState() =>
      _DetailPesananPageState();
}

class _DetailPesananPageState extends State<DetailPesananPage> {
  String jenisPaket = 'Mingguan';

  int get hargaHarian =>
      jenisPaket == 'Mingguan' ? 50000 : 45000;

  int get durasi =>
      jenisPaket == 'Mingguan' ? 5 : 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header halaman
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 16, 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back,
                      color: teks,
                    ),
                  ),
                  const Text(
                    'Detail Pesanan',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: teks,
                    ),
                  ),
                ],
              ),
            ),

            // Konten utama
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Informasi paket
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: biruMuda,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownButtonFormField<String>(
                            value: jenisPaket,
                            decoration: InputDecoration(
                              labelText: 'Pilih Jenis Paket',
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                                  const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'Mingguan',
                                child: Text('Paket Mingguan'),
                              ),
                              DropdownMenuItem(
                                value: 'Bulanan',
                                child: Text('Paket Bulanan'),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  jenisPaket = value;
                                });
                              }
                            },
                          ),

                          const SizedBox(height: 16),

                          Text(
                            'Paket $jenisPaket Myummy',
                            style: const TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: teks,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            '$durasi hari berlangganan',
                            style: const TextStyle(
                              fontSize: 14,
                              color: abu,
                            ),
                          ),

                          const SizedBox(height: 20),

                          const Row(
                            children: [
                              Icon(
                                Icons.restaurant,
                                color: biru,
                                size: 26,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '2x makan sehari\nSiang dan malam',
                                  style: TextStyle(
                                    color: teks,
                                    fontSize: 12,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.local_shipping_outlined,
                                color: biru,
                                size: 26,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Pengantaran\nSudah termasuk',
                                  style: TextStyle(
                                    color: teks,
                                    fontSize: 12,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 18),

                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${rupiah(hargaHarian)}/hari',
                              style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: biru,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 26),

                    // Jadwal makan
                    const Text(
                      'Jadwal Makan Harian',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: teks,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      'Menu sudah ditentukan Myummy. '
                      'Geser untuk melihat menu lainnya.',
                      style: TextStyle(
                        color: abu,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Menu siang
                    const MenuCarousel(
                      judul: 'Makan Siang',
                      icon: Icons.wb_sunny,
                      warna: Color(0xFFFF9800),
                      daftar: menuSiang,
                    ),

                    const SizedBox(height: 16),

                    // Menu malam
                    const MenuCarousel(
                      judul: 'Makan Malam',
                      icon: Icons.nightlight_round,
                      warna: Color(0xFF8658F5),
                      daftar: menuMalam,
                    ),

                    const SizedBox(height: 28),

                    // Menu tambahan
                    const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Menu Tambahan',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: teks,
                            ),
                          ),
                        ),
                        Text(
                          'Pilihan lainnya  ›',
                          style: TextStyle(
                            color: biru,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      'Pilihan makanan di luar paket.',
                      style: TextStyle(
                        color: abu,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 14),

                    SizedBox(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: menuTambahan.length,
                        itemBuilder: (context, index) {
                          final menu = menuTambahan[index];

                          return Container(
                            width: 145,
                            margin:
                                const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.all(9),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: const Color(0xFFE1E9F3),
                              ),
                              borderRadius:
                                  BorderRadius.circular(14),
                            ),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                FotoMakanan(
                                  gambar: menu.gambar,
                                  tinggi: 90,
                                ),

                                const SizedBox(height: 8),

                                Text(
                                  menu.nama,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: teks,
                                  ),
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  rupiah(menu.harga),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: biru,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Tombol pilih menu
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: SizedBox(
                height: 62,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Myummy'),
                        content: Text(
                          'Paket $jenisPaket\n'
                          '$durasi hari berlangganan\n'
                          'Harga per hari: '
                          '${rupiah(hargaHarian)}',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.pop(context),
                            child: const Text('Kembali'),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: biru,
                    foregroundColor: Colors.white,
                    elevation: 3,
                    shadowColor: biru.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pilih Menu & Atur Pesanan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Navigasi bawah
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 8,
              ),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xFFEEEEEE),
                  ),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NavigasiItem(
                    icon: Icons.home_outlined,
                    label: 'Home',
                  ),
                  NavigasiItem(
                    icon: Icons.restaurant_menu,
                    label: 'Paket',
                    aktif: true,
                  ),
                  NavigasiItem(
                    icon: Icons.receipt_long_outlined,
                    label: 'Pesanan',
                  ),
                  NavigasiItem(
                    icon: Icons.person_outline,
                    label: 'Profil',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Tampilan menu siang dan malam
class MenuCarousel extends StatelessWidget {
  final String judul;
  final IconData icon;
  final Color warna;
  final List<Menu> daftar;

  const MenuCarousel({
    super.key,
    required this.judul,
    required this.icon,
    required this.warna,
    required this.daftar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: biruMuda,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: warna, size: 25),
              const SizedBox(width: 10),
              Text(
                judul,
                style: const TextStyle(
                  color: teks,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              const Text(
                'Geser  ›',
                style: TextStyle(
                  color: abu,
                  fontSize: 11,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 125,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: daftar.length,
              itemBuilder: (context, index) {
                final menu = daftar[index];

                return SizedBox(
                  width: 126,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        FotoMakanan(
                          gambar: menu.gambar,
                          tinggi: 85,
                        ),

                        const SizedBox(height: 7),

                        Text(
                          menu.nama,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: teks,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Foto makanan
class FotoMakanan extends StatelessWidget {
  final String gambar;
  final double tinggi;

  const FotoMakanan({
    super.key,
    required this.gambar,
    required this.tinggi,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(11),
      child: Image.network(
        'https://images.unsplash.com/$gambar?auto=format&fit=crop&w=400&q=80',
        height: tinggi,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: tinggi,
            width: double.infinity,
            color: biruMuda,
            child: const Icon(
              Icons.restaurant,
              color: biru,
              size: 30,
            ),
          );
        },
      ),
    );
  }
}

// Item navigasi bawah
class NavigasiItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool aktif;

  const NavigasiItem({
    super.key,
    required this.icon,
    required this.label,
    this.aktif = false,
  });

  @override
  Widget build(BuildContext context) {
    final warna = aktif ? biru : Colors.grey;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: warna, size: 24),

        const SizedBox(height: 4),

        Text(
          label,
          style: TextStyle(
            color: warna,
            fontSize: 11,
            fontWeight:
                aktif ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

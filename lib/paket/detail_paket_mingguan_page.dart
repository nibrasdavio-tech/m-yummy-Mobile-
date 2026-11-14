import 'package:flutter/material.dart';

import 'pesan_paket_page.dart';

class DetailPaketMingguanPage extends StatelessWidget {
  const DetailPaketMingguanPage({super.key});

  static const blue = Color(0xFF2449D8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Paket',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                'assets/images/paket_mingguan.jpg',
                width: double.infinity,
                height: 170,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Paket Mingguan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              '10x makan (pilih menu) | Senin-Jumat',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 10),

            const Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 17,
                ),
                SizedBox(width: 5),
                Text(
                  '4.8 (10 ulasan)',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),

            const SizedBox(height: 10),

            const Text(
              'Rp250.000',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: blue,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Fasilitas Paket',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _FacilityItem(
                  icon: Icons.calendar_month,
                  label: 'Jadwal',
                ),
                _FacilityItem(
                  icon: Icons.delivery_dining,
                  label: 'Pengantaran',
                ),
                _FacilityItem(
                  icon: Icons.notifications,
                  label: 'Notifikasi',
                ),
                _FacilityItem(
                  icon: Icons.chat,
                  label: 'Chat Admin',
                ),
              ],
            ),

            const SizedBox(height: 22),

            const Text(
              'Contoh Menu',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 125,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  _ExampleMenu(
                    gambar: 'assets/images/ayam_teriyaki.jpg',
                    nama: 'Ayam Teriyaki',
                  ),
                  _ExampleMenu(
                    gambar: 'assets/images/ayam_katsu.jpg',
                    nama: 'Ayam Katsu',
                  ),
                  _ExampleMenu(
                    gambar: 'assets/images/beef_teriyaki.jpg',
                    nama: 'Beef Teriyaki',
                  ),
                  _ExampleMenu(
                    gambar: 'assets/images/ikan_asam_manis.jpg',
                    nama: 'Ikan Asam Manis',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PesanPaketPage(),
                    ),
                  );
                },
                child: const Text(
                  'Pilih Menu & Atur Pesanan ›',
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const _BottomNav(),
    );
  }
}

class _FacilityItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FacilityItem({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: DetailPaketMingguanPage.blue,
          size: 23,
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 10),
        ),
      ],
    );
  }
}

class _ExampleMenu extends StatelessWidget {
  final String gambar;
  final String nama;

  const _ExampleMenu({
    required this.gambar,
    required this.nama,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 105,
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Image.asset(
              gambar,
              height: 85,
              width: 105,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            nama,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 1,
      selectedItemColor: DetailPaketMingguanPage.blue,
      unselectedItemColor: Colors.grey,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant_menu),
          label: 'Paket',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long),
          label: 'Pesanan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profil',
        ),
      ],
    );
  }
}
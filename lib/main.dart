import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_preview/device_preview.dart';

import 'core/theme/app_theme.dart';
import 'features/splash/presentation/screens/splash_screen.dart';
import 'features/detail_paket/presentation/screens/detail_pesanan_page.dart';
import 'features/chat/presentation/screens/chat_admin_screen.dart';
import 'pembayaran.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Mengunci orientasi ke portrait untuk konsistensi layout mobile
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Status bar transparan agar visual layar penuh bersih
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyummyApp(),
    ),
  );
}

const Color primaryBlue = Color(0xFF1748D8);
const Color lightBlue = Color(0xFF7898D1);
const Color backgroundColor = Color(0xFFF8F9FC);

const Color biru = Color(0xFF2055D6);
const Color navy = Color.fromARGB(255, 2, 50, 155);
const Color latar = Color(0xFFF0F4FF);

const int hargaPaket = 250000;
const int penyesuaianMenu = 176000;
const int hargaTambahan = 25000;

String rupiah(int angka) {
  return 'Rp${angka.toString().replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
    (m) => '${m[1]}.',
  )}';
}

class MyummyApp extends StatelessWidget {
  const MyummyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'myummy',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}

class FoodItem {
  final String name;
  final String price;
  final String rating;
  final String image;

  const FoodItem({
    required this.name,
    required this.price,
    required this.rating,
    required this.image,
  });
}

const List<FoodItem> bestSellers = [
  FoodItem(
    name: 'Ayam Teriyaki',
    price: 'Rp 25.000',
    rating: '4.8',
    image: 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=500',
  ),
  FoodItem(
    name: 'Beef Teriyaki',
    price: 'Rp 25.000',
    rating: '4.9',
    image: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=500',
  ),
  FoodItem(
    name: 'Ikan Asam Manis',
    price: 'Rp 25.000',
    rating: '4.7',
    image: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=500',
  ),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<String> pageTitles = [
    'Home',
    'Paket',
    'Pesanan',
    'Profil',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: IndexedStack(
          index: selectedIndex,
          children: [
            _buildHome(),
            _buildPackagePage(),
            const RingkasanPesananPage(), // Menggunakan halaman ringkasan pesanan
            _buildProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildHome() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 12),
          _buildGreeting(),
          const SizedBox(height: 12),
          _buildBanner(),
          const SizedBox(height: 10),
          _buildSectionTitle(
            'Menu Best Seller',
            'Lihat Semua',
            () => _showAllMenus(),
          ),
          const SizedBox(height: 8),
          _buildBestSellerList(),
          const SizedBox(height: 18),
          _buildSectionTitle(
            'Paket Tersedia',
            'Lihat paket ›',
            () => setState(() => selectedIndex = 1),
          ),
          const SizedBox(height: 10),
          _buildPackageList(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.orange,
            size: 25,
          ),
        ),
        const Spacer(),
        IconButton(
          tooltip: 'Chat dengan Admin',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ChatAdminScreen(),
              ),
            );
          },
          icon: const Icon(
            Icons.chat_outlined,
            color: primaryBlue,
            size: 25,
          ),
        ),
        IconButton(
          tooltip: 'Notifikasi',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Belum ada notifikasi baru.'),
              ),
            );
          },
          icon: const Icon(
            Icons.notifications_active,
            color: Colors.amber,
            size: 25,
          ),
        ),
      ],
    );
  }

  Widget _buildGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "m'Yummy",
          style: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.w900,
            color: primaryBlue,
            letterSpacing: -1.5,
          ),
        ),
        const Text(
          'Makan enak, hidup produktif!',
          style: TextStyle(
            fontSize: 10,
            fontStyle: FontStyle.italic,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Expanded(
              child: Text(
                'Halo, Aya👋🏻',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        const Text(
          'Yuk pesan makanan favoritmu!',
          style: TextStyle(fontSize: 11),
        ),
      ],
    );
  }

  Widget _buildBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: 78,
        width: double.infinity,
        child: Image.network(
          'https://images.unsplash.com/photo-1547592180-85f173990554?w=1000',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFFE6ECF8),
              alignment: Alignment.center,
              child: const Icon(
                Icons.restaurant,
                size: 42,
                color: primaryBlue,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionTitle(
    String title,
    String action,
    VoidCallback onTap,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            action,
            style: const TextStyle(
              fontSize: 10,
              color: primaryBlue,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBestSellerList() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: bestSellers.map((food) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 6),
            child: _buildFoodCard(food),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFoodCard(FoodItem food) {
    return Material(
      color: Colors.white,
      elevation: 2,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => _showFoodDetail(food),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    food.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade200,
                        child: const Icon(
                          Icons.fastfood,
                          color: primaryBlue,
                          size: 30,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                food.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    size: 11,
                    color: Colors.amber,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    food.rating,
                    style: const TextStyle(fontSize: 9),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Text(
                food.price,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPackageList() {
    return Row(
      children: [
        Expanded(
          child: _buildPackageItemCard(
            'Paket',
            'Mingguan',
            Icons.restaurant,
            () => _showPackageDetail('Paket Mingguan'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildPackageItemCard(
            'Paket',
            'Bulanan',
            Icons.restaurant,
            () => _showPackageDetail('Paket Bulanan'),
          ),
        ),
      ],
    );
  }

  Widget _buildPackageItemCard(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 7,
            vertical: 11,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: lightBlue,
                child: Icon(
                  icon,
                  size: 19,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 10),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPackagePage() {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() => selectedIndex = 0);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.orange,
                  ),
                ),
                const Text(
                  'Paket Catering',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _packageTab('Mingguan')),
                      const SizedBox(width: 10),
                      Expanded(child: _packageTab('Bulanan')),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _packageCard(
                    title: 'Paket Mingguan',
                    subtitle: '10x makan (pilih menu)',
                    price: 'Rp 250.000',
                    image: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=500',
                    description:
                        'Paket catering mingguan dengan 10 kali makan. Kamu bisa memilih menu sesuai selera.',
                  ),
                  const SizedBox(height: 16),
                  _packageCard(
                    title: 'Paket Bulanan',
                    subtitle: '20x makan (pilih menu)',
                    price: 'Rp 900.000',
                    image: 'https://images.unsplash.com/photo-1490645935967-10de6ba17061?w=500',
                    description:
                        'Paket catering bulanan dengan 20 kali makan. Cocok untuk kebutuhan makan yang lebih praktis.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _packageTab(String label) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: BoxDecoration(
        color: const Color(0xFF4969DF),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _packageCard({
    required String title,
    required String subtitle,
    required String price,
    required String image,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFE7ECFF),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              image,
              width: 90,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 90,
                  height: 80,
                  color: Colors.white,
                  child: const Icon(
                    Icons.restaurant,
                    color: primaryBlue,
                    size: 35,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 9),
                ),
                const SizedBox(height: 3),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  height: 28,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _showCateringDetail(
                        title,
                        subtitle,
                        price,
                        image,
                        description,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4969DF),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    child: const Text(
                      'Lihat Detail',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCateringDetail(
    String title,
    String subtitle,
    String price,
    String image,
    String description,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    image,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 180,
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: Icon(Icons.restaurant, size: 50),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(subtitle),
                const SizedBox(height: 10),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 18,
                    color: primaryBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(description),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(sheetContext);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DetailPesananPage(),
                        ),
                      );
                    },
                    child: const Text('Pilih Paket'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigation() {
    const icons = [
      Icons.home_rounded,
      Icons.shopping_bag_outlined,
      Icons.receipt_long_outlined,
      Icons.person_outline_rounded,
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: List.generate(4, (index) {
              final isSelected = selectedIndex == index;

              return Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() => selectedIndex = index);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        icons[index],
                        size: 22,
                        color: isSelected
                            ? const Color(0xFF167B60)
                            : Colors.blueGrey.shade200,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        pageTitles[index],
                        style: TextStyle(
                          fontSize: 9,
                          color: isSelected
                              ? const Color(0xFF167B60)
                              : Colors.blueGrey.shade300,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePage() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => setState(() => selectedIndex = 0),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Profil',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 18),
            const Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Color(0xFFD9EEE7),
                  child: Icon(
                    Icons.person,
                    size: 42,
                    color: Color(0xFF287A65),
                  ),
                ),
                SizedBox(width: 13),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Aya',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'ayatam@gmail.com',
                      style: TextStyle(fontSize: 9),
                    ),
                    Text(
                      '0812 3456 7890',
                      style: TextStyle(fontSize: 9),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Divider(color: Colors.grey.shade300),
            _profileMenuItem(
              Icons.person_outline,
              'Informasi Pribadi',
              () => _showProfileDialog(
                'Informasi Pribadi',
                'Nama: Aya\nEmail: ayatam@gmail.com\nNomor telepon: 0812 3456 7890',
              ),
            ),
            _profileMenuItem(
              Icons.location_on_outlined,
              'Alamat Saya',
              () => _showProfileDialog(
                'Alamat Saya',
                'Belum ada alamat yang ditambahkan.',
              ),
            ),
            _profileMenuItem(
              Icons.credit_card_outlined,
              'Metode Pembayaran',
              () => _showProfileDialog(
                'Metode Pembayaran',
                'Belum ada metode pembayaran yang ditambahkan.',
              ),
            ),
            _profileMenuItem(
              Icons.notifications_none,
              'Notifikasi',
              () => _showProfileDialog(
                'Notifikasi',
                'Pengaturan notifikasi myummy.',
              ),
            ),
            _profileMenuItem(
              Icons.chat_outlined,
              'Chat dengan Admin',
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ChatAdminScreen(),
                ),
              ),
            ),
            _profileMenuItem(
              Icons.info_outline,
              'Tentang Aplikasi',
              () => _showProfileDialog(
                'Tentang myummy',
                'Aplikasi pemesanan makanan dan paket catering.',
              ),
            ),
            const SizedBox(height: 62),
            SizedBox(
              width: double.infinity,
              height: 43,
              child: ElevatedButton(
                onPressed: _confirmLogout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2148D8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.orange,
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

  Widget _profileMenuItem(
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 43,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 19, color: Colors.black87),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  void _showProfileDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Apakah kamu yakin ingin keluar dari akun?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              setState(() => selectedIndex = 0);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Simulasi logout selesai. Autentikasi belum terhubung.',
                  ),
                ),
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showFoodDetail(FoodItem food) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                food.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('⭐ ${food.rating}'),
              const SizedBox(height: 8),
              Text(
                food.price,
                style: const TextStyle(
                  fontSize: 18,
                  color: primaryBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() => selectedIndex = 2);
                  },
                  child: const Text('Pesan Sekarang'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPackageDetail(String packageName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(packageName),
        content: const Text(
          'Paket ini dapat digunakan untuk memilih menu makanan sesuai kebutuhanmu.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => selectedIndex = 1);
            },
            child: const Text('Lihat Paket'),
          ),
        ],
      ),
    );
  }

  void _showAllMenus() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => SizedBox(
        height: 380,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Semua Menu Favorit',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...bestSellers.map(
              (food) => ListTile(
                leading: const Icon(
                  Icons.restaurant_menu,
                  color: primaryBlue,
                ),
                title: Text(food.name),
                subtitle: Text(food.price),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pop(context);
                  _showFoodDetail(food);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget terpisah untuk tab Ringkasan Pesanan (mengintegrasikan fitur ringkasan & pembayaran)
class RingkasanPesananPage extends StatelessWidget {
  const RingkasanPesananPage({super.key});

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
          const Text('• '),
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
    final int totalHarga = hargaPaket + penyesuaianMenu + hargaTambahan;

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
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade200,
                            child: const Icon(Icons.image_not_supported),
                          );
                        },
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
            const SizedBox(height: 8),
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
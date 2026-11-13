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

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

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
            const RingkasanPesananPage(),
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
              color: const Color(
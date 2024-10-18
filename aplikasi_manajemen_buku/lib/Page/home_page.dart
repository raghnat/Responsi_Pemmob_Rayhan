import 'package:aplikasi_manajemen_buku/Page/ISBN_page.dart';
import 'package:aplikasi_manajemen_buku/Page/bahasa_page.dart';
import 'package:aplikasi_manajemen_buku/Page/genre_page.dart';
import 'package:aplikasi_manajemen_buku/Page/jumlahhalaman_page.dart';
import 'package:aplikasi_manajemen_buku/Page/lokasirak_page.dart';
import 'package:aplikasi_manajemen_buku/Page/penerbit_page.dart';
import 'package:aplikasi_manajemen_buku/Page/penulis_page.dart';
import 'package:aplikasi_manajemen_buku/Page/rating_page.dart';
import 'package:aplikasi_manajemen_buku/Page/status_page.dart';
import 'package:aplikasi_manajemen_buku/Page/tahunterbit_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String userName;

  // Constructor to receive the user's name
  const HomePage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(60.0), // Adjust the height as needed
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF6A11CB), // Start color (Blue-Purple)
                Color(0xFF2575FC), // End color (Blue)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            centerTitle: true,
            elevation: 0,
            title: const Text(
              'Home',
              style: TextStyle(color: Colors.white, fontFamily: 'Courier New'),
            ),
            backgroundColor:
                Colors.transparent, // Make AppBar background transparent
            iconTheme: const IconThemeData(color: Colors.white),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 53, 0, 122),
              ),
              child: Text(
                'Welcome, $userName!',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Courier New',
                ),
              ),
            ),
            // Menu Items
            _drawerItem(
                context, 'Genre Page', Icons.pageview, const GenrePage()),
            _drawerItem(
                context, 'Penulis Page', Icons.pages, const PenulisPage()),
            _drawerItem(
                context, 'Penerbit Page', Icons.pages, const PenerbitPage()),
            _drawerItem(context, 'Tahun Terbit Page', Icons.pages,
                const TahunterbitPage()),
            _drawerItem(context, 'ISBN Page', Icons.pages, const IsbnPage()),
            _drawerItem(context, 'Jumlah Halaman Page', Icons.pages,
                const JumlahhalamanPage()),
            _drawerItem(
                context, 'Bahasa Page', Icons.pages, const BahasaPage()),
            _drawerItem(
                context, 'Lokasi Rak Page', Icons.pages, const LokasirakPage()),
            _drawerItem(
                context, 'Status Page', Icons.pages, const StatusPage()),
            _drawerItem(
                context, 'Rating Page', Icons.pages, const RatingPage()),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width, // Full width
        height: MediaQuery.of(context).size.height, // Full heigh
        color: const Color.fromARGB(255, 53, 0, 122),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Circular Image Widget
              const CircleAvatar(
                radius: 50, // Adjust the size as needed
                backgroundImage: AssetImage(
                    'profil_image.png'), // Change to your image asset path
              ),
              const SizedBox(height: 20),
              // Welcome Text
              Text(
                'Welcome, $userName!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Courier New',
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _drawerItem(
    BuildContext context, String title, IconData icon, Widget destination) {
  return ListTile(
    leading: Icon(icon),
    title: Text(title),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destination),
      );
    },
  );
}

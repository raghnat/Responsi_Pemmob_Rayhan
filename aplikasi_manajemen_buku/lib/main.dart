import 'package:aplikasi_manajemen_buku/Page/home_page.dart';
import 'package:aplikasi_manajemen_buku/Page/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'Courier New',
    ),
    home: const LoginPage(
        //userName: 'Panji',
        ),
  ));
}

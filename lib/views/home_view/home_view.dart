import 'package:flutgpt/config/pallete.dart';
import 'package:flutgpt/views/home_view/components/home_view_body.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(appBar: appBar(), body: const HomeViewBody()),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: primaryColor,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          color: activeColor,
          height: 2,
        ),
      ),
      elevation: 0,
      leading: GestureDetector(
        onTap: () {},
        child: const Icon(
          Icons.menu,
          size: 25,
          color: Colors.white,
        ),
      ),
      title: Text(
        'New Chat',
        style: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w300,
        ),
      ),
      centerTitle: true,
      titleSpacing: 0,
      actions: [
        GestureDetector(
          onTap: () {},
          child: const Icon(
            Icons.add,
            size: 25,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}

import 'package:flutgpt/views/home_view/components/app_drawer.dart';
import 'package:flutgpt/views/home_view/components/appbar.dart';
import 'package:flutgpt/views/home_view/components/home_view_body.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: appBar(), drawer: appDrawer(), body: const HomeViewBody()),
    );
  }
}

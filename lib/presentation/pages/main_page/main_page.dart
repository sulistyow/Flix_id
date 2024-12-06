import 'dart:io';

import 'package:flix_id/domain/entities/user.dart';
import 'package:flix_id/presentation/extensions/build_context_extension.dart';
import 'package:flix_id/presentation/pages/movie_page/movie_page.dart';
import 'package:flix_id/presentation/pages/profile_page/profile_page.dart';
import 'package:flix_id/presentation/pages/ticket_page/ticket_page.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_id/presentation/widgets/bottom_nav_bar.dart';
import 'package:flix_id/presentation/widgets/bottom_navbar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerStatefulWidget {
  final File? imageFile;

  const MainPage({this.imageFile, super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  PageController pageController = PageController();
  int selectedPage = 0;

  @override
  void initState() {
    super.initState();

    User? user = ref.read(userDataProvider).valueOrNull;

    if (widget.imageFile != null && user != null) {
      ref
          .read(userDataProvider.notifier)
          .uploadProfilePicture(user: user, imageFile: widget.imageFile!);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(userDataProvider, (previous, next) {
      if (previous != null && next is AsyncData && next.value == null) {
        ref.read(routerProvider).goNamed('login');
      } else if (next is AsyncError) {
        context.showSnackBar(next.error.toString());
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (value) => setState(() {
              selectedPage = value;
            }),
            children: [
              Center(
                child: MoviePage(),
              ),
              Center(
                child: TicketPage(),
              ),
              Center(
                child: ProfilePage(),
              ),
            ],
          ),
          BottomNavBar(
            items: [
              BottomNavbarItem(
                  index: 0,
                  isSelected: selectedPage == 0,
                  title: 'Home',
                  image: 'assets/movie.png',
                  selectedImage: 'assets/movie-selected.png'),
              BottomNavbarItem(
                  index: 1,
                  isSelected: selectedPage == 1,
                  title: 'Ticket',
                  image: 'assets/ticket.png',
                  selectedImage: 'assets/ticket-selected.png'),
              BottomNavbarItem(
                  index: 2,
                  isSelected: selectedPage == 2,
                  title: 'Profile',
                  image: 'assets/profile.png',
                  selectedImage: 'assets/profile-selected.png'),
            ],
            onTap: (index) {
              selectedPage = index;

              pageController.animateToPage(selectedPage,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut);
            },
            selectedIndex: 0,
          ),
        ],
      ),
    );
  }
}

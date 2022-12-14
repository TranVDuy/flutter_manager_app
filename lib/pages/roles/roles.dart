import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_manager/pages/roles/carousel/carousel.dart';
import 'package:product_manager/pages/roles/roles_controller.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/cupertino.dart';

import '../../app_properties.dart';
import '../../model/role.dart';
import 'appinio_swiper/appinio_card.dart';

class RolesPage extends StatelessWidget {
  var controller = Get.find<RolesController>();
  final AppinioSwiperController AppinioController = AppinioSwiperController();
  List<AppinioCard> cards = [];

  void _loadCards() {
    for (Role role in roles) {
      cards.add(
        AppinioCard(
          role: role,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadCards();
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: false,
        child: Container(
          margin: const EdgeInsets.only(top: kToolbarHeight),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Carousel(),
                const Text(
                  'Roles',
                  style: TextStyle(
                    color: darkGrey,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CupertinoPageScaffold(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 350,
                        child: AppinioSwiper(
                          unlimitedUnswipe: true,
                          controller: AppinioController,
                          cards: cards,
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                            top: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

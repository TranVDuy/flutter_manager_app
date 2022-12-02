import 'package:flutter/material.dart';
import 'package:product_manager/app_properties.dart';
import 'package:product_manager/model/carousel_item.dart';

import '../../../model/category.dart';
import 'carousel_widget.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late final List<CarouselItem> specials = homeCarouselItems;

  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTitle(),
        const SizedBox(height: 24),
        Stack(children: [
          Container(
            height: 181,
            decoration: const BoxDecoration(
              color: Color(0xFFE7E7E7),
              borderRadius: BorderRadius.all(Radius.circular(32)),
            ),
            child: PageView.builder(
              itemBuilder: (context, index) {
                final data = specials[index];
                return CarouselWidget(context, data: data, index: index);
              },
              itemCount: specials.length,
              allowImplicitScrolling: true,
              onPageChanged: (value) {
                setState(() => selectIndex = value);
              },
            ),
          ),
          _buildPageIndicator()
        ]),
        const SizedBox(height: 24),
        // GridView.builder(
        //   physics: const NeverScrollableScrollPhysics(),
        //   shrinkWrap: true,
        //   itemCount: categories.length,
        //   scrollDirection: Axis.vertical,
        //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        //     mainAxisExtent: 100,
        //     mainAxisSpacing: 24,
        //     crossAxisSpacing: 24,
        //     maxCrossAxisExtent: 77,
        //   ),
        //   itemBuilder: ((context, index) {
        //     final data = categories[index];
        //     return GestureDetector(
        //       onTap: () =>
        //           Navigator.pushNamed(context, MostPopularScreen.route()),
        //       child: Column(
        //         children: [
        //           Container(
        //             decoration: BoxDecoration(
        //               color: const Color(0x10101014),
        //               borderRadius: BorderRadius.circular(30),
        //             ),
        //             child: Padding(
        //               padding: const EdgeInsets.all(16),
        //               child: Image.asset(data.icon, width: 28, height: 28),
        //             ),
        //           ),
        //           const SizedBox(height: 12),
        //           FittedBox(
        //             child: Text(
        //               data.title,
        //               style: const TextStyle(
        //                   color: Color(0xff424242),
        //                   fontWeight: FontWeight.bold,
        //                   fontSize: 16),
        //             ),
        //           ),
        //         ],
        //       ),
        //     );
        //   }),
        // )
      ],
    );
  }

  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Special Offers',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: titleColor),
        ),
      ],
    );
  }

  Widget _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < specials.length; i++) {
      list.add(i == selectIndex ? _indicator(true) : _indicator(false));
    }
    return Container(
      height: 181,
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: list,
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return SizedBox(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        height: 4.0,
        width: isActive ? 16 : 4.0,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(2)),
          color: isActive ? const Color(0XFF101010) : const Color(0xFFBDBDBD),
        ),
      ),
    );
  }
}

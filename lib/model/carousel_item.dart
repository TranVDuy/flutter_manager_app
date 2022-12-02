class CarouselItem {
  final String discount;
  final String title;
  final String detail;
  final String icon;

  CarouselItem({
    required this.discount,
    required this.title,
    required this.detail,
    required this.icon,
  });
}

final homeCarouselItems = <CarouselItem>[
  CarouselItem(
    discount: '25%',
    title: "Today’s Special!",
    detail: 'Get discount for every order, only valid for today',
    icon: 'assets/sofa.png',
  ),
  CarouselItem(
    discount: '35%',
    title: "Tomorrow will be better!",
    detail: 'Please give us a star!',
    icon: 'assets/shiny_chair.png',
  ),
  CarouselItem(
    discount: '100%',
    title: "Not discount today!",
    detail: 'If you have any problem, contact us',
    icon: 'assets/lamp.png',
  ),
  CarouselItem(
    discount: '75%',
    title: "It's for you!",
    detail: 'Wish you have a funny time',
    icon: 'assets/plastic_chair@2x.png',
  ),
  CarouselItem(
    discount: '65%',
    title: "Make yourself at home!",
    detail: 'If you have any confuse, let we now',
    icon: 'assets/book_case@2x.png',
  ),
];

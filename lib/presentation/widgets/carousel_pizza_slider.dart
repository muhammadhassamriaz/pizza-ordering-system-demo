import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pizza/domain/entities/pizza.dart';
import 'package:pizza/presentation/providers/pizza_provider.dart';
import 'package:pizza/utils/constants.dart';
import 'package:provider/provider.dart';

class CarouselPizzaSlider extends StatefulWidget {
  final Pizza pizza;
  const CarouselPizzaSlider({super.key, required this.pizza});

  @override
  State<CarouselPizzaSlider> createState() => _CarouselPizzaSliderState();
}

class _CarouselPizzaSliderState extends State<CarouselPizzaSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          carouselController: context.watch<PizzaProvider>().controller,
          options: CarouselOptions(
            autoPlay: false,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            viewportFraction: 0.6,
            onPageChanged: (index, reason) {
              context.read<PizzaProvider>().pizzaSelectionIndex(index);
            },
          ),
          items: context
              .watch<PizzaProvider>()
              .pizzaSizes
              .map(
                (item) => Center(
                  child: Image.asset(
                    widget.pizza.image,
                    fit: BoxFit.cover,
                    width: widget.pizza.copyWith(pizzaSize: item).imageSize,
                  ),
                ),
              )
              .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: context
              .watch<PizzaProvider>()
              .pizzaSizes
              .asMap()
              .entries
              .map((entry) {
            return GestureDetector(
              onTap: () {
                context
                    .read<PizzaProvider>()
                    .controller
                    .animateToPage(entry.key);
              },
              child: Container(
                width: 12.0.w,
                height: 12.0.w,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Color(Constants.kPrimaryColor))
                      .withOpacity(
                    context.watch<PizzaProvider>().current == entry.key
                        ? 0.9
                        : 0.4,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

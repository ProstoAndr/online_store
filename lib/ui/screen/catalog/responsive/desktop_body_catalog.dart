import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:online_store/ui/screen/catalog/cubit/catalog_cubit.dart';
import 'package:online_store/ui/screen/catalog/cubit/catalog_state.dart';
import 'package:online_store/ui/widget/custom_conteiner.dart';

class CatalogDesktopBody extends StatefulWidget {
  const CatalogDesktopBody({super.key});

  @override
  State<CatalogDesktopBody> createState() => _CatalogDesktopBodyState();
}

class _CatalogDesktopBodyState extends State<CatalogDesktopBody> {
  int _currentCarouselIndex = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogCubit, CatalogState>(
      builder: (context, state) {
        if (state is Loaded) {
          final screenWidth = MediaQuery.of(context).size.width;
          final viewportFraction = screenWidth > 1500
              ? 0.144
              : screenWidth > 1000
                  ? 0.184
                  : screenWidth > 850
                      ? 0.26
                      : screenWidth > 800
                          ? 0.3
                          : 0.47;
          final bestSellers = state.hits;
          final newItems = state.newProducts;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Text(
                        'Хиты продаж',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        'Смотреть все',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          context.go('/product/${bestSellers.first.id}');
                        },
                        child: CustomContainer(
                          width: 400,
                          height: 516,
                          item: bestSellers.first,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Wrap(
                          runSpacing: 16,
                          alignment: WrapAlignment.start,
                          children: bestSellers.asMap().entries.map(
                            (entry) {
                              final index = entry.key;
                              final item = entry.value;
                              if (index == 0) {
                                return const SizedBox.shrink();
                              } else if (index == 3) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: InkWell(
                                    onTap: () {
                                      context.go('/product/${item.id}');
                                    },
                                    child: CustomContainer(
                                      width: 416,
                                      height: 250,
                                      item: item,
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: InkWell(
                                    onTap: () {
                                      context.go('/product/${item.id}');
                                    },
                                    child: CustomContainer(
                                      width: 200,
                                      height: 250,
                                      item: item,
                                    ),
                                  ),
                                );
                              }
                            },
                          ).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Лучшие новинки',
                            style: TextStyle(fontSize: 24),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            'Смотреть все',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              setState(
                                () {
                                  _carouselController.previousPage();
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: () {
                              setState(
                                () {
                                  _carouselController.nextPage();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CarouselSlider.builder(
                    carouselController: _carouselController,
                    itemCount: newItems.length,
                    itemBuilder: (context, index, realIndex) {
                      return InkWell(
                        onTap: () {
                          context.go('/product/${newItems[index].id}');
                        },
                        child: CustomContainer(
                          width: 200,
                          height: 250,
                          item: newItems[index],
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 250,
                      viewportFraction: viewportFraction,
                      initialPage: _currentCarouselIndex,
                      onPageChanged: (index, reason) {
                        setState(
                          () {
                            _currentCarouselIndex = index;
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is Error) {
          return Text('Ошибка: ${state.errorMessage}');
        }
        return const SizedBox();
      },
    );
  }
}

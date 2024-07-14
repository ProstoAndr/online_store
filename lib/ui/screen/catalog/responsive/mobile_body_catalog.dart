import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:online_store/ui/screen/catalog/cubit/catalog_cubit.dart';
import 'package:online_store/ui/screen/catalog/cubit/catalog_state.dart';
import 'package:online_store/ui/widget/custom_conteiner.dart';

class CatalogMobileBody extends StatefulWidget {
  const CatalogMobileBody({super.key});

  @override
  State<CatalogMobileBody> createState() => _CatalogMobileBodyState();
}

class _CatalogMobileBodyState extends State<CatalogMobileBody> {
  int _currentCarouselIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogCubit, CatalogState>(
        builder: (context, state) {
          if (state is Loaded) {
            final bestSellers = state.hits;
            final newItems = state.newProducts;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    Wrap(
                      runSpacing: 16,
                      alignment: WrapAlignment.start,
                      children: bestSellers.map((item) {
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
                      ).toList(),
                    ),
                    const SizedBox(height: 32),
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
                    const SizedBox(height: 16),
                    CarouselSlider.builder(
                      itemCount: newItems.length,
                      itemBuilder: (context, index, realIndex) {
                        return InkWell(
                          onTap: () {
                            context.go('/product/:${newItems[index].id}');
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
                        viewportFraction: 0.474,
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
        }
    );
  }

}

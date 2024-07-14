import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_store/ui/screen/product/bloc/product_cubit.dart';
import 'package:online_store/ui/screen/product/bloc/product_state.dart';

class MobileBodyProduct extends StatefulWidget {
  const MobileBodyProduct({super.key});

  @override
  State<MobileBodyProduct> createState() => _MobileBodyProductState();
}

class _MobileBodyProductState extends State<MobileBodyProduct> {
  int _currentImageIndex = 0;

  void _previousImage(List<String> images) {
    setState(() {
      _currentImageIndex =
          (_currentImageIndex - 1 + images.length) % images.length;
    });
  }

  void _nextImage(List<String> images) {
    setState(() {
      _currentImageIndex = (_currentImageIndex + 1) % images.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    int currentCarouselIndex = 0;

    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is Loaded) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Каталог — Категория — Название товара',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: Image.network(
                                state.product.images.first,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.product.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  state.product.category,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('${state.product.rating}',
                                style: const TextStyle(fontSize: 24)),
                            const SizedBox(width: 8),
                            const Column(
                              children: [
                                Text('Общий рейтинг',
                                    style: TextStyle(fontSize: 12)),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 24,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 24,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 24,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 24,
                                    ),
                                    Icon(
                                      Icons.star_half,
                                      color: Colors.yellow,
                                      size: 24,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            // Add to wishlist logic
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black,
                            side: const BorderSide(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Добавить в Желамое'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Purchase logic
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black54,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Купить ${state.product.price} ₽',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          constraints: const BoxConstraints(maxHeight: 300),
                          child: AspectRatio(
                            aspectRatio: 1.5,
                            child: Image.network(
                                state.product.images[_currentImageIndex]),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () =>
                                _previousImage(state.product.images),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: () => _nextImage(state.product.images),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                CarouselSlider.builder(
                  itemCount: state.product.images.length,
                  itemBuilder: (context, index, realIndex) {
                    return GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            _currentImageIndex = index;
                          },
                        );
                      },
                      child: SizedBox(
                        width: 100,
                        height: 50,
                        child: Image.network(
                          state.product.images[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    reverse: true,
                    height: 50,
                    viewportFraction: 0.24,
                    initialPage: currentCarouselIndex,
                    onPageChanged: (index, reason) {
                      setState(
                        () {
                          currentCarouselIndex = index;
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Описание товара',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  state.product.description,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        }
        if (state is Error) {
          return Center(child: Text('Ошибка: ${state.errorMessage}'));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

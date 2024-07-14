import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_store/ui/screen/product/bloc/product_cubit.dart';
import 'package:online_store/ui/screen/product/bloc/product_state.dart';

class DesktopBodyProduct extends StatefulWidget {
  const DesktopBodyProduct({super.key});

  @override
  State<DesktopBodyProduct> createState() => _DesktopBodyProductState();
}

class _DesktopBodyProductState extends State<DesktopBodyProduct> {
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
                        const SizedBox(width: 16),
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Center(
                            child: SizedBox(
                              height: 500,
                              child: Image.network(
                                state.product.images[_currentImageIndex],
                                fit: BoxFit.cover,
                              ),
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
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 500,
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: state.product.images.map((image) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _currentImageIndex =
                                    state.product.images.indexOf(image);
                              });
                            },
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.network(
                                image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Описание товара',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.product.description,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('${state.product.rating}',
                            style: const TextStyle(fontSize: 64)),
                        const SizedBox(width: 8),
                        const Column(
                          children: [
                            Text('Общий рейтинг',
                                style: TextStyle(fontSize: 16)),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 64,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 64,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 64,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 64,
                                ),
                                Icon(
                                  Icons.star_half,
                                  color: Colors.yellow,
                                  size: 64,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
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

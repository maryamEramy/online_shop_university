import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/controllers/product_provider.dart';
import 'package:uni_online_shop/views/shared/body_ui.dart';
import '../../controllers/constant.dart';
import '../../controllers/favorites_provider.dart';
import '../../models/sneakers_model.dart';
import '../shared/product_view.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.id, required this.category});

  final String id;
  final String category;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with SingleTickerProviderStateMixin {
  late final Future<ProductInfo> _productFuture;
  late final AnimationController _controller;
  late final Animation<double> _animation;
  late final Animation<Color?> _backgroundAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.decelerate);
    _backgroundAnimation = ColorTween(
      begin: kPrimaryColor,
      end: kLightSecondaryColor,
    ).animate(_controller);

    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });

    _loadProduct();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FavoritesProvider>(context, listen: false).getFavorites();
    });
  }

  void _loadProduct() {
    final productNotifier = Provider.of<ProductProvider>(
      context,
      listen: false,
    );
    _productFuture = productNotifier.getProduct(widget.category, widget.id);

    _productFuture.then((product) {
      if (mounted) {
        precacheImage(NetworkImage(product.imageUrl), context);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProductInfo>(
      future: _productFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return BodyUi(
            children: [
              Center(child: CircularProgressIndicator(color: kSecondaryColor)),
            ],
          );
        } else if (snapshot.hasError) {
          debugPrint('Error loading product: ${snapshot.error}');
          return BodyUi(
            children: [
              Center(
                child: Text("Error: ${snapshot.error}", style: kErrorTextStyle),
              ),
            ],
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const BodyUi(
            children: [Center(child: Text("No product found"))],
          );
        } else {
          final product = snapshot.data!;
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return BodyUi(
                backgroundColor: _backgroundAnimation.value,
                headerTitle: product.name,
                showBackIcon: true,
                showBasketIcon: true,
                children: [
                  Expanded(
                    child: ProductView(
                      product: product,
                      animation: _animation,
                      productId: widget.id,
                    ),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}

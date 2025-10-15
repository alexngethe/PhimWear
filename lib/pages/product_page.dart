import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../utils/currency_helper.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int _quantity = 1;
  int _selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 800;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: isWide ? _buildWideLayout(product, cart) : _buildNarrowLayout(product, cart),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNarrowLayout(Product product, CartProvider cart) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImageGallery(product),
        const SizedBox(height: 24),
        _buildProductInfo(product),
        const SizedBox(height: 24),
        _buildQuantitySelector(),
        const SizedBox(height: 24),
        _buildAddToCartButton(product, cart),
      ],
    );
  }

  Widget _buildWideLayout(Product product, CartProvider cart) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: _buildImageGallery(product),
        ),
        const SizedBox(width: 48),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductInfo(product),
              const SizedBox(height: 24),
              _buildQuantitySelector(),
              const SizedBox(height: 24),
              _buildAddToCartButton(product, cart),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImageGallery(Product product) {
    final images = product.images.isNotEmpty ? product.images : [product.imageUrl];

    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: images[_selectedImageIndex],
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey.shade200,
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey.shade200,
                child: const Icon(Icons.error),
              ),
            ),
          ),
        ),
        if (images.length > 1) ...[
          const SizedBox(height: 16),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedImageIndex = index;
                    });
                  },
                  child: Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _selectedImageIndex == index
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey.shade300,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: CachedNetworkImage(
                        imageUrl: images[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildProductInfo(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          CurrencyHelper.format(product.price),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        if (product.tags.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: product.tags.map((tag) {
              return Chip(
                label: Text(tag),
                backgroundColor: Colors.grey.shade100,
                labelStyle: const TextStyle(fontSize: 12),
              );
            }).toList(),
          ),
        const SizedBox(height: 16),
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          product.description,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade700,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Icon(
              product.stock > 0 ? Icons.check_circle : Icons.cancel,
              color: product.stock > 0 ? Colors.green : Colors.red,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              product.stock > 0 ? 'In Stock (${product.stock} available)' : 'Out of Stock',
              style: TextStyle(
                color: product.stock > 0 ? Colors.green : Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuantitySelector() {
    return Row(
      children: [
        const Text(
          'Quantity:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(width: 16),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: _quantity > 1
                    ? () => setState(() => _quantity--)
                    : null,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '$_quantity',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => setState(() => _quantity++),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddToCartButton(Product product, CartProvider cart) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: product.stock > 0
            ? () {
                cart.addItem(product, quantity: _quantity);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.name} added to cart'),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'View Cart',
                      onPressed: () => Navigator.pushNamed(context, '/cart'),
                    ),
                  ),
                );
                setState(() => _quantity = 1);
              }
            : null,
        icon: const Icon(Icons.add_shopping_cart),
        label: const Text('Add to Cart', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paytimate',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const ProductsPage(),
    );
  }
}

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  String searchQuery = '';

  final List<String> products = ['Milk', 'Bread', 'Eggs', 'Coffee', 'Biscuits'];

  final Map<String, double> prices = {
    'Milk': 60,
    'Bread': 40,
    'Eggs': 80,
    'Coffee': 150,
    'Biscuits': 30,
  };

  final Map<String, int> cart = {};

  double get total {
    double sum = 0;

    for (String product in cart.keys) {
      sum += prices[product]! * cart[product]!;
    }

    return sum;
  }

  int get quantity {
    int sum = 0;

    for (String product in cart.keys) {
      sum += cart[product]!;
    }

    return sum;
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products
        .where(
          (product) =>
              product.toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 2,
        title: const Text(
          'Paytimate',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '$quantity items',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Products',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final item = filteredProducts[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Text(
                        item,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '₹${prices[item]!.toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 12),
                          cart.containsKey(item)
                              ? Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (cart[item]! > 1) {
                                            cart[item] = cart[item]! - 1;
                                          } else {
                                            cart.remove(item);
                                          }
                                        });
                                      },
                                      icon: const Icon(Icons.remove),
                                    ),
                                    Text('${cart[item] ?? 0}'),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          cart[item] = (cart[item] ?? 0) + 1;
                                        });
                                      },
                                      icon: const Icon(Icons.add),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                        ],
                      ),

                      onTap: () {
                        setState(() {
                          cart[item] = (cart[item] ?? 0) + 1;
                        });
                      },
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cart: $quantity items ',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' Total: ₹${total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),

            ElevatedButton(
              onPressed: cart.isEmpty
                  ? null
                  : () {
                      setState(() {
                        cart.clear();
                      });
                    },
              child: const Text('Clear Cart'),
            ),
          ],
        ),
      ),
    );
  }
}

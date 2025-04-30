import 'package:flutter/material.dart';

class Category {
  final String name;
  final IconData icon;
  final List<Product> products;

  Category({required this.name, required this.icon, required this.products});
}

class Product {
  final String name;
  final String price;
  final IconData icon;

  Product({required this.name, required this.price, required this.icon});
}

class EshopPage extends StatefulWidget {
  @override
  _EshopPageState createState() => _EshopPageState();
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class _EshopPageState extends State<EshopPage> {
  List<Category> categories = [
    Category(
      name: 'Technology',
      icon: Icons.computer,
      products: [
        Product(name: 'Smartphone', price: '\$999', icon: Icons.phone),
        Product(name: 'Monitor', price: '\$299', icon: Icons.desktop_windows),
        Product(name: 'Graphics Card', price: '\$499', icon: Icons.ondemand_video),
      ],
    ),
    Category(
      name: 'Home',
      icon: Icons.home,
      products: [
        Product(name: 'Sofa', price: '\$899', icon: Icons.weekend),
        Product(name: 'Coffee Table', price: '\$199', icon: Icons.local_cafe),
        Product(name: 'TV', price: '\$299', icon: Icons.tv),
      ],
    ),
    Category(
      name: 'Sports',
      icon: Icons.sports_soccer,
      products: [
        Product(name: 'Football', price: '\$19.99', icon: Icons.sports_football),
        Product(name: 'Basketball', price: '\$14.99', icon: Icons.sports_basketball),
        Product(name: 'Tennis Racket', price: '\$39.99', icon: Icons.sports_tennis),
      ],
    ),
    Category(
      name: 'Health',
      icon: Icons.favorite,
      products: [
        Product(name: 'Vitamin C', price: '\$9.99', icon: Icons.local_hospital),
        Product(name: 'Protein Powder', price: '\$24.99', icon: Icons.fitness_center),
        Product(name: 'Fitness Band', price: '\$49.99', icon: Icons.directions_walk),
      ],
    ),
  ];

  List<Product> selectedProducts = [];
  List<CartItem> cartItems = [];
  int cartItemsCount = 0;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-shop'),
        actions: [
          _buildCartMenu(),
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              _showInformationDialog(context);
            },
            padding: EdgeInsets.only(right: 16.0, left: 16.0),
          ),
        ],
        
      ),
      body: Row(
        children: [
          Container(
            width: 200,
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                Category category = categories[index];
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(category.icon),
                      title: Text(
                        category.name,
                        style: TextStyle(
                          color: selectedIndex == index
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).textTheme.bodyText1!.color,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          selectedProducts = category.products;
                          cartItems.clear();
                          cartItemsCount = 0;
                        });
                      },
                    ),
                    if (index != categories.length - 1)
                      Divider(
                        indent: 16,
                        endIndent: 16,
                      ),
                  ],
                );
              },
            ),
          ),
          VerticalDivider(),
          Expanded(
            child: ListView.builder(
              itemCount: selectedProducts.length,
              itemBuilder: (context, index) {
                Product product = selectedProducts[index];
                return ListTile(
                  leading: Icon(product.icon),
                  title: Text(product.name),
                  subtitle: Text(product.price),
                  trailing: IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      _addToCart(product);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addToCart(Product product) {
    setState(() {
      bool productExistsInCart = false;

      for (var cartItem in cartItems) {
        if (cartItem.product == product) {
          cartItem.quantity++;
          productExistsInCart = true;
          break;
        }
      }

      if (!productExistsInCart) {
        cartItems.add(CartItem(product: product, quantity: 1));
      }

      cartItemsCount++;
    });
  }

  Widget _buildCartMenu() {
    List<CartItem> selectedCartItems = cartItems
        .where((item) => selectedProducts.contains(item.product))
        .toList();

    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('Cart'),
                  subtitle: Text('There are $cartItemsCount items in your cart'),
                ),
                Divider(),
                if (selectedCartItems.isNotEmpty)
                  Column(
                    children: selectedCartItems
                        .map(
                          (cartItem) => ListTile(
                            title: Row(
                              children: [
                                Icon(cartItem.product.icon),
                                SizedBox(width: 8),
                                Text(cartItem.product.name),
                              ],
                            ),
                            subtitle: Text(cartItem.product.price),
                            trailing: Text('Quantity: ${cartItem.quantity}'),
                          ),
                        )
                        .toList(),
                  ),
                if (selectedCartItems.isEmpty)
                  ListTile(
                    title: Text('No items in cart'),
                  ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text('Order Now'),
                    ),
                    SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ];
      },
      icon: Stack(
        children: [
          Icon(Icons.shopping_cart),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                cartItemsCount.toString(),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _showInformationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Page Information'),
        content: SingleChildScrollView(
          child: Container(
            width: 400.0, // Adjust the width as needed
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to the E-shop Page!',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}
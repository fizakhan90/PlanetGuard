import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Product> products = [
    Product('Plastic Bottle', 'assets/appimagebottle.PNG'),
    Product('Toothbrush', 'assets/toothbrush-removebg-preview.png'),
    Product('Plastic Straws', 'assets/straw.png'),
    Product('Plastic Cutlery', 'assets/plasticcutlery.jpg'),
    Product('Plastic Bag', 'assets/plasticbag.png'),
    Product("Plastic Wrap", 'assets/plasticwrap.png'),
    Product("Wet Wipes", 'assets/wetwipesimage.png'),
    Product("Cotton Buds", 'assets/cottonbuds.png'),
    Product("Razor", 'assets/razorimage.jpg'),
    Product("Hair Brushes and Combs", 'assets/hairbrush.png'),
    Product("Tampons and Pads", 'assets/products3.jpg'),
    Product("Toilet Paper", 'assets/toiletpaper.jpg'),
  ];

  List<Product> completedProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              Navigator.pushNamed(context, '/profile', arguments: completedProducts);
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: products[index],
            onTap: () {
              _showDialog(context, products[index]);
            },
            onCompleted: () {
              setState(() {
                completedProducts.add(products[index]);
              });
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _navigateToPage(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Marketplace',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
        ],
      ),
    );
  }

  void _navigateToPage(int index) {
    if (index == 0) {
      Navigator.pushNamed(context as BuildContext, '/profile', arguments: completedProducts);
    } else if (index == 1) {
      Navigator.pushNamed(context as BuildContext, '/marketplace');
    } else if (index == 2) {
      // Navigate to Home Page (current page)
    }
  }

  void _showDialog(BuildContext context, Product selectedProduct) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(selectedProduct.name),
          content: Text(_getContentForProduct(selectedProduct)),
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

  String _getContentForProduct(Product product) {
    // Define content for each product
    Map<String, String> productContent = {
      'Plastic Bottle': 'Content for Plastic Bottle',
      'Toothbrush': 'Content for Toothbrush',
      'Plastic Straws': 'Content for Plastic Straws',
      'Plastic Cutlery': 'Content for Plastic Cutlery',
      'Plastic Bag': 'Content for Plastic Bag',
      'Plastic Wrap': 'Content for Plastic Wrap',
      'Wet Wipes': 'Content for Wet Wipes',
      'Cotton Buds': 'Content for Cotton Buds',
      'Razor': 'Content for Razor',
      'Hair Brushes and Combs': 'Content for Hair Brushes and Combs',
      'Tampons and Pads': 'Content for Tampons and Pads',
      'Toilet Paper': 'Content for Toilet Paper',
    };

    return productContent[product.name] ?? 'Default content for unknown product';
  }
}

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Product> completedProducts =
        ModalRoute.of(context)?.settings.arguments as List<Product>? ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Completed Products'),
      ),
      body: ListView.builder(
        itemCount: completedProducts.length,
        itemBuilder: (context, index) {
          return ProductCard(product: completedProducts[index]);
        },
      ),
    );
  }
}

class Product {
  final String name;
  final String imagePath;
  bool isCompleted;

  Product(this.name, this.imagePath, {this.isCompleted = false});
}

class ProductCard extends StatefulWidget {
  final Product product;
  final Function()? onTap;
  final Function()? onCompleted;

  ProductCard({required this.product, this.onTap, this.onCompleted});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDialog(context);
      },
      onLongPress: () {
        _toggleSelection();
      },
      child: Card(
        margin: EdgeInsets.all(8.0),
        color: isSelected ? Colors.greenAccent : null,
        child: Column(
          children: [
            Image.asset(
              widget.product.imagePath,
              height: 100.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.product.name,
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(widget.product.name),
          content: Text(_getContentForProduct(widget.product)),
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

  void _toggleSelection() {
    setState(() {
      isSelected = !isSelected;
      if (isSelected && widget.onCompleted != null) {
        widget.onCompleted!();
      }
    });
  }

  String _getContentForProduct(Product product) {
    // Define content for each product
    Map<String, String> productContent = {
      'Plastic Bottle': 'Content for Plastic Bottle',
      'Toothbrush': 'Content for Toothbrush',
      'Plastic Straws': 'Content for Plastic Straws',
      'Plastic Cutlery': 'Content for Plastic Cutlery',
      'Plastic Bag': 'Content for Plastic Bag',
      'Plastic Wrap': 'Content for Plastic Wrap',
      'Wet Wipes': 'Content for Wet Wipes',
      'Cotton Buds': 'Content for Cotton Buds',
      'Razor': 'Content for Razor',
      'Hair Brushes and Combs': 'Content for Hair Brushes and Combs',
      'Tampons and Pads': 'Content for Tampons and Pads',
      'Toilet Paper': 'Content for Toilet Paper',
    };

    return productContent[product.name] ?? 'Default content for unknown product';
  }
}

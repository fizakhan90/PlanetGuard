import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

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
  const HomePage({super.key});

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
    Product("Plastic Wrap",'assets/plasticwrap.png'),
    Product("Wet Wipes",'assets/wetwipesimage.png'),
    Product("Cotton Buds",'assets/cottonbuds.png'),
    Product("Razor",'assets/razorimage.jpg'),
    Product("Hair Brushes and Combs",'assets/hairbrush.png'),
    Product("Tampons and Pads",'assets/products3.jpg'),
    Product("Toilet Paper",'assets/toiletpaper.jpg'),
  ];

  List<Product> completedProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              Navigator.pushNamed(context, '/profile', arguments: completedProducts);
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
        items: const [
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
      // Navigate to User Profile Page
      Navigator.pushNamed(context, '/profile', arguments: completedProducts);
    } else if (index == 1) {
      // Navigate to Marketplace Page
      Navigator.pushNamed(context, '/marketplace');
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
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  String _getContentForProduct(Product product) {
    // Define content and styles for each product
    Map<String, Tuple2<String, TextStyle>> productContent = {
      'Plastic Bottle': Tuple2('Content for Plastic Bottle', TextStyle(color: Colors.blue, fontSize: 16.0)),
      'Toothbrush': Tuple2('Content for Toothbrush', TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
      'Plastic Straws': Tuple2('Content for Plastic Straws', TextStyle(color: Colors.green, fontStyle: FontStyle.italic)),
      'Plastic Cutlery': Tuple2('Content for Plastic Cutlery', TextStyle(color: Colors.orange)),
      'Plastic Bag': Tuple2('Content for Plastic Bag', TextStyle(color: Colors.purple)),
      'Plastic Wrap': Tuple2('Content for Plastic Wrap', TextStyle(color: Colors.teal)),
      'Wet Wipes': Tuple2('Content for Wet Wipes', TextStyle(color: Colors.brown)),
      'Cotton Buds': Tuple2('Content for Cotton Buds', TextStyle(color: Colors.indigo)),
      'Razor': Tuple2('Content for Razor', TextStyle(color: Colors.pink)),
      'Hair Brushes and Combs': Tuple2('Content for Hair Brushes and Combs', TextStyle(color: Colors.amber)),
      'Tampons and Pads': Tuple2('Content for Tampons and Pads', TextStyle(color: Colors.deepPurple)),
      'Toilet Paper': Tuple2('Content for Toilet Paper', TextStyle(color: Colors.cyan)),
    };

    var contentAndStyle = productContent[product.name] ?? Tuple2('Default content for unknown product', TextStyle());

    return contentAndStyle.item1; // Returning the content part of Tuple
  }
}

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> completedProducts =
        ModalRoute.of(context)?.settings.arguments as List<Product>? ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Products'),
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
        _showDialog();
      },
      onLongPress: () {
        _toggleSelection();
      },
      child: Card(
        margin: const EdgeInsets.all(8.0),
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

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(widget.product.name),
          content: Text(
            _getContentForProduct(widget.product),
            style: _getContentStyle(widget.product),
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

  TextStyle _getContentStyle(Product product) {
    // Define content styles for each product
    Map<String, TextStyle> productStyles = {
      'Plastic Bottle': TextStyle(color: Colors.blue, fontSize: 16.0),
      'Toothbrush': TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      'Plastic Straws': TextStyle(color: Colors.green, fontStyle: FontStyle.italic),
      'Plastic Cutlery': TextStyle(color: Colors.orange),
      'Plastic Bag': TextStyle(color: Colors.purple),
      'Plastic Wrap': TextStyle(color: Colors.teal),
      'Wet Wipes': TextStyle(color: Colors.brown),
      'Cotton Buds': TextStyle(color: Colors.indigo),
      'Razor': TextStyle(color: Colors.pink),
      'Hair Brushes and Combs': TextStyle(color: Colors.amber),
      'Tampons and Pads': TextStyle(color: Colors.deepPurple),
      'Toilet Paper': TextStyle(color: Colors.cyan),
    };

    return productStyles[product.name] ?? TextStyle(); // Default style if not found
  }

  void _toggleSelection() {
    setState(() {
      isSelected = !isSelected;
      if (isSelected && widget.onCompleted != null) {
        widget.onCompleted!();
      }
    });
  }
}

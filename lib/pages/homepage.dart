import 'package:flutter/material.dart';
import 'package:planet_guard/pages/login.dart';

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
    Product('Plastic Cutlery', 'assets/appimagebottle.PNG'),
    Product('Plastic Bag', 'assets/plasticbag.png'),
    Product("Plastic Wrap",'assets/plasticwrap.png'),
    Product("Wet Wipes",'assets/products3.jpg'),
    Product("Cotton Buds",'assets/products3.jpg'),
    Product("Razor",'assets/products3.jpg'),
    Product("Hair Brushes and Combs",'assets/products3.jpg'),
    Product("Tampons and Pads",'assets/products3.jpg'),
    Product("Toilet Paper",'assets/products3.jpg'),
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
              Navigator.pushNamed(context, '/profile',
                  arguments: completedProducts);
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
      // Navigate to User Profile Page
      Navigator.pushNamed(context as BuildContext, '/profile', arguments: completedProducts);
    } else if (index == 1) {
      // Navigate to Marketplace Page
      Navigator.pushNamed(context as BuildContext, '/marketplace');
    } else if (index == 2) {
      // Navigate to Home Page (current page)
    }
  }

      



    
  }
    void _showDialog(BuildContext context, Product selectedProduct) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(selectedProduct.name),
          content: Text('Selected Product: ${selectedProduct.name}'),
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

class UserProfile extends StatelessWidget {
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

  Product(this.name, this.imagePath,{this.isCompleted = false});
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
      child: SizedBox(
        height: 150.0, // Adjust the height of the Card
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 1, // Maintain the aspect ratio of the image
              child: Image.asset(
                widget.product.imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.product.name,
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
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
          content: Text('Selected Product: ${widget.product.name}'),
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

  void _toggleSelection() {
    setState(() {
      isSelected = !isSelected;
      if (isSelected && widget.onCompleted != null) {
        widget.onCompleted!();
      }
    });
  }
}

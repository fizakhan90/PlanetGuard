import 'package:flutter/material.dart';
import 'package:planet_guard/pages/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;

  final List<Product> products = [
    Product('Plastic Bottle', 'assets/appimagebottle.png'),
    Product('Toothbrush', 'assets/toothbrush-removebg-preview.png'),
    Product('Plastic Straws', 'assets/straw.png'),
    Product('Plastic Cutlery', 'assets/plasticcutlery.png'),
    Product('Plastic Bag', 'assets/plasticbag.png'),
    Product("Plastic Wrap",'assets/plasticwrap.png'),
    Product("Wet Wipes",'assets/wetwipesimage.png'),
    Product("Cotton Buds",'assets/cottonbuds.png'),
    Product("Razor",'assets/razorimage.jpg'),
    Product("Hair Brushes",'assets/hairbrush.png'),
    Product("Tampons and Pads",'assets/pads.png'),
    Product("Toilet Paper",'assets/toiletpaper.png'),
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
              _showAlternativesDialog(context, products[index]);
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
        selectedItemColor: const Color.fromARGB(255, 23 , 33, 7),
      ),
    );
  }

  void _navigateToPage(int index) {
    if (index == 0) {
      // Navigate to User Profile Page
      Navigator.pushNamed(context, '/profile', arguments: completedProducts);
    } else if (index == 1) {
      // Navigate to Marketplace Page
      Navigator.pushNamed(context, '/marketplace');
    } else if (index == 2) {
      // Navigate to Home Page (current page)
    }
  }
}

  void _showAlternativesDialog(BuildContext context, Product selectedProduct) {
    // Placeholder data for alternative products (replace it with your actual data)
    List<Product> alternativeProducts;

    // Determine alternative products based on the selected product
    if (selectedProduct.name == 'Product 1') {
      alternativeProducts = [
        Product('Alternative 1.1', 'assets/alternative1_1.jpg'),
        Product('Alternative 1.2', 'assets/alternative1_2.jpg'),
      ];
    } else if (selectedProduct.name == 'Product 2') {
      alternativeProducts = [
        Product('Alternative 2.1', 'assets/alternative2_1.jpg'),
        Product('Alternative 2.2', 'assets/alternative2_2.jpg'),
      ];
    } else if (selectedProduct.name == 'Product 3') {
      alternativeProducts = [
        Product('Alternative 3.1', 'assets/alternative3_1.jpg'),
        Product('Alternative 3.2', 'assets/alternative3_2.jpg'),
      ];
    } else {
      // Handle other products or set a default case
      alternativeProducts = [];
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alternatives for ${selectedProduct.name}'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Selected Product: ${selectedProduct.name}'),
              const SizedBox(height: 16.0),
              const Text('Alternatives:'),
              for (Product alternative in alternativeProducts)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${alternative.name}'),
                    const SizedBox(height: 8.0),
                  ],
                ),
              // Add more alternative product information as needed
            ],
          ),
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
      _showDialog();
    },
    onLongPress: () {
      _toggleSelection();
    },
    child: Card(
      margin: const EdgeInsets.all(8.0),
      color: isSelected ? const Color.fromARGB(200, 121, 159, 12) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16/12, // Adjust the aspect ratio as needed
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
                
              ),
              child: Image.asset(
                widget.product.imagePath,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Container(
              height: 47,
              width: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                  ), 
                color: Color.fromARGB(255, 86, 130, 20),
              ),
              child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.product.name,
                          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,           
                        ),
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
          content: Text('Selected Product: ${widget.product.name}'),
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
}

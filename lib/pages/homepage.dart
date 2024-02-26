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
        selectedItemColor: const Color.fromARGB(255, 23 , 33, 7),
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
          content: Text(selectedProduct.getContent()),
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

  String getContent() {
   
    Map<String, Tuple2<String, TextStyle>> productContent = {
      'Plastic Bottle': Tuple2('Switching to reusable stainless steel bottle, they are recyclable, light-weight and does not contribute to plastic waste',  TextStyle(color: Colors.black)),
      'Toothbrush': Tuple2('Using plastic toothbrushes not only drains the oil supply, but its also polluting our ocean and killed millions of wildlife animals every year. Switch to alternatives like bamboo and wooden toothbrushes.',  TextStyle(color: Colors.black)),
      'Plastic Straws': Tuple2('Content for Plastic Straws', TextStyle(color: Colors.black)),
      'Plastic Cutlery': Tuple2('When heated, plastic cutlery releases toxic byproducts that can contaminate food. These oligomers are harmful to both humans and the environment. The best alternative to plastic cutlery is wooden or edible cutlery.',  TextStyle(color: Colors.black)),
      'Plastic Bag': Tuple2('Plastic bags have a long-lasting environmental impact, taking up to 2000 years to decompose. Adapting to alternatives like trendy tote bags will help reduce this plastic waste.',  TextStyle(color: Colors.black)),
      'Plastic Wrap': Tuple2('Plastic wrap can leach chemicals into food, especially when in contact with fats and oils. These chemicals may disrupt hormones and affect health. Switch to alternatives like Glass Food Storage Containers or Beeswax Wraps.',  TextStyle(color: Colors.black)),
      'Wet Wipes': Tuple2('Wet Wipes are the crucial ingredient of fat-bergs(lumps of congealed waste) that often build up in sewage systems across the globe. Sticking to reusable organic cloth wipes that can be reused again.',  TextStyle(color: Colors.black)),
      'Cotton Buds': Tuple2('Plastic cotton buds break down into microplastics, which can be ingested by marine life, from the smallest phytoplankton to the largest whales. The best alternative is to use bamboo cotton buds or ear wash.',  TextStyle(color: Colors.black)),
      'Razor': Tuple2('Your grooming regime might be contributing to the 2 billion plastic razors disposed of each year. A quick fix : adapting to a metal razor.', TextStyle(color: Colors.black)),
      'Hair Brushes and Combs': Tuple2('Plastic brushes and combs take hundreds of years to break down in the environment. They persist in landfills, contributing to waste accumulation. Switch to using Wooden brushes and combs.',TextStyle(color: Colors.black)), 
      'Tampons and Pads': Tuple2('On average, a woman is estimated to use and dispose about 10,000 of these menstruation products in her lifetime. Considering that half of the population of our planet is female, imagine all the non-recyclable single use waste we are genersting. Alterntaives like Menstrual Cups and disposable pads would help reduce a lot of plastic waste.', TextStyle(color: Colors.black)),
      'Toilet Paper': Tuple2('This is a difficult object, which is usually wrapped in plastic and consumed so much. Switching to plastic-free packaging will help a lot in reducing plastic waste.', TextStyle(color: Colors.black)),
    };

    var contentAndStyle = productContent[name] ?? Tuple2('Default content for unknown product', TextStyle());

    return contentAndStyle.item1; 
  }
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
              aspectRatio: 16/12,
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
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
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
          content: Text(
            widget.product.getContent(),
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
      'Plastic Bottle': TextStyle(color: Colors.black),
      'Toothbrush': TextStyle(color: Colors.black),
      'Plastic Straws': TextStyle(color: Colors.black),
      'Plastic Cutlery': TextStyle(color: Colors.black),
      'Plastic Bag': TextStyle(color: Colors.black),
      'Plastic Wrap': TextStyle(color: Colors.black),
      'Wet Wipes': TextStyle(color: Colors.black),
      'Cotton Buds': TextStyle(color: Colors.black),
      'Razor': TextStyle(color: Colors.black),
      'Hair Brushes and Combs': TextStyle(color: Colors.black),
      'Tampons and Pads': TextStyle(color: Colors.black),
      'Toilet Paper': TextStyle(color: Colors.black),
    };

    return productStyles[product.name] ?? TextStyle(); 
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

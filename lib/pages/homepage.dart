import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Sample product data, replace it with your actual data
  final List<Product> products = [
    Product('Product 1', 'assets/product1.jpg'),
    Product('Product 2', 'assets/product2.jpg'),
    Product('Product 3', 'assets/product3.jpg'),
    // Add more products as needed
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
              Navigator.pushNamed(context, '/profile',
                  arguments: completedProducts);
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
    );
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
              SizedBox(height: 16.0),
              Text('Alternatives:'),
              for (Product alternative in alternativeProducts)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${alternative.name}'),
                    SizedBox(height: 8.0),
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
              child: Text('Close'),
            ),
          ],
        );
      },
    );
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
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      color: widget.product.isCompleted ? Colors.greenAccent : null,
      child: InkWell(
        onTap: () {
          _showTapEffect();
        },
        child: Column(
          children: [
            Image.asset(
              widget.product.imagePath,
              height: 100.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                widget.product.name,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTapEffect() {
    if (widget.onTap != null) {
      setState(() {
        widget.product.isCompleted = !widget.product.isCompleted;
      });
      widget.onTap!();
    }
  }
}

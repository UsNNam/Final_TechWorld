import 'package:flutter/material.dart';
import 'package:shop_app/service/database.dart';

class Product {
  final int id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  final bool isFavourite, isPopular;

  Product({
    required this.id,
    required this.images,
    this.colors = const [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
  });
  Map<String, dynamic>? convertProductToMap()=> {
      'id': id,
      'title': title,
      'description': description,
      'images': images,
      'colors': colors.map((color) => color.value).toList(),
      'rating': rating,
      'price': price,
      'isFavourite': isFavourite,
      'isPopular': isPopular,
    };
}

// Our demo Products

List<Product> demoProducts1 = [
  Product(
    id: 1,
    images: [
      "https://th.bing.com/th/id/R.28798000e786e7444127171a58ac8efd?rik=EbDWYOvnSXmmkQ&pid=ImgRaw&r=0",
      "https://cdn.shopify.com/s/files/1/0228/7629/1136/products/15_Real_Strix_15_G_L_1200x.png?v=1627659076",
      "https://basic-tutorials.com/wp-content/uploads/2021/06/h732.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Laptop Asus Gaming Rog Strix G15",
    price: 2099.99,
    description: "The ASUS ROG Strix G15 (G513RW) is a classic gaming model with a 15.6-inch screen. It makes use of the new AMD platform together with a GeForce RTX 3070 Ti…",
    rating: 4.5,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 2,
    images: [
      "https://i.ebayimg.com/images/g/9~0AAOSw7XFeFhCv/s-l640.png",
      "https://www.apple.com/v/mac-mini/s/images/overview/connectivity_m2_pro__gnn7r2xro62q_large_2x.jpg",
      "https://www.apple.com/v/mac-mini/s/images/overview/m2__ervje1p52cya_large_2x.png",
      "https://www.apple.com/vn/mac-mini/images/overview/versatility_audio_video__bl3nxn480hrm_large_2x.jpg"
    ],
    colors: [
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Mac mini M2 2023",
    price: 750.5,
    description: "Mac mini with M2 packs the speed you need to get more done faster. And M2 Pro takes it to a whole new level — bringing a pro chip to Mac mini for the first time...",
    rating: 4.1,
    isPopular: true,
  ),
  Product(
    id: 3,
    images: [
      "https://images.vodafone.co.uk/gbnnsauqav4t/26SnPm2B8tusEilmiZBfmh/d7e0521540f7b4c3593777adb6eb12bb/Samsung_Galaxy_Z_Flip5_mint-full-product-front-600.png",
      "https://images.samsung.com/us/smartphones/galaxy-z-flip5/images/galaxy-z-flip5-highlights-kv-a.jpg?imbypass=true",
      "https://images.samsung.com/us/smartphones/galaxy-z-flip5/images/galaxy-z-flip5-highlights-colors-mint-side.jpg?imbypass=true",
      "https://images.samsung.com/us/smartphones/galaxy-z-flip5/images/galaxy-z-flip5-highlights-colors-mint.jpg?imbypass=true",

    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "SamSung Galaxy Z Flip5",
    price: 1236.55,
    description: "With an impressive cover screen and foldable design, Galaxy Z Flip5 packs big innovation into a pocket-perfect phone....",
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 4,
    images: [
      "https://www.spelrum.net/wp-content/uploads/2020/10/Logitech-Headset.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Logitech Head",
    price: 40.20,
    description: "Experience clear video calls with a simple USB connection and a noise-canceling mic. In-line controls to adjust volume or mute without interrupting calls...",
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
];

List<Product> demoProducts = [];

void addProductToShop(){
  Product tmp = Product(
    id: 7,
    images: [
      "https://th.bing.com/th/id/R.e133e51f9a1df9f5dc7bda22b14c18c7?rik=%2bD6%2fZuyAyJLdng&pid=ImgRaw&r=0",
      "https://speedlogic.com.co/wp-content/uploads/2022/07/15234.4.png",
      "https://avitela.lt/image/cache/catalog/product-images/189/879/original/5138097e067b3659eaacec50d4f3e218-1080x1000.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: " LG UltraWide 29WQ600",
    price: 249.9,
    description: "See more and do more on this UltraWide™ Full HD (2560x1080) screen. With 33% more onscreen space in width than the FHD resolution (1920x1080) display, you can multitask effectively-without shifting through programs. …",
    rating: 4.4,
  );
  demoProducts1.add(tmp);
}

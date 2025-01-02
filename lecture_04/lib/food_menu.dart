import 'package:flutter/material.dart';

class FoodMenu extends StatefulWidget {
  const FoodMenu({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _FoodMenuState();
}

class _FoodMenuState extends State<FoodMenu> {
  int _count = 0;
  int _price = 0;

  final List<FoodMenuItem> _foodMenu = [
    FoodMenuItem(
      title: "เบอร์เกอร์แตงกวา",
      price: 50,
      image: "cucumber_burger.png",
    ),
    FoodMenuItem(title: "ออมไรซ์", price: 70, image: "omurice.png"),
    FoodMenuItem(title: "สปาเก็ตตี้", price: 80, image: "spa.png"),
    FoodMenuItem(title: "ถั่วแระ", price: 60, image: "edamame.png"),
    FoodMenuItem(title: "คุกกี้", price: 40, image: "cookies.png"),
    FoodMenuItem(title: "โดนัท", price: 40, image: "donuts.png"),
    FoodMenuItem(title: "เค้กช็อกโกแลต", price: 60, image: "cake-choco.png"),
    FoodMenuItem(title: "เค้กมัทฉะ", price: 60, image: "cake-matcha.png"),
    FoodMenuItem(
      title: "เค้กสตอเบอร์รี่",
      price: 60,
      image: "cake-strawberry.png",
    ),
    FoodMenuItem(
      title: "ไอศครีมช็อกโกแลต",
      price: 70,
      image: "icecream-chocolate.png",
    ),
    FoodMenuItem(
      title: "ไอศครีมสตอเบอร์รี่",
      price: 70,
      image: "icecream-strawberry.png",
    ),
  ];

  void addCart(FoodMenuItem item) {
    setState(() {
      _count += 1;
      _price += item.price;
    });

    // dialog show added
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(title: Text("คุณได้เพิ่ม ${item.title}"));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView.builder(
        itemCount: _foodMenu.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              "${index + 1}.${_foodMenu[index].title}",
              style: TextStyle(fontSize: 24),
            ),
            subtitle: Text("ราคา ${_foodMenu[index].price} บาท"),
            leading: Image.asset("assets/images/${_foodMenu[index].image}"),
            onTap: () => addCart(_foodMenu[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Cart"),
                content: Text("คุณได้เพิ่มรายการทั้งหมด $_count ราคา $_price"),
              );
            },
          );
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}

class FoodMenuItem {
  final String title;
  final int price;
  final String image;

  FoodMenuItem({required this.title, required this.price, this.image = ""});
}

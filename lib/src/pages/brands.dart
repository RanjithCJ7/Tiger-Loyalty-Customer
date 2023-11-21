import 'package:flutter/material.dart';
import 'package:tl_customer/const/my_appbar.dart';
import 'package:tl_customer/src/pages/deals.dart';
import 'package:tl_customer/src/pages/profile.dart';
import 'package:tl_customer/src/pages/redeem.dart';
import 'package:tl_customer/src/pages/rewards.dart';
import 'styles.dart';

class Brands extends StatefulWidget {
  @override
  _Brands_State createState() => _Brands_State();
}

class Brand_Data {
  String image;
  String name;
  String category;
  String status;

  Brand_Data({
    required this.image,
    required this.name,
    required this.category,
    required this.status,
  });
}

class _Brands_State extends State<Brands> {
  bool brands = true;

  List<Brand_Data> brand_Data = [
    Brand_Data(
        image: 'assets/pizza.png',
        name: 'Pizza Hut',
        category: 'Fast Food',
        status: 'Unfollow'),
    Brand_Data(
        image: 'assets/gsm.png',
        name: 'GSM Home',
        category: 'Shopping',
        status: 'Follow'),
    Brand_Data(
        image: 'assets/lc.png',
        name: 'LC Waikiki',
        category: 'Clothing',
        status: 'Follow'),
    Brand_Data(
        image: 'assets/smaki.png',
        name: 'Samaki Smaki',
        category: 'Restaurant ',
        status: 'Unfollow'),
  ];

  List<String> categories = [
    'Categories',
    'Shopping',
    'Supermarket',
    'Restaurant',
    'Spa',
    'Salon',
  ];

  String selectedCategory = 'Categories';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: My_AppBar(
        context,
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Brands', style: label.copyWith(color: Colors.black)),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: const Color(0XFFD9D9D9))),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/search.png'),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      width: size.width * 0.3,
                                      height: 24,
                                      child: TextField(
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 11),
                                          hintText: 'Search brand/category',
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                        style: dialogTextSm,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15.0),
                          Container(
                            decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: const Color(0XFFD9D9D9))),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: size.width * 0.2,
                                    height: 24,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: selectedCategory,
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedCategory = newValue ?? '';
                                          });
                                        },
                                        items: categories.map((category) {
                                          return DropdownMenuItem<String>(
                                              value: category,
                                              child: Text(category,
                                                  style: selectBtnBold));
                                        }).toList(),
                                        icon: Image.asset(
                                            'assets/dropdown_right.png'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      Container(
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: const Color(0xFF000000), width: 0.5),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      brands ? const Color(0xFFD9D9D9) : null,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      brands = true;
                                    });
                                  },
                                  child: Text('All', style: smText),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: brands ? null : Color(0xFFD9D9D9),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      brands = false;
                                    });
                                  },
                                  child: Text('Following', style: smText),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.separated(
                        padding: const EdgeInsets.only(top: 10),
                        shrinkWrap: true,
                        itemCount: brand_Data.length,
                        separatorBuilder: (context, index) => const Divider(
                            color: Color(0XFFD9D9D9), thickness: 1),
                        itemBuilder: (context, index) {
                          var data = brand_Data[index];
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            height: MediaQuery.of(context).size.height * 0.055,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    width: size.width * 0.14,
                                    child: Image.asset(data.image)),
                                SizedBox(
                                  width: size.width * 0.45,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(data.name, style: startText),
                                      Text(data.category, style: dialogTextSm),
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: data.status == 'Unfollow'
                                      ? unfollowBtn
                                      : followBtn,
                                  child: Text(data.status, style: approveText),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Deals(),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Image.asset('assets/deals.png',
                              color: Color.fromRGBO(0, 0, 0, 0.3)),
                          SizedBox(height: 5),
                          Text('Deals',
                              style: footerText.copyWith(
                                  color: Color.fromRGBO(0, 0, 0, 0.3))),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Rewards(),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Image.asset('assets/rewards.png',
                              color: Color.fromRGBO(0, 0, 0, 0.3)),
                          SizedBox(height: 5),
                          Text('Rewards',
                              style: footerText.copyWith(
                                  color: Color.fromRGBO(0, 0, 0, 0.3))),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset('assets/redeem.png',
                            color: Color.fromRGBO(0, 0, 0, 0.3)),
                        SizedBox(height: 5),
                        Text('Redeem',
                            style: footerText.copyWith(
                                color: Color.fromRGBO(0, 0, 0, 0.3))),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset('assets/brands.png'),
                        SizedBox(height: 5),
                        Text('Brands', style: footerText),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Profile(),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Image.asset('assets/profile.png',
                              color: Color.fromRGBO(0, 0, 0, 0.3)),
                          SizedBox(height: 5),
                          Text('Profile',
                              style: footerText.copyWith(
                                  color: Color.fromRGBO(0, 0, 0, 0.3))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

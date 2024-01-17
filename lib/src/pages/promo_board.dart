import 'package:flutter/material.dart';
import 'package:tl_customer/const/my_appbar.dart';
import 'package:tl_customer/src/pages/brands.dart';
import 'package:tl_customer/screens/profile/component/profile.dart';
import 'package:tl_customer/src/pages/redeem.dart';
import 'package:tl_customer/src/pages/rewards.dart';
import 'styles.dart';

class Promo_Board extends StatefulWidget {
  @override
  _Promo_Board_State createState() => _Promo_Board_State();
}

class Brand_Data {
  String image;
  String name;

  Brand_Data({
    required this.image,
    required this.name,
  });
}

class _Promo_Board_State extends State<Promo_Board> {
  List<Brand_Data> brand_Data = [
    Brand_Data(image: 'assets/shopping.png', name: 'Shopping'),
    Brand_Data(image: 'assets/supermarket.png', name: 'Supermarket'),
    Brand_Data(image: 'assets/restaurant.png', name: 'Restaurant'),
    Brand_Data(image: 'assets/spa.png', name: 'Spa'),
    Brand_Data(image: 'assets/salon.png', name: 'Salon'),
  ];
  Map<String, bool> brandExpansionMap = {
    'Shopping': false,
    'Supermarket': false,
    'Restaurant': false,
    'Spa': false,
    'Salon': false,
  };

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Promo Board', style: label.copyWith(color: Colors.black))
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
                      GestureDetector(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/search.png'),
                                          const SizedBox(width: 10),
                                          SizedBox(
                                            width: size.width * 0.3,
                                            height: 24,
                                            child: TextField(
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 11),
                                                hintText: 'Search brand',
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
                                      border: Border.all(
                                          color: const Color(0XFFD9D9D9))),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: SizedBox(
                                      width: size.width * 0.2,
                                      child: Row(
                                        children: [
                                          Text('Categories',
                                              style: selectBtnBold),
                                          SizedBox(width: 10),
                                          Image.asset(
                                              'assets/dropdown_right.png')
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Brands(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Image.asset('assets/all.png'),
                                    SizedBox(width: 40),
                                    Text('All', style: transBold)
                                  ],
                                ),
                              ),
                              Image.asset('assets/accordion_check.png'),
                              SizedBox(width: 15)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      ExpansionPanelList(
                        elevation: 1,
                        expandedHeaderPadding: EdgeInsets.zero,
                        children:
                            brand_Data.map<ExpansionPanel>((Brand_Data data) {
                          return ExpansionPanel(
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return ListTile(
                                leading: Image.asset(data.image),
                                title: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      brandExpansionMap[data.name] =
                                          !(brandExpansionMap[data.name] ??
                                              false);
                                    });
                                  },
                                  child: Text(data.name, style: transBold),
                                ),
                              );
                            },
                            body: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                child: Text(
                                    'Lorem ipsum dolor sit amet consectetur. Feugiat libero in nisi luctus nunc tincidunt tempor.',
                                    style: label_sm2)),
                            isExpanded: brandExpansionMap[data.name] ?? false,
                          );
                        }).toList(),
                        expansionCallback: (int panelIndex, bool isExpanded) {
                          setState(() {
                            brandExpansionMap[brand_Data[panelIndex].name] =
                                !isExpanded;
                          });
                        },
                      ),
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
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Brands(),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Image.asset('assets/brands.png'),
                          SizedBox(height: 5),
                          Text('Brands', style: footerText)
                        ],
                      ),
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

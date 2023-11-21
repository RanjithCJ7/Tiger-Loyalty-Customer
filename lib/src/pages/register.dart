import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tl_customer/src/pages/authentication.dart';
import 'package:tl_customer/src/pages/signin.dart';
import 'styles.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String isSelected = 'female';
  bool isCheckboxEnabled = true;

  // TextEditingController firstNameController = TextEditingController();
  // TextEditingController lastNameController = TextEditingController();
  // TextEditingController phoneController = TextEditingController();

  // Future<void> registerUser(
  //   String firstName,
  //   String lastName,
  //   String phoneNumber,
  // ) async {
  //   print('first name: 27 $firstName');
  //   print('last name: 28 $lastName');
  //   print('phone Num 29 $phoneNumber');
  //   try {
  //     final String apiUrl = "https://reqres.in/api/users";

  //     Map<String, String> formData = {
  //       "first_name": firstName,
  //       "last_name": lastName,
  //       "phonenumber": phoneNumber,
  //     };

  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       body: formData,
  //     );

  //     if (response.statusCode == 201) {
  //       final Map<String, dynamic> data = jsonDecode(response.body);

  //       String id = data['id'];
  //       String createdAt = data['createdAt'];

  //       print('User registering');
  //       print('User ID: $id');
  //       print('Created At: $createdAt');

  //       showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             title: Text('Registering - on process'),
  //             content: Text('Please wait'),
  //           );
  //         },
  //       );

  //       Future.delayed(Duration(seconds: 2), () {
  //         Navigator.of(context).push(
  //           MaterialPageRoute(
  //             builder: (context) => RegisterBusiness(),
  //           ),
  //         );
  //       });
  //     } else {
  //       final Map<String, dynamic> errorData = jsonDecode(response.body);
  //       String errorMessage = errorData['message'];

  //       print('User registration failed. Status code: ${response.statusCode}');
  //       print('Error Message: $errorMessage');

  //       // Show an error message to the user, e.g., using a SnackBar.
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('User registration failed. Please check your input.'),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 15.0),
                          child: Image.asset('assets/register.png'),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            'Register',
                            style: label,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFF5F5F5)),
                      color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextField(
                      // controller: firstNameController,
                      decoration: InputDecoration(
                        hintText: 'First name',
                        hintStyle: TextStyle(color: Color(0xFF808080)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(20),
                      ),
                      style: textFieldStyle,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFF5F5F5)),
                      color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextField(
                      // controller: lastNameController,
                      decoration: InputDecoration(
                        hintText: 'Last name',
                        hintStyle: TextStyle(color: Color(0xFF808080)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(20),
                      ),
                      style: textFieldStyle,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "What's your gender?",
                          style: smText,
                        ),
                        SizedBox(width: 15.0),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isSelected = 'female';
                            });
                          },
                          style:
                              isSelected == 'female' ? selectBtn : deSelectBtn,
                          child: Row(
                            children: [
                              Text("Female",
                                  style: isSelected == 'female'
                                      ? selectBtnBold
                                      : selectBtnSm),
                              if (isSelected == 'female')
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Image.asset('assets/tick.png'),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.0),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isSelected = 'male';
                            });
                          },
                          style: isSelected == 'male' ? selectBtn : deSelectBtn,
                          child: Container(
                            // width: 84,
                            child: Row(
                              children: [
                                Text(
                                  "Male",
                                  style: isSelected == 'male'
                                      ? selectBtnBold
                                      : selectBtnSm,
                                ),
                                if (isSelected == 'male')
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Image.asset('assets/tick.png'),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFF5F5F5)),
                      color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextField(
                      // controller: phoneNumberController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        hintText: 'Phone number',
                        hintStyle: TextStyle(color: Color(0xFF808080)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(20),
                      ),
                      style: textFieldStyle,
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: true,
                        onChanged:
                            isCheckboxEnabled ? (bool? newValue) {} : null,
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors.grey;
                            }
                            return Colors.black;
                          },
                        ),
                      ),
                      Text("I accept"),
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height - 125.0,
                                alignment: Alignment.bottomCenter,
                                child: Dialog(
                                  child: Container(
                                    width: 374,
                                    height: 802,
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 10.0, bottom: 20.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                  left: 50.0,
                                                ),
                                                child: Text(
                                                  'Terms and Conditions',
                                                  style: alertTitle,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                    left: 30.0,
                                                  ),
                                                  child: Image.asset(
                                                      'assets/close.png'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: SingleChildScrollView(
                                            padding:
                                                EdgeInsets.only(bottom: 30.0),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 30),
                                              child: Text(
                                                'Welcome to TIGER! TIGER LOYALTY COMPANY (Tiger) provides Application and website features and other products and services to you when you visit www.tiger.co.tz (the "website") or download Tiger Mobile Application, use TIGER devices, products, or services, use Tiger applications for mobile, or use software provided by Tiger Loyalty company in connection with any of the foregoing (collectively "TIGER Services"). Please see our privacy notice to understand how we collect and process your personal information. TIGER advertise and sells deals to you subject to the conditions set out on this page.\n\nCONDITIONS OF USE\nPlease read these conditions carefully before using TIGER Services. By using TIGER Services, you signify your agreement to be bound by these conditions.\n\nPRIVACY\nTIGER shall follow the privacy policy posted on its website at www.tiger,co.tz/privacypolicy when collecting and using information from you. TIGER may amend the privacy policy at any time by posting and notifying the amended privacy policy on its website. By using the App, you agree to be bound by our Privacy Policy, which is incorporated into these Terms of Use.\n\nELECTRONIC COMMUNICATIONS\nWhen you use any TIGER Service, you are communicating with us electronically. We will communicate with you electronically in a variety of ways, such as by email, text message, call, in-app push notices or by posting e-mail messages or communications on the App. For contractual purposes, you agree that all agreements, notices, disclosures and other communications that we provide you electronically satisfy any legal requirement that such communications be in writing, unless mandatory applicable laws specifically require a different form of communication.\n\nRECOMMENDATIONS AND PERSONALIZATION\nAs part of the TIGER Services, we may recommend features, products, and services, including third-party ads that might be of interest to you, identify your preferences, and personalize your experience.\n\nCOPYRIGHT, AUTHORS\' RIGHTS AND DATABASE RIGHTS\nAll content included in or made available through any TIGER Service, such as text, graphics, logos, button icons, images, audio clips, digital downloads, and data compilations is the property of TIGER or its content suppliers and is protected by applicable Copyright laws. The compilation of all content included in or made available through any TIGER Service is the exclusive property of TIGER and is protected by Tanzanian Copyright laws.\n\nYou may not extract and/or re-utilize parts of the content of any TIGER Service without our express written consent. In particular, you may not utilize any data mining, robots, or similar data gathering and extraction tools to extract (whether once or many times) for re-utilization of any substantial parts of the content of any TIGER Service, without our express written consent. You may also not create and/or publish your own database that features substantial parts of any TIGER Service (e.g. our prices and product listings) without our express written consent.\n\nTRADEMARK\nIn addition, graphics, logos, page headers, button icons, scripts, and service names included in or made available through any TIGER Service are trademarks or trade dress of TIGER. TIGER\'s trademarks and trade dress may not be used in connection with any product or service that is not TIGER’s, in any manner that is likely to cause confusion among customers or in any manner that disparages or discredits TIGER. All other trademarks not owned by TIGER that appear in any TIGER Service are the property of their respective owners, who may or may not be affiliated with, connected to, or sponsored by TIGER.\n\nNOTICE AND PROCEDURE FOR NOTIFYING TIGER OF DEFAMATORY CONTENT\nBecause millions of products are listed, and many thousands of customer reviews and comments are hosted on TIGER. It is not possible for us to be aware of the contents of each product listed for sale, or each customer review or comment that is displayed. Accordingly, we operate on a "notice and action" basis. If you believe that any content on, or within a product advertised for sale on, the TIGER website or App contains a defamatory statement, please notify TIGER immediately by sending an email to support@tiger.co.tz with the subject line "Defamation Notice [insert your name]"\n\nImportant Warning: giving false, misleading, or inaccurate information in the email to TIGER, or TIGER WhatsApp or any other communication channels of Defamatory Content on TIGER website may result in civil and criminal liability.\n\nTIGER SOFTWARE TERMS\nIn addition to these Conditions of Use, the terms found here apply to any software (including any updates or upgrades to the software and any related documentation) that we make available to you from time to time for your use in connection with TIGER Services (the TIGER Application and Website").\n\nOTHER BUSINESSES\nParties other than TIGER operate stores, provide services, or sell product lines on this App. In addition, we provide links, and location to the sites of affiliated companies and certain other businesses. We are not responsible for examining or evaluating, and we do not warrant the offerings of, any of these businesses or individuals or the content of their websites. TIGER does not assume any responsibility or liability for the actions, product, and content of all of these or any other third parties. You can tell when a third party is involved in your transactions, and we may share your information related to those transactions with that third party. You should carefully review their privacy statements and other conditions of use.\n\nTIGER’S ROLE\nTIGER allows third-party sellers to list and sell their products deals at Tiger App and website www.tiger.co.tz. In each such case, this is indicated on the respective product detail page. While TIGER as a service provider helps facilitate transactions that are carried out on the TIGER App, TIGER is neither the manufacturer, importer, representative, buyer nor the seller of the seller\'s items and services. TIGER provides a service for deal owners/sellers and deal seekers/buyers to complete transactions.\n\nAccordingly, the contract formed at the completion of a sale for these third-party products and services is solely between deal seekers/buyer and deal owners/seller. TIGER is not a party to this contract nor assumes any responsibility arising out of or in connection with it. The seller is responsible for the sale of the products/service and for dealing with any buyer claims or any other issue arising out of or in connection with the contract between the deal seeker/buyer and deal owner/seller.\n\nOUR LIABILITY (DISCLAIMER)\nTIGER will do our utmost to ensure that availability of the TIGER Services will be uninterrupted and that transmissions will be error-free. However, due to the nature of the internet, this cannot be guaranteed. Also, your access to TIGER Services may also be occasionally suspended or restricted to allow for repairs, maintenance, or the introduction of new facilities or services. Upon notification to its client TIGER will attempt to limit the frequency and duration of any such suspension or restriction.\n\nTIGER will not be responsible for (i) losses that were not caused by any breach on our part, or (ii) any business loss (including loss of profits, revenue, contracts, anticipated savings, data, goodwill, or wasted expenditure), or (iii) any loss caused by Fraud or misrepresentation, or (iv) any indirect or consequential losses that were not foreseeable to both you and us when you commenced using the TIGER Services.\n\nEach product and description displayed on the platform is according to information received from the Merchant.\n\nThe sole responsibility of TIGER is to facilitate the contractual process between buyer/deal seekers and deal owners/Merchant. TIGER stands as an agent and therefore does not provide warrant, guarantee, or any kind of assurance on its services provided on the platform.\n\nDISPUTE SETTLEMENT\nAny dispute arising from the formation, validity, binding effect, interpretation of or the performance of the terms and conditions hereunder shall be resolved amicably by mediation. If mediation fails, the said dispute will be referred to Arbitration in the presence of an Arbitrator agreed by both parties and pursuant to the current arbitration rules. For the purpose of avoiding doubt, the place of mediation shall be within the United Republic of Tanzania, and the language for arbitration will be in English or Kiswahili upon the client’s choosing. The arbitration award shall be accepted as final and binding upon the Parties, and in any case where the complainant claims for damages, it should be limited to the value of the customer’s exposure to the transaction on the platform.\n\nAPPLICABLE LAW\nThese conditions are governed by and construed in accordance with the laws of the United Republic of Tanzania. We both agree to submit to the jurisdiction of the courts of Tanzania, which means that you may bring a claim to enforce your rights in connection with these Conditions of Sale in Tanzania.\n\nALTERATIONS TO SERVICE OR AMENDMENTS TO THE CONDITIONS OF USE\nTIGER reserves the right to make changes to any TIGER Services with notification to our client, policies, terms and conditions including these Conditions of Use, and Service Terms at any time. However, we will notify the customers of all the changes that have been made. You will be subject to the terms and conditions, policies and Conditions of Use in force at the time that you use the TIGER Services. If any of these Conditions of Use is deemed invalid, void, or for any reason unenforceable, that condition will be deemed severable and will not affect the validity and enforceability of any remaining condition.\n\nWAIVER\nIf you breach these Conditions of Use and we take no action, TIGER will still be entitled to use our rights and remedies in any other situation where you breach these Conditions of Use.\n\nTIGER’S CONTACT DETAILS\nThis App and website is owned and maintained by TIGER LOYALTY COMPANY.\nOld Bagamoyo Road, Mwanga Hakika Tower, Makumbusho\nDar es salaam, Tanzania\nE-mail: business@tiger.co.tz\nPhone: +255 758 559 000\nWhatsApp: +255 758 559 000',
                                                style: dialogTextSm,
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 50,
                                          margin: EdgeInsets.all(30.0),
                                          child: TextButton(
                                            onPressed: () {
                                              // registerUser(
                                              //     firstNameController.text,
                                              //     lastNameController.text,
                                              //     phoneController.text;
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Authentication(),
                                                ),
                                              );
                                            },
                                            style: btnGold2,
                                            child: Text(
                                              'Proceed',
                                              style: btnGoldText2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          'Terms and Conditions',
                          style: resetBtnText,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // registerUser(
                      //     firstNameController.text,
                      //     lastNameController.text,
                      //     phoneController.text;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Authentication(),
                        ),
                      );
                    },
                    style: btnGold2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Register',
                            style: btnGoldText2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 25.0, bottom: 30.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Color(0xFF808080),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text("OR", style: orText),
                        ),
                        Expanded(
                          child: Divider(
                            color: Color(0xFF808080),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 50.0),
                    width: double.infinity,
                    height: 50,
                    child: TextButton(
                      style: btnGrey,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SignIn(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sign in',
                              style: btnGreyText,
                            ),
                          ],
                        ),
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/firebase/fb_cart_product_controllar.dart';
import 'package:e_commerce/models/cart_products_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:im_stepper/stepper.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? __StreetError1;
  String? _StreetError2;
  String? _cityError;
  String? _stateError;
  String? _CountryError;

  String _gender = '1';

  int activeStep = 0; // Initial step set to 5.

  int upperBound = 2; // upperBound MUST BE total number of icons minus 1.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text('CHECKOUT'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            NumberStepper(
              numbers: [
                1,
                2,
                3,
              ],
              activeStep: activeStep,

              // activeStep property set to activeStep variable defined above.

              // This ensures step-tapping updates the activeStep.
              onStepReached: (index) {
                setState(() {
                  activeStep = index;
                });
              },
            ),
            header(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                previousButton(),
                nextButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Returns the next button.
  Widget nextButton() {
    return ElevatedButton(
      onPressed: () {
        // Increment activeStep, when the next button is tapped. However, check for upper bound.
        if (activeStep < upperBound) {
          setState(() {
            activeStep++;
          });
        }
      },
      child: Text('Next'),
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return Visibility(
      visible: activeStep != 0,
      maintainAnimation: true,
      maintainSize: true,
      maintainState: true,
      child: ElevatedButton(
        onPressed: () {
          // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
          if (activeStep > 0) {
            setState(() {
              activeStep--;
            });
          }
        },
        child: Text('Prev'),
      ),
    );
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return Container(
      alignment: Alignment.center,
      height: 410,
      child: headerText(),
    );
  }

  // Returns the header text based on the activeStep.
  Widget? headerText() {
    if (activeStep == 0) {
      return contant1();
    } else if (activeStep == 1) {
      return contant2();
    } else if (activeStep == 2) {
      return contant3();
    }
  }

  Widget contant1() {
    return SizedBox(
      width: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RadioListTile(
            title: Text(
              'Standard Delivery\n ',
              style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            subtitle: Text(
              'Order will be delivered between 3 - 5\n business days',
              style: GoogleFonts.nunito(fontSize: 13, color: Colors.black),
            ),
            value: '1',
            groupValue: _gender,
            onChanged: (String? value) {
              if (value != null) {
                setState(() => _gender = value);
              }
            },
          ),
          RadioListTile(
            title: Text(
              'Next Day Delivery\n ',
              style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            subtitle: Text(
              'Place your order before 6pm and your items \nwill be delivered the next day',
              style: GoogleFonts.nunito(fontSize: 13, color: Colors.black),
            ),
            value: '2',
            groupValue: _gender,
            onChanged: (String? value) {
              if (value != null) {
                setState(() => _gender = value);
              }
            },
          ),
          RadioListTile(
            title: Text(
              'Nominated Delivery\n',
              style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            subtitle: Text(
              'Pick a particular date from the calendar and\n order will be delivered on selected date',
              style: GoogleFonts.nunito(fontSize: 13, color: Colors.black),
            ),
            value: '3',
            groupValue: _gender,
            onChanged: (String? value) {
              if (value != null) {
                setState(() => _gender = value);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget contant2() {
    return SizedBox(
      width: 350,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RadioListTile(
              title: Text(
                'Billing address is the same as delivery address ',
                style: GoogleFonts.nunito(color: Colors.black, fontSize: 14),
              ),
              value: '1',
              groupValue: '1',
              onChanged: (String? value) {},
            ),
            TextField(
              keyboardType: TextInputType.streetAddress,
              enabled: true,
              style: GoogleFonts.nunito(
                color: Colors.black45,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
              expands: true,
              minLines: null,
              maxLines: null,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                hintText: 'Street 1',
                hintMaxLines: 1,
                hintTextDirection: TextDirection.ltr,
                hintStyle: GoogleFonts.nunito(
                  color: Colors.black45,
                  fontWeight: FontWeight.w300,
                ),
                errorText: __StreetError1,
                constraints: BoxConstraints(
                  // minHeight: 50,
                  maxHeight: __StreetError1 == null ? 55 : 75,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            TextField(
              keyboardType: TextInputType.streetAddress,
              enabled: true,
              style: GoogleFonts.nunito(
                color: Colors.black45,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
              expands: true,
              minLines: null,
              maxLines: null,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                hintText: 'Street 2',
                hintMaxLines: 1,
                hintTextDirection: TextDirection.ltr,
                hintStyle: GoogleFonts.nunito(
                  color: Colors.black45,
                  fontWeight: FontWeight.w300,
                ),
                errorText: _StreetError2,
                constraints: BoxConstraints(
                  // minHeight: 50,
                  maxHeight: _StreetError2 == null ? 55 : 75,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            TextField(
              keyboardType: TextInputType.streetAddress,
              enabled: true,
              style: GoogleFonts.nunito(
                color: Colors.black45,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
              expands: true,
              minLines: null,
              maxLines: null,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                hintText: 'City',
                hintMaxLines: 1,
                hintTextDirection: TextDirection.ltr,
                hintStyle: GoogleFonts.nunito(
                  color: Colors.black45,
                  fontWeight: FontWeight.w300,
                ),
                errorText: _cityError,
                constraints: BoxConstraints(
                  // minHeight: 50,
                  maxHeight: _cityError == null ? 55 : 75,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.streetAddress,
                    enabled: true,
                    style: GoogleFonts.nunito(
                      color: Colors.black45,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                    expands: true,
                    minLines: null,
                    maxLines: null,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      hintText: 'State',
                      hintMaxLines: 1,
                      hintTextDirection: TextDirection.ltr,
                      hintStyle: GoogleFonts.nunito(
                        color: Colors.black45,
                        fontWeight: FontWeight.w300,
                      ),
                      errorText: _stateError,
                      constraints: BoxConstraints(
                        // minHeight: 50,
                        maxHeight: _stateError == null ? 55 : 75,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.streetAddress,
                    enabled: true,
                    style: GoogleFonts.nunito(
                      color: Colors.black45,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                    expands: true,
                    minLines: null,
                    maxLines: null,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      hintText: 'Country',
                      hintMaxLines: 1,
                      hintTextDirection: TextDirection.ltr,
                      hintStyle: GoogleFonts.nunito(
                        color: Colors.black45,
                        fontWeight: FontWeight.w300,
                      ),
                      errorText: _CountryError,
                      constraints: BoxConstraints(
                        // minHeight: 50,
                        maxHeight: _CountryError == null ? 55 : 75,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget contant3() {
    return SizedBox(
      width: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<CartProductsModel>>(
                stream: FbCartProductControllar().getCategory(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index)
                    {
                      return Container(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100),
                              height: 160,
                              child: Container(
                                alignment: Alignment.topLeft,
                                  height: 220,
                                  child: Image.network(
                                    snapshot.data!.docs[index]
                                        .data()
                                        .image,
                                    fit: BoxFit.fitWidth,
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  snapshot.data!.docs[index].data().name,
                                  style: TextStyle(color: Colors.grey),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  '\$' +
                                      snapshot.data!.docs[index]
                                          .data()
                                          .salary,
                                  style:
                                  TextStyle(color: Color(0xff00C569)),
                                )),
                          ],
                        ),
                      );
                    });
                  } else {
                    return Center(
                      child: Text('NO Product'),
                    );
                  }
                }),
          ),
          RadioListTile(
            title: Text(
              'Shipping Address',
              style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            subtitle: Text(
              'Place your order before 6pm and your items \nwill be delivered the next day',
              style: GoogleFonts.nunito(fontSize: 13, color: Colors.black),
            ),
            value: '2',
            groupValue: _gender,
            onChanged: (String? value) {
              if (value != null) {
                setState(() => _gender = value);
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 80, left: 60),
            child: TextButton(
              onPressed: () {},
              child: Text('Change'),
              style: TextButton.styleFrom(primary: Color(0xff00C569)),
            ),
          )
        ],
      ),
    );
  }
}

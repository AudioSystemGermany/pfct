import 'package:flutter/cupertino.dart';

import 'pfct_classes.dart';
import 'package:flutter/material.dart';

Widget ShowProductRow(
    {required BuildContext context,
      required int index,
      required pfctProducts products,
      required String reference,
      required pfctSeries series,
      required String manufacturerChoice,
      required String modelChoice,
      required String typeChoice}) {

  List<String> actualProduct = products.getProductsByReference(reference)[index];

  return Row(
    children: [
      Container(
        margin: EdgeInsets.only(top: 10.0),
        width: MediaQuery.of(context).size.width * 0.4 - 20,
        height: (MediaQuery.of(context).size.width * 0.4 - 20) / 3 * 2,
//        color: Colors.black26,
        decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.centerRight,
              fit: BoxFit.contain,
              image: NetworkImage(
                  'https://raw.githubusercontent.com/AudioSystemGermany/pfct/main/pics/${products.getProductsByReference(reference)[index][0].replaceAll(' ', '%20')}.jpg'),
            )),
      ),
      Container(
        margin: EdgeInsets.only(top: 10.0),
        padding: EdgeInsets.only(left: 20.0, right: 10.0, bottom: 5.0),
        height: (MediaQuery.of(context).size.width * 0.4 - 20) / 3 * 2,
        width: MediaQuery.of(context).size.width * 0.6 - 20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                    series.getSeriesText(
                        actualProduct[4],manufacturerChoice, modelChoice, typeChoice),
                    style: TextStyle(fontSize: 18.0, height: 1.5),
                  )),
            ),
            Container(
              alignment: Alignment.bottomRight,
              height: 50,
              child: Row(
                textBaseline: TextBaseline.alphabetic,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('EAN: ${actualProduct[2]}',style: TextStyle(textBaseline: TextBaseline.alphabetic),),
                  Text('DETAILS',style: TextStyle(textBaseline: TextBaseline.alphabetic, decoration: TextDecoration.underline, color: Colors.red, fontSize: 16.0),),
                  Text('UVP ${actualProduct[6]}',style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,textBaseline: TextBaseline.alphabetic),),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
Widget ShowProductColumn(
    {required BuildContext context,
      required int index,
      required pfctProducts products,
      required String reference,
      required pfctSeries series,
      required String manufacturerChoice,
      required String modelChoice,
      required String typeChoice}) {

  List<String> actualProduct = products.getProductsByReference(reference)[index];

  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(top: 10.0),
        width: MediaQuery.of(context).size.width,
        height: (MediaQuery.of(context).size.width) / 3 * 2,
//        color: Colors.black26,
        decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.centerRight,
              fit: BoxFit.contain,
              image: NetworkImage(
                  'https://raw.githubusercontent.com/AudioSystemGermany/pfct/main/pics/${products.getProductsByReference(reference)[index][0].replaceAll(' ', '%20')}.jpg'),
            )),
      ),
      Container(
//        margin: EdgeInsets.only(top: 10.0),
//        padding: EdgeInsets.only(left: 20.0, right: 10.0, bottom: 5.0),
//        height: (MediaQuery.of(context).size.width * 0.4 - 20) / 3 * 2,
//        width: MediaQuery.of(context).size.width * 0.6 - 20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              series.getSeriesText(
                  actualProduct[4],manufacturerChoice, modelChoice, typeChoice),
              style: TextStyle(fontSize: 18.0, height: 1.5),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              height: 50,
              child: Row(
                textBaseline: TextBaseline.alphabetic,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('EAN: ${actualProduct[2]}',style: TextStyle(textBaseline: TextBaseline.alphabetic),),
                  Text('DETAILS',style: TextStyle(textBaseline: TextBaseline.alphabetic, decoration: TextDecoration.underline, color: Colors.red, fontSize: 16.0),),
                  Text('UVP ${actualProduct[6]}',style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,textBaseline: TextBaseline.alphabetic),),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

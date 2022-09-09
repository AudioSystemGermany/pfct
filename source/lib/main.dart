import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:perfect_config_tool/pfct_classes.dart';
import 'package:perfect_config_tool/widgets.dart';

pfctConfig config = pfctConfig();
pfctVehicles vehicles = pfctVehicles();
pfctProducts products = pfctProducts();
pfctSeries series = pfctSeries();

String manufacturerChoice = '';
String modelChoice = '';
String typeChoice = '';
String referenceChoice = '';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perfect Fit Configration Tool',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'PERFECT FIT CONFIGURATION TOOL'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    //config.configLoad();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: (vehicles.vehiclesLoaded == false || config.configLoaded == false)
          ? Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FutureBuilder<bool>(
                        future: config.configLoad(),
                        builder: (context, AsyncSnapshot<bool> snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data!
                                ? 'loading config successful - ${config.toString()}'
                                : 'loading config error');
                          } else {
                            return Text('loading config...');
                          }
                        }),
                    FutureBuilder<bool>(
                        future: vehicles.vehiclesLoad('de'),
                        builder: (context, AsyncSnapshot<bool> snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data!
                                ? 'loading vehicles successful'
                                : 'loading vehicles error');
                          } else {
                            return Text('loading vehicles...');
                          }
                        }),
                    FutureBuilder<bool>(
                        future: products.productsLoad('de'),
                        builder: (context, AsyncSnapshot<bool> snapshot) {
                          if (snapshot.hasData) {
                            print(products.productList);
                            return Text(snapshot.data!
                                ? 'loading products successful'
                                : 'loading products error');
                          } else {
                            return Text('loading products...');
                          }
                        }),
                    FutureBuilder<bool>(
                        future: series.seriesLoad('de'),
                        builder: (context, AsyncSnapshot<bool> snapshot) {
                          if (snapshot.hasData) {
                            print(series.seriesList);
                            return Text(snapshot.data!
                                ? 'loading series successful'
                                : 'loading series error');
                          } else {
                            return Text('loading series...');
                          }
                        }),
                    TextButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: Text('Weiter')),
                  ],
                ),
              ),
            )
          : ChooseManufacturerPage(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ChooseManufacturerPage extends StatelessWidget {
  const ChooseManufacturerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: vehicles.getManufacturers().length,
          itemBuilder: (BuildContext context, index) {
            return GestureDetector(
              onTap: () {
                manufacturerChoice = vehicles.getManufacturers()[index];
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ChooseModelPage();
                }));
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(15)),
                child: Text(
                  vehicles.getManufacturers()[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }),
    );
  }
}

class ChooseModelPage extends StatelessWidget {
  const ChooseModelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PERFECT FIT CONFIGURATION TOOL'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: vehicles.getModels(manufacturerChoice).length,
            itemBuilder: (BuildContext context, index) {
              return GestureDetector(
                onTap: () {
                  modelChoice = vehicles.getModels(manufacturerChoice)[index];
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ChooseTypePage();
                  }));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    vehicles.getModels(manufacturerChoice)[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class ChooseTypePage extends StatelessWidget {
  const ChooseTypePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PERFECT FIT CONFIGURATION TOOL'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount:
                vehicles.getTypes(manufacturerChoice, modelChoice).length,
            itemBuilder: (BuildContext context, index) {
              return GestureDetector(
                onTap: () {
                  typeChoice = vehicles
                      .getTypes(manufacturerChoice, modelChoice)[index]
                      .substring(6)
                      .replaceAll('\n', ' ');
                  referenceChoice = vehicles
                      .getTypes(manufacturerChoice, modelChoice)[index]
                      .substring(0, 6);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ChooseProductPage();
                  }));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        vehicles
                            .getTypes(manufacturerChoice, modelChoice)[index]
                            .substring(6),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                      vehicles.getLinks(
                                  manufacturerChoice, modelChoice)[index] !=
                              ''
                          ? GestureDetector(
/*                              onTap: () async {
                                if (!await launchUrl(Uri.parse(vehicles.getLinks(manufacturerChoice, modelChoice)[index]))) {
                                  throw 'HTML Error';
                                }
                                print('TAP');},*/
/*                              onTap: (){
                                html.window.open(vehicles.getLinks(manufacturerChoice, modelChoice)[index], "_blank", 'location=yes');
                              },*/
                              child: Text(
                              '\nINFORMATION',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline),
                            ))
                          : Container(),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class ChooseProductPage extends StatelessWidget {
  const ChooseProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('PERFECT FIT CONFIGURATION TOOL'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              '$manufacturerChoice $typeChoice',
              style: TextStyle(fontSize: 20.0),
            ),
            Container(
              height: 20,
            ),
            Flexible(
              child: ListView.builder(
                  itemCount:
                      products.getProductsByReference(referenceChoice).length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      //height: 300,
                      child: Column(
                        children: [
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.black54, Colors.black26],
                              ),
                            ),
                            width: double.infinity,
                            padding: EdgeInsets.all(5.0),
                            child: FittedBox(
                              //fit: BoxFit.fitHeight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                      products.getProductsByReference(
                                          referenceChoice)[index][0],
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white)),
                                  Text(
                                      '  ( ${products.getProductsByReference(referenceChoice)[index][5]} )',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
/*                          Row(
                            children: [
                              Container(
                                height: 260,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Image.network(
                                        'https://raw.githubusercontent.com/AudioSystemGermany/pfct/main/pics/${products.getProductsByReference(referenceChoice)[index][0].replaceAll(' ', '%20')}.jpg',
                                        height: 240),
                                  ],
                                ),
                              ),
                            ],
                          ),*/
                          LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              if (constraints.maxWidth > 600) {
                                return ShowProductRow(
                                    context: context,
                                    index: index,
                                    products: products,
                                    reference: referenceChoice,
                                    series: series,
                                    manufacturerChoice: manufacturerChoice,
                                    modelChoice: modelChoice,
                                    typeChoice: typeChoice
                                );
                              } else {
                                return ShowProductColumn(
                                    context: context,
                                    index: index,
                                    products: products,
                                    reference: referenceChoice,
                                    series: series,
                                    manufacturerChoice: manufacturerChoice,
                                    modelChoice: modelChoice,
                                    typeChoice: typeChoice);
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

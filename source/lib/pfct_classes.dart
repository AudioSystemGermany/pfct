import 'load_routines.dart';
import 'string_routines.dart';

class pfctSeries {
  List<List<String>> seriesList = [];
  bool seriesLoaded = false;

  Future<bool> seriesLoad(String language) async {
    String series = '';
    series = await fetchSeries(language);
    if (series != 'error') {
      series = deleteFirstRow(series);
      while (series.length > 5) {
        seriesList.add(firstRowToList(series));
        series = deleteFirstRow(series);
      }
      seriesLoaded = true;
      return true;
    } else
      return false;
  }

  String getSeriesText (String series, String manufacturer, String model, String type) {
    String seriesText = '';
    seriesList.forEach((serie) {
      if (serie[0] == series) {
        seriesText = serie[1];
      }
    });
    seriesText = seriesText.replaceAll('[MARKE]', manufacturer);
    seriesText = seriesText.replaceAll('[MODELL]', '');
    seriesText = seriesText.replaceAll('[TYP]', type);
    return seriesText;
  }

}

class pfctProducts {
  List<List<String>> productList = [];
  bool productsLoaded = false;

  Future<bool> productsLoad(String language) async {
    String products = '';
    products = await fetchProducts(language);
    if (products != 'error') {
      products = deleteFirstRow(products);
      while (products.length > 5) {
        productList.add(firstRowToList(products));
        products = deleteFirstRow(products);
      }
      productsLoaded = true;
      return true;
    } else
      return false;
  }

  List<List<String>> getProductsByReference (String reference) {
    List<List<String>> referenceList = [];
    productList.forEach((product) {
      if (product[1] == reference) {
        referenceList.add(product);
      }
    });
    return referenceList;
  }

}

class pfctVehicles {
  List<List<String>> vehicleList = [];
  bool vehiclesLoaded = false;

  Future<bool> vehiclesLoad(String language) async {
    String vehicles = '';
    vehicles = await fetchVehicles(language);
    if (vehicles != 'error') {
      vehicles = deleteFirstRow(vehicles);
      while (vehicles.length > 5) {
        vehicleList.add(firstRowToList(vehicles));
        vehicles = deleteFirstRow(vehicles);
      }
      vehiclesLoaded = true;
      return true;
    } else
      return false;
  }

  List<String> getManufacturers() {
    List<String> manufacturers = [];
    vehicleList.forEach((model) {
      if (manufacturers.contains(model[1]) == false) {
        manufacturers.add(model[1]);
      }
    });
    return manufacturers;
  }

  List<String> getModels(String manufacturer) {
    List<String> models = [];
    vehicleList.forEach((model) {
      if (model[1] == manufacturer) {
        if (models.contains(model[2]) == false) models.add('${model[2]}');
      }
    });
    return models;
  }

  List<String> getTypes(String manufacturer, modelChoice) {
    List<String> types = [];
    vehicleList.forEach((model) {
      if (model[1] == manufacturer) {
        if (model[2] == modelChoice) {
          types.add('${model[0]}${model[2]} ${model[6]} ${model[3]}\n(${model[4]} - ${model[5]})');
        }
      }
    });
    return types;
  }
  List<String> getLinks(String manufacturer, modelChoice) {
    List<String> links = [];
    vehicleList.forEach((model) {
      if (model[1] == manufacturer) {
        if (model[2] == modelChoice) {
          links.add(model.length > 7 ? '${model[7]}' : '');
        }
      }
    });
    return links;
  }



}

class pfctConfig {
  int mainVersion = 0;
  int subVersion = 0;
  int tables = 0;
  List<String> languages = [];
  bool configLoaded = false;

  String toString() {
    return 'database v$mainVersion.$subVersion - $tables table(s), languages: $languages';
  }

  Future<bool> configLoad() async {
    String config = '';
    config = await fetchConfig();
    if (config != 'error') {
      double noLanguages = (getFirstEol(config) - 9) / 3;
      if (noLanguages < 0.1) return false;
      languages = [];
      for (int i = 0; i < noLanguages.toInt(); i++) {
        languages.add(config.substring(10 + i * 3, 12 + i * 3));
      }

      config = deleteFirstRow(config);
      tables = int.parse(
          config.substring(config.indexOf(';') + 1, getFirstEol(config)));

      config = deleteFirstRow(config);
      mainVersion = int.parse(
          config.substring(config.indexOf(';') + 1, config.indexOf('.')));
      subVersion = int.parse(
          config.substring(config.indexOf('.') + 1, getFirstEol(config)));
      configLoaded = true;
      return true;
    } else
      return false;
  }
}

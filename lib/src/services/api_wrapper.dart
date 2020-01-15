import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:food_barcode_scan/src/Bloc/provider.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class APIWrapper {
  static Future<void> scanCode(BuildContext context) async {
    final _bloc = Provider.of(context);
    try {
      String scanReponse = await BarcodeScanner.scan();
      String resultText = "Product not found";

      ProductResult productResult =
          await OpenFoodAPIClient.getProduct(scanReponse, "es");

      if (productResult.product != null) {
        Map<String, dynamic> data = productResult.product.toJson();
        if (data["product_name"] != null)
          resultText =
              "Product Scanned: ${data['product_name']} by: ${data['brands']}";
      }
      _bloc.addData(resultText);
    } on PlatformException catch (e) {
      String error = "Unknown error $e";
      if (e.code == BarcodeScanner.CameraAccessDenied)
        error = "Camera access was denied";
      _bloc.addError(error);
    } on FormatException {
      _bloc.addError("Back button pressed before scanning anything");
    } catch (e) {
      _bloc.addError("Unknown error $e");
    }
  }
}

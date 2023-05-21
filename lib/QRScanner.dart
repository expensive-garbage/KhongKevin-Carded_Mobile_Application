import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  String qrCodeResult = "Not Yet Scanned";


  //TODO pulled from internet need to reformat and adjust
  Future<void> addUserLocation(String userId) async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final places = GoogleMapsPlaces(apiKey: dotenv.env['GOOGLE_MAPS_API_KEY']); // load your api key from .env file
    PlacesSearchResponse response = await places.searchNearbyWithRadius(
        Location(lat: position.latitude, lng: position.longitude), 500);

    FirebaseFirestore.instance.collection('users').doc(userId).update({
      'location': GeoPoint(position.latitude, position.longitude),
      'address': response.results.first.formattedAddress //TODO HANDLE IF NO RESULTS FOUND
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Result",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              qrCodeResult,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(15.0),
                side: BorderSide(color: Colors.blue, width: 3.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
              onPressed: () async {
                final scanResult = await BarcodeScanner.scan();
                setState(() {
                  qrCodeResult = scanResult.rawContent;
                  addUserLocation(qrCodeResult); // assume qrCodeResult is the user's id
                });
              },
              child: Text(
                "Open Scanner",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}

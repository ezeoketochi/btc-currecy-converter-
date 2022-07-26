import 'package:bitcoin_app/coin_data.dart';
import 'package:bitcoin_app/networking/network.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  PriceScreenState createState() => PriceScreenState();
}

String selected = "USD";

class PriceScreenState extends State<PriceScreen> {
  List<DropdownMenuItem<String>> dropDown() {
    List<DropdownMenuItem<String>> dropList = [];

    for (String currency in currenciesList) {
      var item = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      dropList.add(item);
    }
    return dropList;
  }

  String time = "1";
  int ratetobtc = 0;
  int ratetoltc = 0;
  int ratetoeth = 0;
  String ltcbasepair = "";
  String ethbasepair = "";
  String btcbasepair = "";
  String quotepairtobtc = "";
  String quotepairtoeth = "";
  String quotepairtoltc = "";

  btcCaller() async {
    String url =
        "https://rest.coinapi.io/v1/exchangerate/BTC/$selected?apikey=3743D5BE-830D-4428-BAC6-4F554FAECF90";
    Networking network = Networking(url: url);

    var data = await network.getURL();
    time = data["time"];
    ratetobtc = data["rate"].toInt();

    btcbasepair = data["asset_id_base"];
    quotepairtobtc = data["asset_id_quote"];
    setState(() {});

    debugPrint(" the selected curency is $quotepairtobtc");
  }

  ltcCaller() async {
    String url =
        "https://rest.coinapi.io/v1/exchangerate/LTC/$selected?apikey=3743D5BE-830D-4428-BAC6-4F554FAECF90";
    Networking network = Networking(url: url);

    var data = await network.getURL();
    time = data["time"];
    ratetoltc = data["rate"].toInt();
    ltcbasepair = data["asset_id_base"];
    quotepairtoltc = data["asset_id_quote"];
    setState(() {});

    debugPrint(" the selected curency is $quotepairtobtc");
  }

  ethCaller() async {
    String url =
        "https://rest.coinapi.io/v1/exchangerate/ETH/$selected?apikey=3743D5BE-830D-4428-BAC6-4F554FAECF90";
    Networking network = Networking(url: url);

    var data = await network.getURL();
    time = data["time"];
    ratetoeth = data["rate"].toInt();
    ethbasepair = data["asset_id_base"];
    quotepairtoeth = data["asset_id_quote"];
    setState(() {});

    debugPrint(" the selected curency is $quotepairtobtc");
  }

  @override
  void initState() {
    btcCaller();
    ethCaller();
    ltcCaller();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 $btcbasepair = $ratetobtc $quotepairtobtc at $time',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 $ethbasepair = $ratetoeth $quotepairtoeth at $time',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 $ltcbasepair = $ratetoltc $quotepairtoltc at $time',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
              value: selected,
              elevation: 16,
              underline: Container(
                height: 2,
                color: Colors.white,
              ),
              items: dropDown(),
              onChanged: (value) {
                setState(() {
                  selected = value!;
                });
                btcCaller();
                ethCaller();
                ltcCaller();
              },
            ),
          ),
        ],
      ),
    );
  }
}

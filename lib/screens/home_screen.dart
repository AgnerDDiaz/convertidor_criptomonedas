import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCurrency = 'USD'; // Moneda seleccionada por defecto
  Map<String, String> cryptoPrices = {};
  bool isLoading = false; // Indicador de carga

  DropdownButton<String> getAndroidDropDownButton() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currencyList) {
      dropDownItems.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }
    return DropdownButton(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
          fetchCryptoRates();
        });
      },
    );
  }

  CupertinoPicker getIOSCupertinoPicker() {
    List<Text> pickerItems = [];
    for (String currency in currencyList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (index) {
        setState(() {
          selectedCurrency = currencyList[index];
          fetchCryptoRates();
        });
      },
      children: pickerItems,
    );
  }

  void fetchCryptoRates() async {
    setState(() {
      isLoading = true;
    });

    Map<String, String> rates = await getCryptoRates(selectedCurrency);

    setState(() {
      cryptoPrices = rates;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCryptoRates(); // Obtener datos al iniciar la pantalla
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cripto Converter"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Tarjetas con precios
          Padding(
            padding: EdgeInsets.fromLTRB(18, 18, 18, 18),
            child: Column(
              children: cryptoPrices.entries.map((entry) {
                return Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 15,
                    ),
                    child: Text(
                      "1 ${entry.key} = ${entry.value} $selectedCurrency",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Indicador de carga
          if (isLoading)
            Center(child: CircularProgressIndicator()),

          // Selector de moneda
          Container(
            height: 150,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30),
            color: Colors.lightBlue,
            child: Platform.isIOS
                ? getIOSCupertinoPicker()
                : getAndroidDropDownButton(),
          ),
        ],
      ),
    );
  }
}

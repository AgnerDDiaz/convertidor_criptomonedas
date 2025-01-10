import 'dart:convert';
import 'package:http/http.dart' as http;

// Lista de monedas y criptomonedas
const List<String> currencyList = [
  "AUD", "BRL", "CAD", "CNY", "EUR", "GBP", "HKD", "IDR", "ILS", "INT", "JPY",
  "MXN", "DOP", "NOK", "NZO", "PLN", "RON", "RUB", "SEK", "SGD", "USD", "ZAR"
];

const List<String> criptoList = ["BTC", "ETH", "LTC"];

// Obtener la clave de API desde el archivo .env
final String llave = "";

Future<Map<String, String>> getCryptoRates(String currency) async {
  Map<String, String> cryptoPrices = {};

  for (String crypto in criptoList) {
    final url = Uri.parse("https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=$llave");
    print("Solicitando URL: $url"); // Imprime la URL

    try {
      final response = await http.get(url);
      print("Respuesta de CoinAPI: ${response.body}"); // Imprime la respuesta

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        cryptoPrices[crypto] = data['rate'].toStringAsFixed(2);
      } else {
        cryptoPrices[crypto] = "Error";
        print("Error en la API: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      cryptoPrices[crypto] = "Error";
      print("Error al conectar con la API: $e");
    }
  }

  return cryptoPrices;
}

import 'package:flutter_dotenv/flutter_dotenv.dart';

String urlAPI = "https://api.satudikti.id";
// String urlAPI = "https://devsuperapp-api.dikti.go.id";

//URL Stagging
const String urlStagging = 'https://api.satudikti.id/v2';

//URL Production
const String urlProd = 'https://api.satudikti.id/v2';

//URL for lokal
const String urlLocal = 'https://devsuperapp-api.dikti.go.id/v2';

const String urlSementaraBeasiswa = 'https://api.satudikti.id/v2';

// API Kampus Merdeka
const String urlKM = 'https://api.kampusmerdeka.kemdikbud.go.id/mbkm/program';

const String urlProvinsi = 'https://api-frontend.kemdikbud.go.id/get_provinsi';

// URL SSO Dev
const String urlSSODev = 'http://103.56.191.233';

// URL SSO Live
const String urlSSOLive = 'https://ssopddikti.kemdikbud.go.id';

const String portDev = '8089';

Map<String, String> appHeaders = {
  dotenv.get('API_KEY'): dotenv.get('API_VALUE'),
  dotenv.get('API_VERSION'): dotenv.get('API_VERSION_VALUE'),
};

Map<String, String> appHeaders1 = {
  dotenv.get('API_KEY1'): dotenv.get('API_VALUE'),
  dotenv.get('API_VERSION'): dotenv.get('API_VERSION_VALUE'),
};

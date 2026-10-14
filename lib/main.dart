import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    final String htmlContent = '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    body {
      margin: 0;
      padding: 0;
      background: transparent;
      overflow: hidden;
    }
    /* Hides the current condition text (e.g. Sunny/Cloudy) */
    .weatherwidget-io-frame iframe .ww-current-condition,
    .ww-current-condition,
    .ww-condition {
      display: none !important;
    }
  </style>
</head>
<body>
  <a class="weatherwidget-io" href="https://forecast7.com/en/39d18n96d57/manhattan/?unit=us" data-label_1="MANHATTAN" data-label_2="WEATHER" data-icons="Climacons Animated" data-mode="Current" data-theme="pure" data-basecolor="rgba(255, 255, 255, 0)" data-textcolor="#ffffff" data-highcolor="#ffffff">MANHATTAN WEATHER</a>
  <script>
  !function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src='https://weatherwidget.io/js/widget.min.js';fjs.parentNode.insertBefore(js,fjs);}}(document,'script','weatherwidget-io-js');
  </script>
</body>
</html>
''';

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..loadHtmlString(htmlContent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: Center(
        child: SizedBox(
          height: 150, // Typical height for weather widget
          child: WebViewWidget(controller: _controller),
        ),
      ),
    );
  }
}

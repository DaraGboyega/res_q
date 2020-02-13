import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class Hotline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Text('Campus Fire Service'),
            trailing: Text('08162214241'),
            onTap: () => UrlLauncher.launch("tel://08162214241"),
          ),
          ListTile(
            leading: Text('Campus Security Hotline'),
            trailing: Text('09034592436'),
            onTap: () => UrlLauncher.launch("tel://09034592436"),
          ),
        ],
      ),
    );
  }
}

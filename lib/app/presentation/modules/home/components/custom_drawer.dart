import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/utils/constants/themes.dart';
import '../../../global/widgets/drawer_option_button.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const CloseButton(),
              DrawerOptionButton(
                icon: Icons.settings,
                onPressed: () {},
                text: 'Configuración',
              ),
              DrawerOptionButton(
                icon: Icons.coffee,
                onPressed: _buyMeACoffee,
                text: 'BuyMeACoffee',
              ),
              const Spacer(),
              const Center(
                child: Text(
                  'Version 0.0.1',
                  style: TextStyle(
                    color: kOnPrimary,
                    fontSize: kMediumText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _buyMeACoffee() async {
    final uri = Uri(
      scheme: 'https',
      host: 'www.buymeacoffee.com',
      path: '/EmmaMoraDev',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'No se puede abrir $uri';
    }
  }
}

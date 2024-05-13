import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/about_background.jpg'),
            opacity: 0.3,
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('About'),
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'CosmoQuest stems from the idea of sharing and bringing closer the most relevant knowledge of the universe that humanity has achieved to date, providing an educational and interactive means of observing images about space, allowing to add small snippets of text among them to complement knowledge.\n\n'
                    'Therefore, the main idea has always been to create a non-profit educational app that allows to bring knowledge closer through visual interactions (photographs) to users.\n\n'
                    'How does CosmoQuest work?\n\n'
                    'CosmoQuest operates thanks to various resources existing on the internet, which are free to use. Thanks to all these resources, it is possible to obtain updated and accurate information about celestial bodies, updated photos of space, etc. CosmoQuest operates mainly thanks to the following resources:\n\n'
                    '- NASA APOD API (Astronomy Picture of the Day).\n'
                    '- The Solar System OpenData Swagger API (Technical information about planets and celestial bodies).\n'
                    '- NASA Images API (NASA image gallery).\n\n'
                    'All credits and acknowledgments are directed to these aforementioned entities.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

import 'package:flutter/material.dart';

class ImageData {
  final String imageUrl;
  final String label;

  ImageData({required this.imageUrl, required this.label});
}

List<ImageData> images = [
  ImageData(imageUrl: 'lib/assets/ComputerEngineeringProgram.png', label: 'Computer Engineering'),
  ImageData(imageUrl: 'lib/assets/Digital Signal Processing Program.png', label: 'Digital Signal Processing'),
  ImageData(imageUrl: 'lib/assets/Electrical Engineering Program.png', label: 'Electrical Engineering'),
  ImageData(imageUrl: 'lib/assets/Electronic Circuit Design Program.png', label: 'Electronic Circuit Design'),
  ImageData(imageUrl: 'lib/assets/Electronic Engineering Program.png', label: 'Electronic Engineering'),
  ImageData(imageUrl: 'lib/assets/Theory and Algorithms.png', label: 'Theory and Algorithms'),
  ImageData(imageUrl: 'lib/assets/System Software.png', label: 'System Software'),
  ImageData(imageUrl: 'lib/assets/IC Design.png', label: 'IC Design'),
  ImageData(imageUrl: 'lib/assets/Computer Network.png', label: 'Computer Network'),
  ImageData(imageUrl: 'lib/assets/Multimedia Security and Image Processing.png', label: 'Multimedia Security and Image Processing'),
];

class ImageViewerPage extends StatelessWidget {
  final String imageUrl;

  ImageViewerPage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Topology'),
      ),
      body: SafeArea(
        child: InteractiveViewer(
          maxScale: 5.0,
          minScale: 0.01,
          child: Image.asset(
            imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

class TopologyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Topology'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: images.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Container(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 130, 114, 156),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  images[index].label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageViewerPage(imageUrl: images[index].imageUrl),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TopologyPage(),
  ));
}

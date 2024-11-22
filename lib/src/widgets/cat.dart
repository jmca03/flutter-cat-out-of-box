import 'package:flutter/material.dart';

/// A stateless widget that displays an image of a cat.
///
/// The [Cat] widget fetches and displays an image from a network URL.
///
/// This widget uses Flutter's [Image.network] to load the image from the
/// specified URL. Make sure the app has internet access to fetch the image.
///
/// The image URL used: `https://i.imgur.com/QwhZRyL.png`
class Cat extends StatelessWidget
{
  /// Creates a [Cat] widget.
  ///
  /// The [key] parameter is optional and can be used to uniquely identify this
  /// widget in a widget tree.
  const Cat({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://i.imgur.com/QwhZRyL.png',
    );
  }
}
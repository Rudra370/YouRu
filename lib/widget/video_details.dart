import 'package:AudioPlayer/components/Colors.dart';
import 'package:AudioPlayer/components/TextStyleComponent.dart';
import 'package:flutter/material.dart';

class VideoDetails extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String duration;

  const VideoDetails({this.imageUrl, this.title, this.duration});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.blueGrey[900],
      ),
      height: size.height * 0.15,
      width: size.width,
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.02, vertical: size.height * 0.001),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              height: size.height * 0.12,
              child: Image.network(imageUrl, fit: BoxFit.fitHeight,
                  loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(ColorCodes.cOffWhite),
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes
                          : null,
                    ),
                  ),
                );
              }, frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) {
                  return child;
                }
                return AnimatedOpacity(
                  child: child,
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeOut,
                );
              }),
            ),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: size.height * 0.09,
                    child: Text(
                      title.length >= 36
                          ? title.substring(0, 35) + '...'
                          : title,
                      style: TextStyleComponent.v2normalWhite18,
                    ),
                  ),
                  Text(
                    'Duration: $duration',
                    style: TextStyleComponent.normalWhite14,
                    overflow: TextOverflow.clip,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

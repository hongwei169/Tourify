import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../services/app_service.dart';


class HtmlBodyWidget extends StatelessWidget {
  const HtmlBodyWidget({Key? key, required this.htmlDescription}) : super(key: key);

  final String htmlDescription;

  @override
  Widget build(BuildContext context) {
    return Html(
      data: '''$htmlDescription''', // },
      onLinkTap: (url, _, __) {
        AppService().openLink(context, url!);
      },
      style: {
        "body": Style(
            margin: Margins.zero,
            padding: EdgeInsets.zero,
            fontSize: FontSize.large,
            fontWeight: FontWeight.normal,
            fontFamily: '',
            color: Colors.grey[700]),

        "figure": Style(margin: Margins.zero, padding: EdgeInsets.zero),

        //Disable this line to disable full width picture/video support
        //"p,h1,h2,h3,h4,h5,h6": Style(margin: Margins.all(20)),
      },
      extensions: [
        TagExtension(
            tagsToExtend: {"img"},
            builder: (ExtensionContext eContext) {
              String imageUrl = eContext.attributes['src'].toString();
              return CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) => const CircularProgressIndicator(),
              );
            }),
        TagExtension(
            tagsToExtend: {"iframe"},
            builder: (ExtensionContext eContext) {
              final String videoSource = eContext.attributes['src'].toString();
              return InkWell(
                  onTap: () => AppService().openLink(context, videoSource),
                  child: Container(
                    color: Colors.grey.shade200,
                    height: 200,
                    width: 400,
                    child: Icon(
                      Icons.play_circle_fill,
                      color: Colors.grey,
                    ),
                  ));
            }),
        TagExtension(
            tagsToExtend: {"video"},
            builder: (ExtensionContext eContext) {
              final String videoSource = eContext.attributes['src'].toString();
              return InkWell(
                  onTap: () => AppService().openLink(context, videoSource),
                  child: Container(
                    color: Colors.grey.shade200,
                    height: 200,
                    width: 400,
                    child: Icon(
                      Icons.play_circle_fill,
                      color: Colors.grey,
                    ),
                  ));
            }),
      ],
    );
  }
}

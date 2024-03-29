import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_module/jdshop/widget/LoadingWidget.dart';

class NewsDetailPage1 extends StatefulWidget {
  final aid;

  NewsDetailPage1({Key? key, this.aid}) : super(key: key);

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage1> {
  List _list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._getData();
  }

  _getData() async {
    var apiUrl =
        "http://www.phonegap100.com/appapi.php?a=getPortalArticle&aid=${widget.aid}";
    print("api:${apiUrl}");
    var result = await Dio().get(apiUrl);
    print("result:${result}");
    setState(() {
      this._list = json.decode(result.data)["result"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("新闻详情${widget.aid}"),
      ),
      body: this._list.length > 0
          ? ListView(
              children: [
                Container(
                  height: 60,
                  alignment: Alignment.center,
                  child: Text(
                    "${_list[0]['title']}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Html(
                    data: _list[0]['content'],
                    style: {
                      "table": Style(
                        backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                      ),
                      "tr": Style(
                        border: Border(bottom: BorderSide(color: Colors.grey)),
                      ),
                      "th": Style(
                        padding: EdgeInsets.all(6),
                        backgroundColor: Colors.grey,
                      ),
                      "td": Style(
                        padding: EdgeInsets.all(6),
                        alignment: Alignment.topLeft,
                      ),
                      'h5': Style(
                          maxLines: 2, textOverflow: TextOverflow.ellipsis),
                    },
                    customRender: {
                      "table": (context, child) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: (context.tree as TableLayoutElement)
                              .toWidget(context),
                        );
                      },
                      "bird": (RenderContext context, Widget child) {
                        return TextSpan(text: "🐦");
                      },
                      "flutter": (RenderContext context, Widget child) {
                        return FlutterLogo(
                          style:
                              (context.tree.element!.attributes['horizontal'] !=
                                      null)
                                  ? FlutterLogoStyle.horizontal
                                  : FlutterLogoStyle.markOnly,
                          textColor: context.style.color!,
                          size: context.style.fontSize!.size! * 5,
                        );
                      },
                    },
                    customImageRenders: {
                      networkSourceMatcher(domains: ["flutter.dev"]):
                          (context, attributes, element) {
                        return FlutterLogo(size: 36);
                      },
                      networkSourceMatcher(domains: ["mydomain.com"]):
                          networkImageRender(
                        headers: {"Custom-Header": "some-value"},
                        altWidget: (alt) => Text(alt ?? ""),
                        loadingWidget: () => Text("Loading..."),
                      ),
                      // On relative paths starting with /wiki, prefix with a base url
                      (attr, _) =>
                              attr["src"] != null &&
                              attr["src"]!.startsWith("/wiki"):
                          networkImageRender(
                              mapUrl: (url) =>
                                  "https://upload.wikimedia.org" + url!),
                      // Custom placeholder image for broken links
                      networkSourceMatcher():
                          networkImageRender(altWidget: (_) => FlutterLogo()),
                    },
                    onLinkTap: (url, _, __, ___) {
                      print("Opening $url...");
                    },
                    onImageTap: (src, _, __, ___) {
                      print(src);
                    },
                    onImageError: (exception, stackTrace) {
                      print(exception);
                    },
                    onCssParseError: (css, messages) {
                      print("css that errored: $css");
                      print("error messages:");
                      messages.forEach((element) {
                        print(element);
                      });
                    },
                  ),
                )
              ],
            )
          : LoadingWidget(),
    );
  }
}

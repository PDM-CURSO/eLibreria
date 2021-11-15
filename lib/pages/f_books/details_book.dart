import 'dart:math';

import 'package:flutter/material.dart';
import 'package:libreria/webview/web_view_page.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsBook extends StatefulWidget {
  final Map<String, dynamic> bookDetails;
  final String? title;
  final String? img;

  DetailsBook({
    Key? key,
    required this.bookDetails,
    required this.title,
    required this.img,
  }) : super(key: key);

  @override
  _DetailsBookState createState() => _DetailsBookState();
}

class _DetailsBookState extends State<DetailsBook> {
  bool _showLongDescription = false;
  String? _currentBigPicture;

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    if (!(widget.bookDetails["images"] as List).contains(widget.img)) {
      widget.bookDetails["images"].add(widget.img);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles del libro"),
        actions: [
          IconButton(
            tooltip: "Visitar webpage",
            icon: Icon(Icons.public),
            onPressed: () {
              // web view o abrir con el navegador
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => WebViewPage(
                    url: widget.bookDetails["link"],
                  ),
                ),
              );
            },
          ),
          IconButton(
            tooltip: "Compartir",
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share(
                "Tengo el libro de: ${widget.title} \npara ti en el siguiente link:\n ${widget.bookDetails["link"]}",
                subject: "Mira este libro",
              );
            },
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: ListView(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(24),
                  height: MediaQuery.of(context).size.height * .4,
                  width: MediaQuery.of(context).size.width * .5,
                  child: Hero(
                    tag: "${widget.title}$UniqueKey()",
                    child: Image.network(
                      _currentBigPicture ?? widget.img!,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      widget.bookDetails["images"].length ?? 0,
                      (index) => Container(
                        margin: EdgeInsets.all(8),
                        height: MediaQuery.of(context).size.height / 12,
                        width: MediaQuery.of(context).size.height / 12,
                        child: GestureDetector(
                          child: Image.network(
                            widget.bookDetails["images"][index],
                            fit: BoxFit.fitWidth,
                          ),
                          onTap: () {
                            setState(() {
                              _currentBigPicture =
                                  widget.bookDetails["images"][index];
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              widget.title ?? "No title",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 16,
                    children: List.generate(
                      widget.bookDetails["tags"] != null
                          ? widget.bookDetails["tags"].length
                          : 0,
                      (index) => Chip(
                        backgroundColor: Colors.primaries[
                            Random().nextInt(Colors.primaries.length)],
                        label: Text(
                          "${widget.bookDetails["tags"][index]}",
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                      "${widget.bookDetails["qr"]}",
                      height: 80,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "\$${widget.bookDetails["price"] ?? "No price available"}",
                            style: TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                            ),
                          ),
                          TextButton(
                            child: Text("Comprar"),
                            onPressed: () {
                              _launchURL(widget.bookDetails["link"]);
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              child: _showLongDescription
                  ? Text(
                      widget.bookDetails["description"] ?? "No description",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    )
                  : Text(
                      widget.bookDetails["description"] ??
                          "No description available",
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
              onTap: () {
                setState(() {
                  _showLongDescription = !_showLongDescription;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

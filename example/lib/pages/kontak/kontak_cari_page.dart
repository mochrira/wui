import 'dart:async';

import 'package:example/models/kontak.dart';
import 'package:example/services/kontak_service.dart';
import 'package:flutter/material.dart';
import 'package:wui/dialog/dialog.dart';
import 'package:wui/list_tile/list_tile.dart';

class KontakCariPage extends StatefulWidget {
  const KontakCariPage({ Key? key }) : super(key: key);

  @override
  _KontakCariPageState createState() => _KontakCariPageState();
}

class _KontakCariPageState extends State<KontakCariPage> {

  ScrollController _scrollController = ScrollController();
  KontakService _kontakService = KontakService();

  int _page = 1;
  bool _lastPage = false;
  bool _isLoading = false;
  List<Kontak> _dataKontak = [];

  TextEditingController _searchController = TextEditingController();
  Timer? _searchDebounce;

  _refresh(BuildContext context) {
    setState(() {
      _page = 1;
      _lastPage = false;
      _dataKontak = [];
    });
    _next(context);
  }

  _next(BuildContext context) async {
    try {
      setState(() { _isLoading = true; });
      int limit = 30;
      int offset = (_page - 1) * limit;
      KontakResult res = await _kontakService.result(params: {
        "offset": offset,
        "limit": limit
      });
      setState(() { 
        if(res.data.length > 0) {
          _dataKontak.addAll(res.data);
          _page++;
        } else {
          _lastPage = true;
        }
        _isLoading= false;
      });
    } catch(e) {
      setState(() { _isLoading= false; });
      WuiDialog.open(context, 
        title: "Error", 
        message: e.toString(), 
        buttons: ["OK"]
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...(_dataKontak.asMap().map((int key, Kontak value) => MapEntry(key, WuiListTile(
              title: Text(value.nmKontak ?? ""),
              subtitle: Text(value.nomor ?? ""),
            ))).values.toList())
          ],
        )
      ),
    );
  }
}
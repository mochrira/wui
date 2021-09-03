import 'dart:async';

import 'package:example/models/kontak.dart';
import 'package:example/pages/kontak/kontak_form_page.dart';
import 'package:example/services/kontak_service.dart';
import 'package:flutter/material.dart';
import 'package:wui/wui.dart';

class KontakPage extends StatefulWidget {
  const KontakPage({ Key? key }) : super(key: key);

  @override
  _KontakPageState createState() => _KontakPageState();
}

class _KontakPageState extends State<KontakPage> {

  List<Kontak> _dataKontak = [];
  KontakService _kontakService = KontakService();
  bool _lastPage = false;
  bool _isLoading = false;
  int _page = 1;
  int _count = 0;

  String _search = '';
  Timer? _searchDebounce;
  bool _searchMode = false;

  ScrollController _scrollController = ScrollController();

  _delete(BuildContext context, int index) async {
    int? res = await WuiDialog.open(context, 
      title: "Konfirmasi", 
      message: "Anda yakin menghapus " + (_dataKontak[index].nmKontak ?? "") + " dari daftar kontak ?", 
      buttons: ["BATAL", "YA, HAPUS"],
      defaultIndex: 1
    );
  }

  _itemTap(BuildContext context, int index) async {
    int? res = await WuiActionSheet.open(context,
      title: Text(_dataKontak[index].nmKontak ?? ""),
      actions: [
        WuiListTile(
          leading: Icon(Icons.receipt_rounded),
          title: Text("Histori Transaksi"),
          borderMode: 'normal',
          onTap: () {
            Navigator.of(context).pop(0);
          },
        ),
        WuiListTile(
          leading: Icon(Icons.edit),
          title: Text("Edit Kontak"),
          borderMode: 'normal',
          onTap: () {
            Navigator.of(context).pop(1);
          },
        ),
        WuiListTile(
          leading: Icon(Icons.delete),
          title: Text("Hapus Kontak"),
          onTap: () {
            Navigator.of(context).pop(2);
          },
        )
      ]
    );

    switch(res) {
      case 0 : break;
      case 1 : break;
      case 2 : 
        _delete(context, index);
        break;
    }
  }
  
  _toggleSearch() {
    setState(() {
      _searchMode = !_searchMode;
      if(!_searchMode) {
        _refresh();
      }
    });
  }

  _refresh() async {
    setState(() {
      this._dataKontak = [];
      this._page = 1;
      this._lastPage = false;
      this._search = '';
    });
    _next();
  }

  _next() async {
    if(_isLoading || _lastPage) return;

    try {
      setState(() { _isLoading = true; });
      Map<String, dynamic> params = {
        "offset": (_page - 1) * 30,
        "limit": 30
      };
      if(_searchMode) params["search"] = _search;
      KontakResult res = await _kontakService.result(
        params: params
      );
      setState(() {
        if(res.data!.length > 0) {
          _dataKontak.addAll(res.data!);
          _page++;
        } else {
          _lastPage = true;
        }
        if(res.count != null) _count = res.count!;
        _isLoading = false;
      });
    } catch(e) {
      setState(() { _isLoading = false; });
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
    _scrollController.addListener(() { 
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        _next();
      }
    });
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _next();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(_searchMode) {
          _toggleSearch();
          return false;
        }
        return true;
      },
      child: Scaffold(
        drawer: WuiDrawer(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            Kontak? kontak = await Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => KontakFormPage()
            ));
          },
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _refresh();
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              ...[WuiSliverAppBar(
                leading: _searchMode ? IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    _toggleSearch();
                  },
                ) : null,
                title: _searchMode ? TextField(
                  decoration: InputDecoration(
                    hintText: "Kata kunci...",
                    border: InputBorder.none
                  )
                ) : Text("Data Kontak"),
                flexibleTitle: WuiTextHeading3("Data Kontak"),
                showExpanded: !_searchMode,
                subtitle: Text(_isLoading && _page == 1 ? "Memuat..." : "Total " + _count.toString() + " Kontak"),
                actions: _searchMode ? [] : [
                  IconButton(
                    onPressed: () {
                      _toggleSearch();
                    },
                    icon: Icon(Icons.search),
                  )
                ],
              )],
              SliverList(delegate: SliverChildListDelegate([
                ..._dataKontak.asMap().map((index, value) => MapEntry(index, WuiListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.grey.shade300
                    ),
                    width: 48,
                    height: 48
                  ),
                  title: Text(_dataKontak[index].nmKontak ?? ""),
                  subtitle: Text("+62 " + (_dataKontak[index].nomor ?? "")),
                  borderMode: "full",
                  trailing: Icon(Icons.more_vert),
                  onTap: () {
                    _itemTap(context, index);
                  },
                ))).values.toList(),
                ..._isLoading ? [Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(child: CircularProgressIndicator())
                )] : []
              ]))
            ],
          ),
        )
      ),
    );
  }
}
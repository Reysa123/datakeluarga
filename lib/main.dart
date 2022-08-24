// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'package:photo_view/photo_view.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Utama(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final String namaFile;
  const MyHomePage({Key? key, required this.title, required this.namaFile})
      : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey _globalKey = GlobalKey();
  late BuildContext con;
  double scalF = 0.5;
  double baseF = 0.5;
  XFile? images;

  String nimg = 'Alamat Gambar';
  final ImagePicker imagePicker = ImagePicker();
  Future getImage(ImageSource media) async {
    var img = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      images = img;
    });
    nimg = (images!.path.toString());
    //print(p.basename(img.toString()));
  }

  void myAlert() {}

  @override
  void initState() {
    _requestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    con = context;
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // _createFolder('folderName');
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        title: const Text('Silahkan pilih gambar dimedia'),
                        content: Container(
                          padding: const EdgeInsets.all(4),
                          height: MediaQuery.of(context).size.height / 6,
                          child: ElevatedButton(
                            //if user click this button, user can upload image from gallery
                            onPressed: () {
                              Navigator.pop(context);
                              getImage(ImageSource.gallery);
                            },
                            child: Row(
                              children: const [
                                Icon(Icons.image),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Dari Media'),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
              child: const Text('Upload Photo'),
            ),
            const SizedBox(
              height: 10,
            ),
            //if image not null show the image
            //if image null show text
            images != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: RepaintBoundary(
                            key: _globalKey,
                            child: Image.file(
                              //to show image, you type like this.
                              File(images!.path.toString()),
                              fit: BoxFit.fill,
                              alignment: Alignment.center,
                              filterQuality: FilterQuality.high,
                              width: MediaQuery.of(context).size.width,
                              height: 300,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Text('Tidak ada gambar'),
                            ),
                          ),
                        ),
                        //Image(image: FileImage(File(nimg))),
                        Text(p.basename(nimg.toString())),
                        TextButton.icon(
                            onPressed: () async {
                              await _saveScreen(widget.namaFile);
                            },
                            icon: const Icon(Icons.save),
                            label: const Text('Simpan'))
                      ],
                    ),
                  )
                : const Text("No Image", style: TextStyle(fontSize: 20))
          ],
        ),
      ),
    );
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    // print(info);
    _toastInfo(info);
  }

  _toastInfo(String info) {
    var snackBar = SnackBar(content: Text(info));
    ScaffoldMessenger.of(con).showSnackBar(snackBar);
  }

  _saveScreen(String namaImage) async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      String picturesPath = namaImage;
      final result = await SaverGallery.saveImage(
        byteData.buffer.asUint8List(),
        name: picturesPath,
      ); //androidRelativePath: "Picture");
      debugPrint(result.toString());
      _toastInfo('Simpan data berhasil');
      navi();
    }
  }

  navi() {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: ((context) => const Utama())));
  }
}

class Utama extends StatefulWidget {
  const Utama({Key? key}) : super(key: key);

  @override
  State<Utama> createState() => _UtamaState();
}

class _UtamaState extends State<Utama> {
  String img = '/storage/emulated/0/Pictures/Data Keluarga';
  String title = 'Kartu Keluarga';
  List<String> namaFile = ['kk'];
  List<String> kk = [];
  List<String> ap = [];
  List<String> vaksin = [];
  List<String> vaksin1 = [];
  List<String> vaksin2 = [];
  List<String> ak = [];
  List<String> ak1 = [];
  List<String> ktp = [];
  List<String> ktp1 = ['ktpb', 'ktpi', 'ktpa1', 'ktpa2', 'ktp3', 'ktp4'];
  List<String> sim = [];
  List<String> sim1 = ['simb', 'simi', 'sima1', 'sima2', 'sim3', 'sim4'];
  List<String> askes = [];
  List<String> askes1 = ['asb', 'asi', 'asa1', 'asa2', 'asa3', 'asa4'];
  List<String> npwp = [];
  List<String> npwp1 = ['npb', 'npi', 'npa1', 'npa2', 'npa3', 'npa4'];
  List<String> vaksina = ['vb', 'vi', 'v1', 'v2', 'v3', 'v4'];
  List<String> vaksinb = ['vb2', 'vi2', 'v12', 'v22', 'v32', 'v42'];
  List<String> vaksin3 = ['vb3', 'vi3', 'v13', 'v23', 'v33', 'v43'];
  List<String> list = [];
  _data() {
    setState(() {
      kk.clear();
      ap.clear();
      ak.clear();
      ak1.clear();
      ktp.clear();
      vaksin.clear();
      vaksin1.clear();
      vaksin2.clear();
      sim.clear();
      askes.clear();
      npwp.clear();
      kk = ['$img/kk.png'];
      ap = ['$img/ap.png'];
      ak = [
        '$img/akb.png',
        '$img/aki.png',
        '$img/aka1.png',
        '$img/aka2.png',
        '$img/aka3.png',
        '$img/aka4.png'
      ];
      ktp = [
        '$img/ktpb.png',
        '$img/ktpi.png',
        '$img/ktpa1.png',
        '$img/ktpa2.png',
        '$img/ktpa3.png',
        '$img/ktpa4.png'
      ];
      sim = [
        '$img/simb.png',
        '$img/simi.png',
        '$img/sima1.png',
        '$img/sima2.png',
        '$img/sima3.png',
        '$img/sima4.png'
      ];
      askes = [
        '$img/asb.png',
        '$img/asi.png',
        '$img/asa1.png',
        '$img/asa2.png',
        '$img/asa3.png',
        '$img/asa4.png'
      ];
      npwp = [
        '$img/npb.png',
        '$img/npi.png',
        '$img/npa1.png',
        '$img/npa2.png',
        '$img/npa3.png',
        '$img/npa4.png'
      ];
      ak1 = ['akb', 'aki', 'aka1', 'aka2', 'aka3', 'aka4'];
      vaksin = [
        '$img/vb.png',
        '$img/vi.png',
        '$img/v1.png',
        '$img/v2.png',
        '$img/v3.png',
        '$img/v4.png'
      ];
      vaksin1 = [
        '$img/vb2.png',
        '$img/vi2.png',
        '$img/v12.png',
        '$img/v22.png',
        '$img/v32.png',
        '$img/v42.png'
      ];
      vaksin2 = [
        '$img/vb3.png',
        '$img/vi3.png',
        '$img/v13.png',
        '$img/v23.png',
        '$img/v33.png',
        '$img/v43.png'
      ];
    });
  }

  @override
  void initState() {
    _data();
    list = kk;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _data();
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          PopupMenuButton<String>(
              onSelected: (data) async {
                await _data();
                setState(() {
                  list.clear();
                });
                if (data == 'Kartu Keluarga') {
                  setState(() {
                    list = kk;
                    namaFile = ['kk'];
                    title = 'Kartu Keluarga';
                  });
                }
                if (data == 'Akta Perkawinan') {
                  setState(() {
                    list = ap;
                    namaFile = ['ap'];
                    title = 'Akta Perkawinan';
                  });
                }
                if (data == 'Akta Kelahiran') {
                  setState(() {
                    list = ak;
                    namaFile = ak1;
                    title = 'Akta Kelahiran';
                  });
                }
                if (data == 'KTP') {
                  setState(() {
                    list = ktp;
                    namaFile = ktp1;
                    title = 'KTP';
                  });
                }
                if (data == 'SIM') {
                  setState(() {
                    list = sim;
                    namaFile = sim1;
                    title = 'SIM';
                  });
                }
                if (data == 'ASKES') {
                  setState(() {
                    list = askes;
                    namaFile = askes1;
                    title = 'ASKES';
                  });
                }
                if (data == 'VAKSIN I') {
                  setState(() {
                    list = vaksin;
                    namaFile = vaksin1;
                    title = 'VAKSIN I';
                  });
                }
                if (data == 'VAKSIN II') {
                  setState(() {
                    list = vaksin1;
                    namaFile = vaksina;
                    title = 'VAKSIN II';
                  });
                }
                if (data == 'VAKSIN BOOSTER') {
                  setState(() {
                    list = vaksin2;
                    namaFile = vaksinb;
                    title = 'VAKSIN BOOSTER';
                  });
                }
                if (data == 'NPWP') {
                  setState(() {
                    list = npwp;
                    namaFile = npwp1;
                    title = 'NPWP';
                  });
                }
              },
              color: const Color.fromARGB(255, 59, 209, 255),
              itemBuilder: (context) {
                return [
                  'Kartu Keluarga',
                  'Akta Perkawinan',
                  'Akta Kelahiran',
                  'KTP',
                  'SIM',
                  'ASKES',
                  'VAKSIN I',
                  'VAKSIN II',
                  'VAKSIN BOOSTER',
                  'NPWP',
                ].map((e) {
                  return PopupMenuItem(
                    value: e,
                    child: Text(e),
                  );
                }).toList();
              }),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  GestureDetector(
                    onDoubleTap: () {
                      PhotoView(
                        imageProvider: Image.file(File(list[index].toString()))
                            .runtimeType as ImageProvider,
                      );
                    },
                    child: Image.file(File(list[index].toString()),
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        errorBuilder: ((context, error, stackTrace) =>
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => MyHomePage(
                                            title: title,
                                            namaFile: namaFile[index]))));
                              },
                              icon: const Icon(Icons.add),
                              label: const Text('Upload'),
                            ))),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => MyHomePage(
                                        title: title,
                                        namaFile: namaFile[index]))));
                          },
                          icon: const Icon(Icons.change_circle),
                          label: const Text('Ganti')),
                      ElevatedButton.icon(
                          onPressed: () {
                            Share.shareFiles([list[index].toString()],
                                text: title);
                          },
                          icon: const Icon(Icons.share),
                          label: const Text('Bagikan'))
                    ],
                  )
                ],
              );
            }),
      ),
    );
  }
}

import 'dart:io';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:text_editor/select_text.dart';
import 'package:text_editor/utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Textinfo> texts = [];
  String imageURL = "";
  String dropdownfont = "OpenSans";
  double dropdownsize = 20.0;
  Color color = Colors.black;
  TextEditingController textEditingController = TextEditingController();
  TextEditingController creatortext = TextEditingController();
  int currentIndex = 0;

  setcurrentIndex(BuildContext context, index) {
    setState(() {
      currentIndex = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("${texts[currentIndex].text} Is Selected"),
      duration: const Duration(milliseconds: 500),
    ));
  }

  changeTextColour(Color color) {
    setState(() {
      texts[currentIndex].color = color;
    });
  }

  removeText(BuildContext context) {
    setState(() {
      texts.remove(texts[currentIndex]);
    });
  }

  changeFontSize(double size) {
    setState(() {
      texts[currentIndex].fontSize = size;
    });
  }

  changeFontFamily(String family) {
    setState(() {
      texts[currentIndex].fontfamily = family;
    });
  }

  addNewText(BuildContext context) {
    setState(() {
      texts.add(
        Textinfo(
            text: textEditingController.text,
            left: 0,
            right: 0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            textAlign: TextAlign.left,
            fontfamily: "OpenSans"),
      );
      Navigator.of(context).pop();
    });
  }

  // ignore: non_constant_identifier_names
  Widget BuildColorPicker() => ColorPicker(
      selectedPickerTypeColor: color,
      onColorChanged: (color) {
        setState(() {
          changeTextColour(color);
          this.color = color;
        });
      });

  void pickColor(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text('Pick Your Color'),
          content: Column(
            children: [
              BuildColorPicker(),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Select',
                    style: TextStyle(color: Colors.black),
                  )),
            ],
          )));

  void pickPhoto() async {
    final picker = ImagePicker();
    XFile? imagefile;
    try {
      imagefile = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        imageURL = imagefile!.path;
      });
    } catch (e) {
      return;
    }
  }

  addNewDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text("Add New Text"),
              content: TextField(
                maxLines: 5,
                controller: textEditingController,
                decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.edit),
                    filled: true,
                    hintText: "Your Text Here.."),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Back',
                      style: TextStyle(color: Colors.black),
                    )),
                ElevatedButton(
                    onPressed: () {
                      addNewText(context);
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Text Editor',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        surfaceTintColor: Colors.black,
        shadowColor: Colors.black87,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                    flex: 4,
                    child: imageURL != ""
                        ? Stack(
                            children: [
                              Container(
                                  height: 500,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: FileImage(File(imageURL)),
                                          fit: BoxFit.fill))),
                              for (int i = 0; i < texts.length; i++)
                                Positioned(
                                  left: texts[i].left,
                                  top: texts[i].top,
                                  child: GestureDetector(
                                    onLongPress: () {},
                                    onTap: () {
                                      setcurrentIndex(context, i);
                                    },
                                    child: Draggable(
                                      onDragEnd: (drag) {
                                        final renderbox = context
                                            .findRenderObject() as RenderBox;
                                        Offset off = renderbox
                                            .globalToLocal(drag.offset);
                                        setState(() {
                                          texts[i].top = off.dy - 95;
                                          texts[i].left = off.dx;
                                        });
                                      },
                                      feedback: ImageText(
                                        textinfo: texts[i],
                                      ),
                                      child: ImageText(
                                        textinfo: texts[i],
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          )
                        : Stack(
                            children: [
                              Container(
                                  height: 500,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(20),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              "assets/images/image.png")))),
                              for (int i = 0; i < texts.length; i++)
                                Positioned(
                                  left: texts[i].left,
                                  top: texts[i].top,
                                  child: GestureDetector(
                                    onLongPress: () {},
                                    onTap: () {
                                      setcurrentIndex(context, i);
                                    },
                                    child: Draggable(
                                      onDragEnd: (drag) {
                                        final renderbox = context
                                            .findRenderObject() as RenderBox;
                                        Offset off = renderbox
                                            .globalToLocal(drag.offset);
                                        setState(() {
                                          texts[i].top = off.dy - 95;
                                          texts[i].left = off.dx;
                                        });
                                      },
                                      feedback: ImageText(
                                        textinfo: texts[i],
                                      ),
                                      child: ImageText(
                                        textinfo: texts[i],
                                      ),
                                    ),
                                  ),
                                ),
                              creatortext.text.isNotEmpty
                                  ? Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Text(
                                        creatortext.text,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.black.withOpacity(0.3)),
                                      ),
                                    )
                                  : const SizedBox.shrink()
                            ],
                          )),
                const SizedBox(
                  height: 20,
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Font',
                                style: TextStyle(fontSize: 15),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              DropdownButton(
                                items: const [
                                  DropdownMenuItem(
                                    value: "Bungee",
                                    child: Text('Bungee'),
                                  ),
                                  DropdownMenuItem(
                                    value: "Mochiy",
                                    child: Text('Mochiy'),
                                  ),
                                  DropdownMenuItem(
                                    value: "OpenSans",
                                    child: Text('OpenSans'),
                                  ),
                                  DropdownMenuItem(
                                    value: "Poppins",
                                    child: Text('Poppins'),
                                  ),
                                  DropdownMenuItem(
                                    value: "Rubik",
                                    child: Text('Rubik'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    dropdownfont = value!;
                                    changeFontFamily(dropdownfont);
                                  });
                                },
                                value: dropdownfont,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Size',
                                style: TextStyle(fontSize: 15),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              DropdownButton(
                                items: const [
                                  DropdownMenuItem(
                                    value: 10.0,
                                    child: Text('10'),
                                  ),
                                  DropdownMenuItem(
                                    value: 12.0,
                                    child: Text('12'),
                                  ),
                                  DropdownMenuItem(
                                    value: 14.0,
                                    child: Text('14'),
                                  ),
                                  DropdownMenuItem(
                                    value: 16.0,
                                    child: Text('16'),
                                  ),
                                  DropdownMenuItem(
                                    value: 18.0,
                                    child: Text('18'),
                                  ),
                                  DropdownMenuItem(
                                    value: 20.0,
                                    child: Text('20'),
                                  ),
                                  DropdownMenuItem(
                                    value: 22.0,
                                    child: Text('22'),
                                  ),
                                  DropdownMenuItem(
                                    value: 24.0,
                                    child: Text('24'),
                                  ),
                                  DropdownMenuItem(
                                    value: 26.0,
                                    child: Text('26'),
                                  ),
                                  DropdownMenuItem(
                                    value: 28.0,
                                    child: Text('28'),
                                  ),
                                  DropdownMenuItem(
                                    value: 30.0,
                                    child: Text('30'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    dropdownsize = value!;
                                    changeFontSize(dropdownsize);
                                  });
                                },
                                value: dropdownsize,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Color',
                                style: TextStyle(fontSize: 15),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  pickColor(context);
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      const CircleBorder()),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(10)),
                                  backgroundColor: MaterialStateProperty.all(
                                      color), // <-- Button color
                                ),
                                child: Text(
                                  '.',
                                  style: TextStyle(color: color),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: Size(100, 8)),
                                  onPressed: () {
                                    setState(() {
                                      addNewDialog(context);
                                    });
                                  },
                                  child: const Text(
                                    'Add Text',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  )),
                              // const SizedBox(
                              //   width: 10,
                              // ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: Size(100, 8)),
                                  onPressed: () {
                                    setState(() {
                                      removeText(context);
                                    });
                                  },
                                  child: const Text(
                                    'Remove',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  )),
                              // const SizedBox(
                              //   width: 10,
                              // ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: Size(100, 8)),
                                  onPressed: () {
                                    setState(() {
                                      pickPhoto();
                                    });
                                  },
                                  child: const Text(
                                    'Add Image',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

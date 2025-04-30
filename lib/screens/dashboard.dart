// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fitness_tracker/provider/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitness_tracker/model/note_model.dart';
import 'package:fitness_tracker/components/note_storage.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'menu.dart';
class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _MyWidgetState();
}

List<Map<String, dynamic>> notes = [];
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
bool _isDarkMode = false; // You can connect this with Riverpod if needed

class _MyWidgetState extends ConsumerState<Dashboard> {
 


List<Note> _notes = [];

@override
void initState() {
  super.initState();
  _loadNotes();
}

String _getFirstTwoSentences(String text) {
  final sentences = text.split(RegExp(r'(?<=[.!?])\s+'));
  return sentences.take(2).join(' ');
}

Set<int> _selectedIndices = {};
bool _selectionMode = false;

void _toggleSelection(int index) {
  setState(() {
    if (_selectedIndices.contains(index)) {
      _selectedIndices.remove(index);
      if (_selectedIndices.isEmpty) {
        _selectionMode = false;
      }
    } else {
      _selectedIndices.add(index);
      _selectionMode = true;
    }
  });
}

void _cancelSelection() {
  setState(() {
    _selectedIndices.clear();
    _selectionMode = false;
  });
}


Future<void> _loadNotes() async {
  final loadedNotes = await NoteStorage.loadNotes();
  setState(() {
    _notes = loadedNotes;
  });
}


  bool isSelected = true;

  @override
  Widget build(BuildContext context) {
    final selectedFilter = ref.watch(selectedFilterProvider);
    return Scaffold(
       key: _scaffoldKey,
      drawer: AppDrawer(
        isDarkMode: _isDarkMode,
        onToggleDarkMode: () {
          setState(() {
            _isDarkMode = !_isDarkMode;
            // TODO: integrate with your actual theme logic (Riverpod etc.)
          });
        },
      ),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: _selectionMode
            ? Text('Selected ${_selectedIndices.length}', style: 
            TextStyle(fontSize: 17, fontWeight: FontWeight.bold),)
            : Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('lib/assets/icons/fit.jpg'),
                  ),
                  SizedBox(width: 10),
                  Text("Hi, Joseph", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600)),
                ],
              ),
        actions: _selectionMode
    ? [
        TextButton(
          onPressed: _cancelSelection,
          child: Text("Cancel", style: TextStyle(color: Colors.black)),
        ),
        TextButton(
          onPressed: () {
            setState(() => _selectedIndices = _notes.asMap().keys.toSet());
          },
          child: Text("Select All", style: TextStyle(color: Colors.black)),
        ),
      ]
    : [
        PopupMenuButton<int>(
          icon: Icon(Icons.more_vert, color: Colors.black),
          onSelected: (value) {
            if (value == 0) {
              _showAppMenuDialog(context);
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 0,
              child: Text("Menu"),
            ),
          ],
        ),
        SizedBox(width: 10),
      ],

      ),


      backgroundColor: Colors.white,
      body: Padding(
        
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Notes',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(height: 10,),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                 FilterChip(
                  label: Text(
                    "All",
                    style: TextStyle(
                      color: selectedFilter == 'All' ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  selected: selectedFilter == 'All',
                  onSelected: (_) {
                    ref.read(selectedFilterProvider.notifier).state = 'All';
                  },
                  showCheckmark: false,
                  shape: StadiumBorder(
                    side: isSelected
                        ? BorderSide.none
                        : BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                  ),
                  selectedColor: Colors.black,
                  backgroundColor: Colors.white,
                ),
                SizedBox(width: 10),
                 FilterChip(
                  label: Text(
                    "Important",
                    style: TextStyle(
                      color: selectedFilter == 'Important' ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  
                  selected: selectedFilter == 'Important',
                  onSelected: (_) {
                    ref.read(selectedFilterProvider.notifier).state = 'Important';
                  },
                  showCheckmark: false,
                  shape: StadiumBorder(
                    side: isSelected
                        ? BorderSide.none
                        : BorderSide(
                            color: const Color.fromARGB(9, 201, 0, 0),
                            width: 2,
                          ),
                  ),
                  selectedColor: Colors.black,
                  backgroundColor: Colors.white,
                )
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: MasonryGridView.count(
              crossAxisCount: 2,
              itemCount: _notes.length,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              itemBuilder: (context, index) {
                final note = _notes[index];

                // Filter non-important notes if filter is active
                if (ref.watch(selectedFilterProvider) == 'Important' && !note.isImportant) {
                  return const SizedBox.shrink();
                }

                String previewText = _getFirstTwoSentences(note.content);
                final isSelected = _selectedIndices.contains(index);
                final isLongNote = (note.title?.length ?? 0) > 40 || previewText.length > 100;

                return GestureDetector(
                  onLongPress: () => _toggleSelection(index),
                  onTap: () {
                    if (_selectionMode) {
                      _toggleSelection(index);
                    } else {
                    }
                  },
                  child: Container(
                    
                    decoration: BoxDecoration(
                      color: note.color,
                      borderRadius: BorderRadius.circular(25),
                      border: isSelected ? Border.all(color: Colors.black, width: 2) : null,
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: isSelected
                              ? const Icon(Icons.check_circle, color: Colors.black, size: 20)
                              : const SizedBox(height: 5),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            note.title ?? "Untitled",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                              height: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                          previewText,
                          style: const TextStyle(color: Colors.black87),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          maxLines: 10, // Or however many you want
                        ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            ),
          ],
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/addNote');
          if (result != null && result is Map<String, dynamic>) {
            final newNote = Note(
              title: result['title'],
              content: result['text'],
              color: result['color'],
              isImportant: false, // Or handle from result
            );

            setState(() {
              _notes.add(newNote);
            });

            await NoteStorage.saveNotes(_notes); // Save to disk
          }
        },

        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        shape: const CircleBorder(),
        child: Icon(Icons.add, color: Colors.white,),
      ),
      bottomNavigationBar: _selectionMode
    ? Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: Icon(Icons.push_pin_outlined), onPressed: () {/* pin logic */}),
            IconButton(icon: Icon(Icons.lock_outline_rounded), onPressed: () {/* lock logic */}),
            IconButton(icon: Icon(Icons.delete_outline), onPressed: () {
              setState(() {
                _selectedIndices.toList()..sort((a, b) => b.compareTo(a)) // sort descending
                ..forEach((index) {
                  _notes.removeAt(index);
                });
                _cancelSelection();
              });
              NoteStorage.saveNotes(_notes);
            }),
          ],
        ),
      )
    : null,
    );
  }
  void _showAppMenuDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      insetPadding: EdgeInsets.only(top: 60, right: 10), // show below kebab
      backgroundColor: Colors.transparent,
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          width: 260,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Color(0xFFFFE0B2),
                Color(0xFFFFF176),
              ],
              stops: [0.7, 1, 1.0],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: SvgPicture.asset('lib/assets/icons/person.svg', color: Colors.black, width: 24),
                title: Text('Profile', style: TextStyle(fontWeight: FontWeight.w600)),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: SvgPicture.asset('lib/assets/icons/settings.svg', color: Colors.black),
                title: Text('Settings', style: TextStyle(fontWeight: FontWeight.w600)),
                onTap: () => Navigator.pop(context),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.dark_mode_outlined, color: Colors.black),
                        SizedBox(width: 12),
                        Text('Dark Mode', style: TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                    FlutterSwitch(
                      width: 50.0,
                      height: 28.0,
                      toggleSize: 24.0,
                      value: false, // replace with your state
                      borderRadius: 30.0,
                      padding: 4.0,
                      activeColor: const Color.fromARGB(255, 5, 208, 223),
                      inactiveColor: Colors.grey.shade300,
                      onToggle: (val) {
                        Navigator.pop(context);
                        // Call your toggle logic here
                      },
                    ),
                  ],
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
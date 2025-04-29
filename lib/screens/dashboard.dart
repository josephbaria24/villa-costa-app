// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fitness_tracker/provider/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitness_tracker/model/note_model.dart';
import 'package:fitness_tracker/components/note_storage.dart';
class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _MyWidgetState();
}

List<Map<String, dynamic>> notes = [];

class _MyWidgetState extends ConsumerState<Dashboard> {
 


List<Note> _notes = [];

@override
void initState() {
  super.initState();
  _loadNotes();
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
      appBar: AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false, // remove default back icon
      title: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('lib/assets/icons/fit.jpg'), // or use FileImage / NetworkImage
          ),
          SizedBox(width: 10),
          Text(
            "Hi, Joseph",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600
              ),
          ),
        ],
      ),
      actions: [
        
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.blueGrey.withOpacity(0.08)
          ),
          child: IconButton(
            icon: Icon(Icons.menu, color: Colors.black, size: 22,),
            onPressed: () {
              // open drawer or perform another action
            },
          ),
        ),
        SizedBox(width: 15,),
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
              child: GridView.builder(
              itemCount: _notes.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                final note = _notes[index];

                // Apply filter
                if (ref.watch(selectedFilterProvider) == 'Important' && !note.isImportant) {
                  return SizedBox.shrink(); // Hide if not important
                }

                return Container(
                  decoration: BoxDecoration(
                    color: note.color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Text(
                    note.content,
                    style: TextStyle(color: Colors.black),
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
    );
  }
}
import 'package:flutter/material.dart';

class Song {
  final String title;
  final String artist;

  Song({required this.title, required this.artist});
}

class Album {
  final String title;
  final String artist;
  final String coverImagePath;
  final List<Song> songs;

  Album({required this.title, required this.artist, required this.coverImagePath, required this.songs});
}

class Band {
  final String name;
  final List<Album> albums;

  Band({required this.name, required this.albums});
}

class MusicPage extends StatefulWidget {
  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  bool showAlbumsView = true;
  bool showAlbumSongsView = false;
  Album? selectedAlbum;

  List<Band> bands = [
    Band(
      name: 'Mike Oldfield',
      albums: [
        Album(
          title: 'Tubular Bells',
          artist: 'Mike Oldfield',
          coverImagePath: 'assets/tubular.png',
          songs: [
            Song(title: 'Tubular Bells Part 1', artist: 'Mike Oldfield'),
            Song(title: 'Tubular Bells Part 2', artist: 'Mike Oldfield'),
            Song(title: 'Tubular Bells Part 3', artist: 'Mike Oldfield'),
            // Add more songs
          ],
        ),
      ],
    ),
    Band(
      name: 'Enigma',
      albums: [
        Album(
          title: 'MCMXC a.D.',
          artist: 'Enigma',
          coverImagePath: 'assets/enigma.png',
          songs: [
            Song(title: 'Sadeness', artist: 'Enigma'),
            Song(title: 'Mea Culpa', artist: 'Enigma'),
            // Add more songs
          ],
        ),
      ],
    ),
    Band(
      name: 'Tangerine Dream',
      albums: [
        Album(
          title: 'Phaedra',
          artist: 'Tangerine Dream',
          coverImagePath: 'assets/tangerine.png',
          songs: [
            Song(title: 'Phaedra', artist: 'Tangerine Dream'),
            Song(title: 'Mysterious Semblance at the Strand of Nightmares', artist: 'Tangerine Dream'),
            // Add more songs
          ],
        ),
      ],
    ),
    Band(
      name: 'Jan Hammer',
      albums: [
        Album(
          title: 'The First Seven Days',
          artist: 'Jan Hammer',
          coverImagePath: 'assets/jan.png',
          songs: [
            Song(title: 'Darkness / Earth in Search of a Sun', artist: 'Jan Hammer'),
            Song(title: 'Light / Sunlight', artist: 'Jan Hammer'),
            // Add more songs
          ],
        ),
      ],
    ),
  ];

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music'),
        actions: [
          IconButton(
            icon: showAlbumsView ? Icon(Icons.list) : Icon(Icons.album),
            onPressed: () {
              setState(() {
                showAlbumsView = !showAlbumsView;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              _showInformationDialog(context);
            },
            padding: EdgeInsets.only(right: 16.0, left: 16.0),
          ),
        ],
      ),
      body: Column(
        children: [
          if (showAlbumsView)
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200, // Adjust the size of each album
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 0.8,
                ),
                itemCount: bands.length,
                itemBuilder: (context, bandIndex) {
                  Band band = bands[bandIndex];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          band.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final double availableWidth = constraints.maxWidth;
                            if (availableWidth.isFinite && availableWidth > 200) {
                              final int itemCount = (availableWidth / 200).floor();
                              final int rows = (band.albums.length / itemCount).ceil();
                              final double itemWidth = availableWidth / itemCount;

                              return GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: itemCount,
                                  childAspectRatio: itemWidth / (itemWidth + 60),
                                ),
                                itemCount: band.albums.length,
                                itemBuilder: (context, albumIndex) {
                                  Album album = band.albums[albumIndex];
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedAlbum = album;
                                        showAlbumsView = false;
                                        showAlbumSongsView = true;
                                      });
                                    },
                                    child: Card(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(8.0),
                                            ),
                                            child: Image.asset(
                                              album.coverImagePath,
                                              width: double.infinity,
                                              height: 120,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              album.title,
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              // Fallback to a vertical list if available width is not valid
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: band.albums.length,
                                itemBuilder: (context, albumIndex) {
                                  Album album = band.albums[albumIndex];
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedAlbum = album;
                                        showAlbumsView = false;
                                        showAlbumSongsView = true;
                                      });
                                    },
                                    child: Card(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(8.0),
                                            ),
                                            child: Image.asset(
                                              album.coverImagePath,
                                              width: double.infinity,
                                              height: 120,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              album.title,
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            )
          else if (showAlbumSongsView)
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            setState(() {
                              showAlbumsView = true;
                              showAlbumSongsView = false;
                            });
                          },
                        ),
                        Text(
                          selectedAlbum!.title,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: selectedAlbum!.songs.length,
                      itemBuilder: (context, index) {
                        Song song = selectedAlbum!.songs[index];
                        return ListTile(
                          title: Text(song.title),
                          subtitle: Text(song.artist),
                          onTap: () {
                            // Handle song selection
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          else
            Expanded(
              child: _buildAllSongsList(),
            ),
          Container(
            color: Color.fromARGB(255, 85, 85, 85),
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  onPressed: () {
                    // Handle previous song
                  },
                ),
                IconButton(
                  icon: Icon(Icons.replay_10),
                  onPressed: () {
                    // Handle rewind 15 seconds
                  },
                ),
                IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () {
                    // Handle play/resume
                  },
                ),
                IconButton(
                  icon: Icon(Icons.forward_10),
                  onPressed: () {
                    // Handle forward 15 seconds
                  },
                ),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  onPressed: () {
                    // Handle next song
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllSongsList() {
    List<Song> allSongs = [];
    for (Band band in bands) {
      for (Album album in band.albums) {
        allSongs.addAll(album.songs);
      }
    }

    return ListView.builder(
      itemCount: allSongs.length,
      itemBuilder: (context, index) {
        Song song = allSongs[index];
        return ListTile(
          title: Text(song.title),
          subtitle: Text(song.artist),
          onTap: () {
            // Handle song selection
          },
        );
      },
    );
  }
}

void _showInformationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Page Information'),
        content: SingleChildScrollView(
          child: Container(
            width: 400.0, // Adjust the width as needed
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to the Music Page!',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}
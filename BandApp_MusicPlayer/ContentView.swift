//
//  ContentView.swift
//  BandApp_MusicPlayer
//
//  Created by David on 2021-02-03.
//

import SwiftUI

struct Album : Hashable {
    var id = UUID()
    var name : String
    var image : String
    var songs : [Song]
}

struct Song : Hashable {
    var id = UUID()
    var name : String
    var time : String
    
}

struct ContentView: View {
    
    var albums = [Album(name: "Album 1", image: "1",
                        songs: [Song(name:"Song 1", time: "3:11"),
                                Song(name:"Song 2", time: "3:11"),
                                Song(name:"Song 3", time: "3:11"),
                                Song(name:"Song 4", time: "3:11"),
                                Song(name:"Song 5", time: "3:11"),
                                Song(name:"Song 6", time: "3:11")]),
    
    
                  Album(name: "Album 1", image: "2",
                                    songs:    [Song(name:"Song 1", time: "3:11"),
                                              Song(name:"Song 2", time: "3:11"),
                                              Song(name:"Song 3", time: "3:11"),
                                              Song(name:"Song 4", time: "3:11"),
                                              Song(name:"Song 5", time: "3:11"),
                                              Song(name:"Song 6", time: "3:11")]),
                  
                  Album(name: "Album 2", image: "3",
                                       songs: [Song(name:"Song 1", time: "3:11"),
                                              Song(name:"Song 2", time: "3:11"),
                                              Song(name:"Song 3", time: "3:11"),
                                              Song(name:"Song 4", time: "3:11"),
                                              Song(name:"Song 5", time: "3:11"),
                                              Song(name:"Song 6", time: "3:11")])]
                  
                 
    
    
    
    
    
                 
    
    
    var currentAlbum : Album?
    
    
    var body: some View {
        NavigationView{
            ScrollView{
                ScrollView(.horizontal, showsIndicators: false, content: {
                    ForEach(self.albums, id:\.self, content: {
                        album in
                        AlbumArt(album: album)
                        
                        
                    })
                            
                })
                LazyVStack{
                    ForEach((self.currentAlbum?.songs ?? self.albums.first?.songs) ??
                                        [Song(name:"Song 1", time: "3:11"),
                                          Song(name:"Song 2", time: "3:11"),
                                          Song(name:"Song 3", time: "3:11"),
                                          Song(name:"Song 4", time: "3:11"),
                                          Song(name:"Song 5", time: "3:11"),
                                          Song(name:"Song 6", time: "3:11")],
                    id: \.self,
                    content: {
                    song in
                        SongCell(song: song)
                })
                    
                }
                    
                
            }
        }
    }
}

struct AlbumArt : View{
    var album : Album
    var body: some View {
        EmptyView()
    }
}

struct SongCell : View{
    var song : Song
    var body: some View{
        EmptyView()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

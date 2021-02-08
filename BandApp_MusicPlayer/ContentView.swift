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
    
    var albums = [Album(name: "Patterns", image: "1",
                        songs: [Song(name:"Analogy", time: "3:11"),
                                Song(name:"From Sunrise to Sunset", time: "4:13"),
                                Song(name:"Above the Trees", time: "3:38"),
                                Song(name:"Time Foreseen", time: "3:42"),
                                Song(name:"Stranded Major", time: "4:44"),
                                Song(name:"Defrost", time: "2:54")]),
    
    
                  Album(name: "Collabs", image: "3",
                                    songs:    [Song(name:"Ovodu ft. Librim, Irina Anis", time: "2:19"),
                                              Song(name:"Sunday Love Story ft. Librim, Irina Anis", time: "4:03")]),
                  
                  Album(name: "Demos", image: "2",
                                       songs: [Song(name:"Song 1", time: "3:11"),
                                              Song(name:"Song 2", time: "3:11"),
                                              Song(name:"Song 3", time: "3:11"),
                                              Song(name:"Song 4", time: "3:11"),
                                              Song(name:"Song 5", time: "3:11"),
                                              Song(name:"Song 6", time: "3:11")])]
                  
                 
    
    
    
    
    
                 
    
    
    @State private var currentAlbum : Album?
    
    
    var body: some View {
        NavigationView{
            ScrollView{
                ScrollView(.horizontal, showsIndicators: false, content: {
                    LazyHStack{
                            ForEach(self.albums, id:\.self, content: {
                            album in
                                AlbumArt(album: album, isWithText: true).onTapGesture {
                                    self.currentAlbum = album
                                }
                    })
                    }
                            
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
                        SongCell(album: currentAlbum ?? albums.first!, song: song)
                })
                    
                }
                    
                
            }.navigationTitle("Sinemark")
        }
    }
}

struct AlbumArt : View{
    var album : Album
    var isWithText : Bool
    var body: some View {
        ZStack (alignment: .bottom, content: {
        
            Image(album.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 170, height: 200, alignment: .center)
            
            if isWithText == true {
            ZStack {
                Blur(style: .dark)
                Text(album.name).foregroundColor(.white)
            }.frame(height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
        }
    }).frame(width: 170, height: 200,alignment: .center) .clipped().cornerRadius(20).shadow(radius: 10).padding(20)
            
                
    }
}

struct SongCell : View{
    var album : Album
    var song : Song
    var body: some View{
        NavigationLink(
            destination: PlayerView(album: album, song: song), label: {
                    HStack{
                            ZStack{
                                Circle().frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                Circle().frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(.white)
                            }
                            Text(song.name).bold()
                            Spacer()
                            Text(song.time)
                        }.padding(20)
            
            }).buttonStyle(PlainButtonStyle())
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  BandApp_MusicPlayer
//
//  Created by David on 2021-02-03.
//

import SwiftUI
import Firebase



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

    @ObservedObject var data : MyData
    @State private var currentAlbum : Album?
    
    
    var body: some View {
        NavigationView{
            ScrollView{
                ScrollView(.horizontal, showsIndicators: false, content: {
                    LazyHStack{
                        ForEach(self.data.albums, id:\.self, content: {
                            album in
                                AlbumArt(album: album, isWithText: true).onTapGesture {
                                    self.currentAlbum = album
                                }
                    })
                    }
                            
                })
                LazyVStack{
                    if self.data.albums.first == nil {
                        EmptyView()
                        
                    }else {
                        ForEach((self.currentAlbum?.songs ?? self.data.albums.first?.songs) ??
                                            [Song(name:"Song 1", time: "3:11"),
                                              Song(name:"Song 2", time: "3:11"),
                                              Song(name:"Song 3", time: "3:11"),
                                              Song(name:"Song 4", time: "3:11"),
                                              Song(name:"Song 5", time: "3:11"),
                                              Song(name:"Song 6", time: "3:11")],
                        id: \.self,
                        content: {
                        song in
                            SongCell(album: currentAlbum ?? self.data.albums.first!, song: song)
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


}

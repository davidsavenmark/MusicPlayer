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
    var file : String
    
}

struct ContentView: View {

    @ObservedObject var data : MyData
    @State private var currentAlbum : Album?
    
    // This the body for the main view where you scroll through the albums and the songs -
    // ( 32 - 66 )
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
                        ForEach((self.currentAlbum?.songs ?? self.data.albums.first?.songs) ?? [Song(name: "", time: "", file: "")],
                                            
                        id: \.self,
                        content: {
                        song in
                            SongCell(album: currentAlbum ?? self.data.albums.first!, song: song)
                })
                    
                }
                    
             //When the user is having the musicplayer display active, he/she can go back to the main navigation view where all the albums are by clicking on the navigationTitle far up to the left side of the screen.
            }.navigationTitle("Sinemark")
        }
    }
}

}
// The variables in the AlbumArt structure also gets called upon when the user enters the musicplayer view ( PlayerView ) in order to display the albumart and the background blur effect.
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

// When a song gets clicked, it sends the user to the musicplayer which has its code and design in the PlayerView file.
struct SongCell : View{
    var album : Album
    var song : Song
    var body: some View{
        NavigationLink(
            destination: PlayerView(album: album, song: song), label: {
                    HStack{
                            ZStack{
                                Circle().frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                Circle().frame(width: 15, height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(.white)
                            }
                            Text(song.name).bold()
                            Spacer()
                            Text(song.time)
                        }.padding(20)
            
            }).buttonStyle(PlainButtonStyle())
    }
    
}




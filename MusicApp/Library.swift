//
//  Libary.swift
//  MusicApp
//
//  Created by Артем Гаршин on 02.09.2023.
//

import SwiftUI

struct Library: View {
    var body: some View {
        NavigationView {
            VStack{
                GeometryReader{ geometry in
                    HStack(spacing: 20){
                        Button {
                            print("12345")
                        } label: {
                            Image(systemName: "play.fill")
                                .frame(width: geometry.size.width / 2 - 10, height: 50)
                                .accentColor(Color.init(#colorLiteral(red: 1, green: 0.1719063818, blue: 0.4505617023, alpha: 1)))
                                .background(Color.init(uiColor: #colorLiteral(red: 1, green: 0.9, blue: 1, alpha: 1)))
                                .cornerRadius(10)
                        }
                        Button {
                            print("12345")
                        } label: {
                            Image(systemName: "arrow.2.circlepath")
                                .frame(width: geometry.size.width / 2 - 10, height: 50)
                                .accentColor(Color.init(#colorLiteral(red: 1, green: 0.1719063818, blue: 0.4505617023, alpha: 1)))
                                .background(Color.init(uiColor: #colorLiteral(red: 1, green: 0.9, blue: 1, alpha: 1)))
                                .cornerRadius(10)
                        }
                        
                    }
                }.padding(.horizontal).frame(height: 50)
                Divider().padding(.leading).padding(.trailing)

                List{
                    LibraryCell()
                    Text("Second")
                    Text("Third")
                }
                .listStyle(PlainListStyle())
            }
                .navigationBarTitle("Library")
        }
    }
}

struct LibraryCell: View {
    var body: some View {
        HStack{
            Image("LoveSosa").resizable().frame(width: 60,height: 60).cornerRadius(2)
            VStack{
                Text("TrackName")
                Text("ArtistName")
            }
        }
    }
}


struct Libary_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}

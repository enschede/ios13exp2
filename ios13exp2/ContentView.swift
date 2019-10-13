//
//  ContentView.swift
//  ios13exp2
//
//  Created by Marc Enschede on 30/09/2019.
//  Copyright © 2019 Marc Enschede. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @State var showFavoritesOnly = false
    
    @FetchRequest(entity: Building.entity(), sortDescriptors: [])
    var buildings: FetchedResults<Building>
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }
                
                ForEach(self.buildings.filter({b in self.showFavoritesOnly || b.favourite}), id: \.self) { building in
                    NavigationLink(destination:
                        VStack {
                            Image(building.image)
                                .resizable()
                                .aspectRatio(contentMode: ContentMode.fit)
                            
                            HStack {
                                Text(building.name)
                                    .font(Font.largeTitle)
                                
                                Spacer()
                                
                                Button(action: {
                                    building.favourite.toggle()
                                    do {
                                        try self.moc.save()
                                    } catch {
                                        print("Whoop...")
                                    }
                                }) {
                                    if building.favourite {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(Color.yellow)
                                    } else {
                                        Image(systemName: "star")
                                            .foregroundColor(Color.gray)
                                    }
                                }
                                
                            }
                            
                            HStack {
                                Text(building.location)
                                    .lineLimit(nil)
                                Spacer()
                            }
                            
                            Spacer()
                        }.padding()
                    ) {
                        Text(building.name)
                    }
                }
                
                Button(action: {
                    
//                    let _ = Building(context: self.moc, name: "Zara", location: "Van Heekplein", image: "Zara")
//                    let _ = Building(context: self.moc, name: "Hudsons Bay", location: "Van Heekplein", favourite: true, image: "Hudsons Bay")
//                    let _ = Building(context: self.moc, name: "Performance Factory", location: "Hoge Bothofstraat", image: "Performance Factory")
//                    let _ = Building(context: self.moc, name: "Saxion", location: "De Ruijterlaan", image: "Saxion")
//                    let _ = Building(context: self.moc, name: "Twentsche Bank", location: "Hoedemakersplein", image: "Twentsche Bank")
//                    let _ = Building(context: self.moc, name: "Station", location: "Stationsplein", image: "Stadion")
//                    let _ = Building(context: self.moc, name: "Stadhuis", location: "Langestraat", image: "Stadhuis")
//                    let _ = Building(context: self.moc, name: "Klanderij", location: "Klanderij", favourite: true, image: "Klanderij")
//                    let _ = Building(context: self.moc, name: "Stadskantoor", location: "Hengelosestraat", image: "Stadskantoor")
//                    let _ = Building(context: self.moc, name: "Alphatoren", location: "Mooienhof", image: "Alphatoren")
//                    let _ = Building(context: self.moc, name: "Grolsch Veste", location: "Colosseum", favourite: true, image: "Grolsch Veste")
//                    let _ = Building(context: self.moc, name: "Primark", location: "Van Heekplein", image: "Primark")
                    
                    do {
                        try self.moc.save()
                    } catch {
                        print("Whoop...")
                    }
                }) {
                    Text("Add")
                }
            }.navigationBarTitle("Buildings in Enschede")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

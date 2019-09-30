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
    
    @FetchRequest(entity: Building.entity(), sortDescriptors: [])
    var buildings: FetchedResults<Building>
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(buildings, id: \.self) { building in
                        NavigationLink(destination:
                            VStack {
                                Image(building.image)
                                    .resizable()
                                    .aspectRatio(contentMode: ContentMode.fit)
                                Text(building.name)
                                    .font(Font.largeTitle)
                                Text(building.location)
                                Spacer()
                            }
                        ) {
                            Text(building.name)
                        }
                    }
                }
                
                Button(action: {
                    let newBuilding = Building(context: self.moc)
                    
                    newBuilding.name = "Saxion"
                    newBuilding.location = "Ripperdastraat"
                    newBuilding.favourite = false
                    newBuilding.image = "Saxion"
                    
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

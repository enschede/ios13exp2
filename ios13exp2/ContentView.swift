//
//  ContentView.swift
//  ios13exp2
//
//  Created by Marc Enschede on 30/09/2019.
//  Copyright © 2019 Marc Enschede. All rights reserved.
//

import SwiftUI
import Combine

class Person: ObservableObject {
    @Published var firstname: String = ""
    @Published var lastname: String = ""
    
    @Published var fullname: String = ""
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    private var fullnameComposeRule: AnyPublisher<String, Never> {
        Publishers.CombineLatest($firstname, $lastname)
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .map { fn, ln in
                return (fn == "" && ln == "") ? "" : "Hello \(self.firstname) \(ln)"
        }
        .eraseToAnyPublisher()
    }
    
    init() {
        fullnameComposeRule
            .receive(on: RunLoop.main)
            .map { fn in
                fn
        }
        .assign(to: \.fullname, on: self)
        .store(in: &cancellableSet)
    }
    
}

struct ContentView: View {
    
    @ObservedObject private var person = Person()
    @State private var showingSheet = false
    
    var body: some View {
        Form {
            TextField("Firstname", text: $person.firstname)
            TextField("Lastname", text: $person.lastname)
            
            if(person.fullname != "") {
                Text(person.fullname)
            }
            
            Button(action: {
                self.showingSheet.toggle()
            }) {
                Text("Show actionsheet")
            }.sheet(isPresented: $showingSheet) {
                DetailView(firstname: self.$person.firstname, lastname: self.$person.lastname)
            }
        }
    }
}

struct DetailView: View {
    @Binding var firstname: String
    @Binding var lastname: String
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Form {
            TextField("Firstname", text: $firstname)
            TextField("Lastname", text: $lastname)
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Dismiss")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

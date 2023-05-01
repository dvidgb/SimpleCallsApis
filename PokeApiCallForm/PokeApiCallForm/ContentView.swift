//
//  ContentView.swift
//  PokeApiCallForm
//
//  Created by David Bueno Castro on 1/5/23.
//

import SwiftUI


struct ContentView: View {
    
    @StateObject var viewModel: ViewModel =  ViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                ForEach(viewModel.pokemons, id: \.name) { pokemon in
                    Text(pokemon.name)
                }
            }
            .navigationTitle("Pokemons")
        }.onAppear {
            viewModel.getPokemons()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

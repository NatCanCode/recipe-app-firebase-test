//
//  ContentView.swift
//  RecipeTest
//
//  Created by N N on 10/11/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color("paleGreen")
            TabView {
                RecipeListView()
                    .tabItem {
                        Label("Recipes", systemImage: "fork.knife")
                    }
                AddedRecipeListView()
                    .environmentObject(AddRecipeViewModel())
                    .tabItem {
                        Label("My recipes", systemImage: "plus")
                    }
                FavoriteRecipeListView()
                    .tabItem {
                        Label("Favorites", systemImage: "heart")
                    }
            }
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

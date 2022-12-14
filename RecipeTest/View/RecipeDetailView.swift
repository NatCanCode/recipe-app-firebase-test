//
//  RecipeDetailView.swift
//  RecipeTest
//
//  Created by N N on 10/11/2022.
//

import SwiftUI

struct RecipeDetailView: View {
    //    Must give the detail view a sample recipe > RecipeModel extension created in RecipeData file
    let recipe: RecipeModel
    @EnvironmentObject public var favoriteVM: FavoriteViewModel
    @State private var value = 2
//    @State var circleSize: Float = 20.0
    let step = 1
    let range = 1...9
    
    var body: some View {
        List {
            VStack {
                if let recipe = recipe.image {
                    Image(recipe)
                        .resizable()
//                        .scaledToFit()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } else if let image = recipe.formImage {
                    image
                        .resizable()
//                        .scaledToFit()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.secondary)
                            .frame(maxHeight: 350)
                        Text("Yum Recipes")
                            .font(.title3)
                            .foregroundStyle(.secondary)
                    }
                }
                
                HStack {
                    Text(recipe.name)
                        .font(.title.bold())
                    //  Spacer()
                    //                    Text(recipe.category.rawValue)
                    //                        .foregroundColor(.secondary)
                }
                .padding()
                
                HStack {
                    if !recipe.description.isEmpty {
                        Text(recipe.description)
                            .foregroundColor(.secondary)
                    }
                }
                
            }
            .listRowBackground(Color("paleGreen"))
            //            .navigationBarHidden(true)
            
            VStack(alignment: .center){
                HStack(alignment: .center) {
                    IconsExtractedView(systemName: "clock.arrow.circlepath", indicator: String(recipe.prepTime) + " min")
                    IconsExtractedView(systemName: "cooktop", indicator: String(recipe.cookingTime) + " min")
                    IconsExtractedView(systemName: "stopwatch", indicator: String(recipe.restTime) + " min")
                }
                HStack(alignment: .center) {
                    IconsExtractedView(systemName: "star", indicator: recipe.level.rawValue)
                    IconsExtractedView(systemName: "bookmark", indicator: recipe.diet.rawValue)
                    IconsExtractedView(systemName: "leaf", indicator: recipe.season.rawValue)
                    IconsExtractedView(systemName: "eurosign", indicator: recipe.cost.rawValue)
                }
            }
            .listRowBackground(Color("paleGreen"))
            .padding(2)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
//            .background(.purple)
            .font(.subheadline)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
//            Use foregroundStyle instead of beackground for linear color text
            .background(
                    LinearGradient(
                        colors: [Color("darkGreen"), Color("mediumGreen"), Color("lightGreen")],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
            )
            
//            VStack {
//                HStack {
//                    Spacer()
//                    Stepper("Nombre de personnes", value: $value, in: range, step: step)
//                        .frame(width: 100, height: 50)
//                    Spacer()
//                }
//                HStack {
//                    Text("For \(value)")
//                    Image(systemName: "fork.knife")
//                }
//                Spacer()
//            }
//            .padding(.top)
//            .foregroundColor(.purple)
//            .fontWeight(.bold)
            
            
            //            if !recipe.description.isEmpty {
            //                VStack(alignment: .leading, spacing: 10) {
            //                    Text(recipe.description)
            //                        .foregroundColor(.secondary)
            //
            //                }
            //            }
            //            Spacer()
            
            if !recipe.ingredients.isEmpty {
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text("Ingredients")
                            .font(.title2.bold())
                        Text("for \(value)")
                            .font(.title2.bold())
                        Image(systemName: "fork.knife")
                            .fontWeight(.bold)
                        Spacer()
                        Stepper("Number of people", value: $value, in: range, step: step)
                            .frame(width: 50, height: 50)
                            .padding(8)
//                        Spacer()
                    }
                    VStack(alignment: .leading) {
                        ForEach(recipe.ingredients, id: \.self) { ingredient in
                            HStack(alignment: .center, spacing: 5) {
                                Image(ingredient.ingredientImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 50)
                                    .clipShape(Circle())
                                Text(ingredient.ingredientName)
//                                    .padding(.bottom)
                            }
                        }
                    }
                }
                .padding()
                .listRowBackground(Color("paleGreen"))
            }
            
            if !recipe.step.isEmpty {
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text("Method")
                            .font(.title2.bold())
                    }
                    VStack(alignment: .leading, spacing: 1) {
                        ForEach(recipe.step, id: \.self) { step in
                            VStack(alignment: .leading, spacing: 6) {
                                Text(step.title)
                                    .font(.title3.bold())
                                Text(step.description)
                                    .padding(.bottom)
                            }
                        }
                    }
                }
                .padding()
                .listRowBackground(Color("paleGreen"))
            }
        }
        .listStyle(.plain)
        .background(Color("paleGreen"))
        .scrollContentBackground(.hidden)
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    favoriteVM.deleteOrRemoveFavorite(recipe: recipe)
                }, label: {
                    Label("Add to favorites", systemImage: favoriteVM.favorites.contains(recipe) ? "heart.fill" : "heart")
                            .font(.title3)
                })
//                .foregroundColor(.purple)
                .foregroundStyle(
                    LinearGradient(
                        colors: [Color("darkGreen"), Color("mediumGreen"), Color("lightGreen")],
                            startPoint: .leading,
                            endPoint: .trailing
                    )
                )
            }
        }
        .navigationBarTitleDisplayMode(.inline)
//        .ignoresSafeArea()
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipeDetailView(recipe: .recipeSample)
                .environmentObject(FavoriteViewModel())
        }
    }
}

struct IconsExtractedView: View {
    var systemName: String
    var indicator: String
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: systemName)
            Text(indicator)
        }
        .padding(10)
    }
}


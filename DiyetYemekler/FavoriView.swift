//
//  FavoriView.swift
//  DiyetYemekler
//
//  Created by yasarkilic on 4.09.2023.
//

import SwiftUI

struct FavoriView: View {
    @EnvironmentObject var favoriteViewModel: FavoriteViewModel
    @State private var selectedRecipe: Recipe? 
    
    var body: some View {
        NavigationView {
            if favoriteViewModel.favoriteRecipes.isEmpty {
                VStack {
                    Image("favorite") 
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                    
                    Text("Favori Yok")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
                .navigationTitle("Favori Tariflerim")
            } else {
                List(favoriteViewModel.favoriteRecipes) { recipe in
                    Button(action: {
                        selectedRecipe = recipe
                    }) {
                        HStack {
                            Image(recipe.image)
                                .resizable()
                                .frame(width: 85, height: 85)
                                .cornerRadius(8)
                            
                            VStack(alignment: .leading) {
                                Text(recipe.name)
                                    .font(.headline)
                                    .padding()
                                    .foregroundColor(Color.black)  
                                
                                HStack {
                                    Text("Hazırlanma: \(recipe.preparationTime)")
                                        .foregroundColor(Color.black)  // Siyah renk
                                    Divider()
                                    Text("Pişme: \(recipe.cookingTime)")
                                        .foregroundColor(Color.black)  // Siyah renk
                                    Divider()
                                    Text("Kalori: \(recipe.calories)")
                                        .foregroundColor(Color.black)  // Siyah renk
                                    Divider()
                                    Text("Kişi: \(recipe.serves)")
                                        .foregroundColor(Color.black)  // Siyah renk
                                }
                                .font(.subheadline)
                            }
                        }
                    }
                    .sheet(item: $selectedRecipe) { recipe in
                        RecipeDetailView(recipe: recipe)
                            .environmentObject(favoriteViewModel)
                    }
                }
                .navigationTitle("Favori Tariflerim")
            }
        }
    }
}

struct FavoriView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriView()
            .environmentObject(FavoriteViewModel()) // Bu kısmı ön izleme için ekliyorum
    }
}



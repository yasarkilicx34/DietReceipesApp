//
//  FavoriteViewModel.swift
//  DiyetYemekler
//
//  Created by yasarkilic on 6.09.2023.
//
import SwiftUI
import Combine

class FavoriteViewModel: ObservableObject {
    @Published var favoriteRecipes: [Recipe] {
        didSet {
            if let encoded = try? JSONEncoder().encode(favoriteRecipes) {
                UserDefaults.standard.set(encoded, forKey: "FavoriteRecipes")
            }
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "FavoriteRecipes"),
           let decoded = try? JSONDecoder().decode([Recipe].self, from: data) {
            self.favoriteRecipes = decoded
        } else {
            self.favoriteRecipes = []
        }
    }

    
    func addFavorite(_ recipe: Recipe) {
        favoriteRecipes.append(recipe)
    }
    
    func removeFavorite(_ recipe: Recipe) {
        favoriteRecipes.removeAll { $0.id == recipe.id }
    }
    
    func isFavorite(_ recipe: Recipe) -> Bool {
        return favoriteRecipes.contains { $0.id == recipe.id }
    }
}



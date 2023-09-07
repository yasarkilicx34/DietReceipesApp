//
//  ReceipeDetailView.swift
//  DiyetYemekler
//
//  Created by yasarkilic on 6.09.2023.
//

import SwiftUI


struct Recipe: Identifiable, Encodable, Decodable {
    let id = UUID()
    let name: String
    let image: String
    let preparationTime: String
    let cookingTime: String
    let calories: String
    let serves: String
    let ingredients: [String]
    let steps: [String]
    let notes: String
}

struct RecipeDetailView: View {
    let recipe: Recipe
    
    @State private var selectedStepIndex: Int?
    @State private var showHeartFilled = false
    @State private var ingredientStates: [String: Bool] = [:]
    @EnvironmentObject var bucketViewModel: BucketViewModel
    @EnvironmentObject var favoriteViewModel: FavoriteViewModel

    @Environment(\.presentationMode) var presentationMode
    
    private func binding(for ingredient: String) -> Binding<Bool> {
        return .init(
            get: { self.ingredientStates[ingredient, default: false] },
            set: { self.ingredientStates[ingredient] = $0 }
        )
    }
  
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    Image(recipe.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                    
                    // Sağ üst köşede "Aşağı Ok" simgesi
                    HStack {
                        Spacer()
                        VStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "arrow.down.circle.fill")
                                    .foregroundColor(.black)
                                    .font(.title)
                                    .padding()
                            }
                            Spacer()
                        }
                    }
                    
                    // Sol üst köşede "Kalp" simgesi
                    HStack {
                        VStack {
                            Button(action: {
                                if favoriteViewModel.isFavorite(recipe) {
                                    favoriteViewModel.removeFavorite(recipe)
                                } else {
                                    favoriteViewModel.addFavorite(recipe)
                                }
                            }) {
                                Image(systemName: favoriteViewModel.isFavorite(recipe) ? "heart.fill" : "heart")
                                    .foregroundColor(favoriteViewModel.isFavorite(recipe) ? .red : .red.opacity(0.4))
                                    .font(.title)
                                    .padding()
                                    .background(favoriteViewModel.isFavorite(recipe) ? Color.red.opacity(0.1) : Color.clear)
                                    .cornerRadius(8)
                            }
                            Spacer()
                        }
                        Spacer()
                    }

                }
                
                Text(recipe.name)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray)
                
                HStack {
                    Text("Hazırlanma: \(recipe.preparationTime)")
                        .font(.footnote)
                    Divider()
                    Text("Pişme: \(recipe.cookingTime)")
                        .font(.footnote)
                    Divider()
                    Text("Kalori: \(recipe.calories)")
                        .font(.footnote)
                    Divider()
                    Text("Kişi: \(recipe.serves)")
                        .font(.footnote)
                }
                .frame(height: 55)
                
                Divider()
                
                VStack(alignment: .leading) {
                    HStack {
                        Image("malzemeler")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .padding(.leading, -9)
                        
                        Text("MALZEMELER")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ForEach(recipe.ingredients, id: \.self) { ingredient in
                        HStack {
                            Text(ingredient)
                            Spacer()
                            Button(action: {
                                if self.bucketViewModel.containsItem(ingredient) {
                                    self.bucketViewModel.removeItem(ingredient)
                                } else {
                                    self.bucketViewModel.addItem(ingredient)
                                }
                            }) {
                                Image(systemName: self.bucketViewModel.containsItem(ingredient) ? "trash" : "cart.badge.plus")
                            }
                            .frame(width: 40, height: 40)
                        }
                        .padding(.bottom, 5)
                        Divider()
                    }
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading) {
                    HStack {
                        Image("tarifler")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .padding(.leading, -9)
                        
                        Text("YAPILIŞ TARİFİ")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ForEach(recipe.steps.indices, id: \.self) { index in
                        VStack {
                            Button(action: {
                                selectedStepIndex = index
                            }) {
                                HStack {
                                    Text("\(index + 1).")
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)  // Bu satırı ekledik
                                    
                                    Text(recipe.steps[index])
                                        .foregroundColor(.black)  // Bu satırı ekledik
                                    Spacer()
                                }
                            }
                            .padding()
                            .background(selectedStepIndex == index ? Color.gray.opacity(0.3) : Color.clear)
                            .cornerRadius(8)
                            
                            Divider()
                                .background(selectedStepIndex == index ? Color.gray.opacity(0.3) : Color.clear)
                        }
                    }
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading) {
                    HStack {
                        Image("notes")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .padding(.leading, -9)
                        
                        Text("TARİF NOTU")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(recipe.notes)
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
    }
}


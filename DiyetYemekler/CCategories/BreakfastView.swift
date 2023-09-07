//
//  BreakfastView.swift
//  DiyetYemekler
//
//  Created by yasarkilic on 5.09.2023.
//

import SwiftUI

struct BreakfastView: View {
    let recipes = [
        Recipe(name: "Yulaf Ezmesi",
               image: "oatmealImage",
               preparationTime: "5 min",
               cookingTime: "10 min",
               calories: "250 kcal",
               serves: "2",
               ingredients: ["Yulaf", "Süt veya Su", "Meyve"],
               steps: ["Yulafı bir tencereye alın", "Süt veya su ekleyin", "Kaynamaya başlayana kadar karıştırın", "Üzerine meyve dilimleri ekleyin", "Servis yapın"],
               notes: "Hızlı, doyurucu ve sağlıklı bir kahvaltı seçeneği."
        ),

        Recipe(name: "Omlet",
               image: "omeletteImage",
               preparationTime: "5 min",
               cookingTime: "10 min",
               calories: "300 kcal",
               serves: "1",
               ingredients: ["Yumurta", "Sebzeler", "Peynir"],
               steps: ["Yumurtaları çırpın", "Sebzeleri doğrayın", "Tavanı ısıtın ve yumurtayı dökün", "Üzerine sebzeleri ve peyniri ekleyin", "Katlayarak pişirin"],
               notes: "Protein dolu bir kahvaltı."
        ),

        Recipe(name: "Avokado Ekmek",
               image: "avocadoToastImage",
               preparationTime: "5 min",
               cookingTime: "2 min",
               calories: "180 kcal",
               serves: "1",
               ingredients: ["Tam Buğday Ekmeği", "Avokado", "Limon"],
               steps: ["Ekmekleri dilimleyin ve kızartın", "Avokadoyu ezin", "Ezilmiş avokadoyu ekmek üstüne sürün", "Üzerine limon suyu gezdirin", "Tuz ve biberle tatlandırın"],
               notes: "Kolay ve hızlı bir kahvaltı seçeneği."
        ),

        Recipe(name: "Smoothie",
               image: "smoothieImage",
               preparationTime: "5 min",
               cookingTime: "0 min",
               calories: "150 kcal",
               serves: "1",
               ingredients: ["Meyve", "Yoğurt", "Su veya Süt"],
               steps: ["Meyveleri dilimleyin", "Dilimlenmiş meyveleri blendıra koyun", "Yoğurt ve sıvıyı ekleyin", "Karışımı iyice blendırda karıştırın", "Soğuk servis yapın"],
               notes: "Vitamin dolu bir kahvaltı."
        ),

        Recipe(name: "Çılbır",
               image: "cilbirImage",
               preparationTime: "5 min",
               cookingTime: "7 min",
               calories: "220 kcal",
               serves: "2",
               ingredients: ["Yumurta", "Yoğurt", "Sarımsak", "Tereyağı"],
               steps: ["Yoğurdu bir kaseye alın", "Sarımsakları ezin ve yoğurda karıştırın", "Yumurtaları haşlayın veya poşe yapın", "Tereyağını eritin", "Yumurtayı yoğurdun üzerine yerleştirin", "Üzerine eritilmiş tereyağı gezdirin"],
               notes: "Geleneksel bir Türk kahvaltısı."
        ),

        Recipe(name: "Chia Tohumlu Yoğurt",
               image: "chiaYogurtImage",
               preparationTime: "5 min",
               cookingTime: "0 min",
               calories: "200 kcal",
               serves: "1",
               ingredients: ["Yoğurt", "Chia Tohumu", "Meyve"],
               steps: ["Yoğurdu bir kaseye alın", "Chia tohumlarını ekleyin", "Karıştırıp birkaç dakika bekleyin", "Üzerine meyve dilimleri ekleyin", "Soğuk servis yapın"],
               notes: "Doyurucu ve sağlıklı bir kahvaltı."
        )

    ]

    @Binding var searchText: String
    @EnvironmentObject var bucketViewModel: BucketViewModel

    @State private var selectedRecipe: Recipe?

    var filteredRecipes: [Recipe] {
        recipes.filter { recipe in
            searchText.isEmpty || recipe.name.lowercased().contains(searchText.lowercased())
        }
    }

    var body: some View {
        ScrollView {
            VStack {
                ForEach(filteredRecipes, id: \.id) { recipe in
                    VStack {
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
                                        .foregroundColor(Color.black)  // Siyah renk
                                    
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
                        }

                        Divider()
                            .background(Color.white)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct BreakfastView_Previews: PreviewProvider {
    static var previews: some View {
        BreakfastView(searchText: .constant("")) // Test için boş bir binding değeri kullanıyoruz
            .environmentObject(BucketViewModel())
    }
}


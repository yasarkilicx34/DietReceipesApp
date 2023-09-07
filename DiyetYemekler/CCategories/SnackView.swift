//
//  SnackView.swift
//  DiyetYemekler
//
//  Created by yasarkilic on 5.09.2023.
//

import SwiftUI

struct SnackView: View {
    let recipes = [
        Recipe(name: "Yoğurtlu Meyve",
               image: "yogurtFruitImage",
               preparationTime: "5 min",
               cookingTime: "0 min",
               calories: "150 kcal",
               serves: "1",
               ingredients: ["Yoğurt", "Meyve", "Bal"],
               steps: ["Yoğurdu bir kaseye alın", "Meyveleri doğrayın ve ekleyin", "Üzerine bal gezdirin", "Karıştırın ve hemen servis yapın"],
               notes: "Bu sağlıklı atıştırmalık özellikle yaz aylarında ferahlatıcıdır."
        ),
        Recipe(name: "Cevizli Hurma",
               image: "dateNutImage",
               preparationTime: "10 min",
               cookingTime: "0 min",
               calories: "200 kcal",
               serves: "2",
               ingredients: ["Hurma", "Ceviz"],
               steps: ["Hurmaları ikiye bölün", "İçine bir ceviz yerleştirin", "Dilimlenmiş cevizlerle süsleyin", "Servis tabağına alın"],
               notes: "Bu atıştırmalık, enerji ihtiyacını karşılamak için idealdir."
        ),
        Recipe(name: "Sebzeli Humus",
               image: "veggieHummusImage",
               preparationTime: "15 min",
               cookingTime: "0 min",
               calories: "180 kcal",
               serves: "3",
               ingredients: ["Nohut", "Tahin", "Zeytinyağı", "Sebzeler"],
               steps: ["Nohutu blendıra alın", "Tahin, zeytinyağı ekleyin", "Karışım pürüzsüz olana kadar karıştırın", "Sebzeleri dilimleyin", "Humus ile sebzeleri servis yapın"],
               notes: "Lezzetli ve sağlıklı bir atıştırmalık."
        ),
        Recipe(name: "Avokado Ezmeli Kraker",
               image: "avocadoCrackerImage",
               preparationTime: "10 min",
               cookingTime: "0 min",
               calories: "170 kcal",
               serves: "2",
               ingredients: ["Avokado", "Kraker", "Limon"],
               steps: ["Avokadoyu ezin", "Limon suyu ekleyin ve karıştırın", "Krakerlerin üstüne avokado ezmeyi yayın", "Servis yapın"],
               notes: "Kolesterol dostu, doyurucu bir atıştırmalık."
        ),
        Recipe(name: "Çilekli Yoğurt",
               image: "strawberryYogurtImage",
               preparationTime: "7 min",
               cookingTime: "0 min",
               calories: "130 kcal",
               serves: "1",
               ingredients: ["Yoğurt", "Çilek", "Bal"],
               steps: ["Yoğurdu bir kaseye alın", "Çilekleri yıkayıp doğrayın", "Yoğurt ve çilekleri karıştırın", "Üzerine bal ekleyin", "Karıştırın ve servis yapın"],
               notes: "Düşük kalorili ve tatlı ihtiyacınızı karşılayacak bir atıştırmalık."
        ),
        Recipe(name: "Kabak Çubukları",
               image: "zucchiniSticksImage",
               preparationTime: "20 min",
               cookingTime: "15 min",
               calories: "160 kcal",
               serves: "3",
               ingredients: ["Kabak", "Zeytinyağı", "Baharatlar"],
               steps: ["Kabakları yıkayıp çubuk şeklinde doğrayın", "Baharatlar ve zeytinyağı ile marine edin", "Fırın tepsisine yerleştirin", "180 derece fırında 15 dakika pişirin", "Sıcak servis yapın"],
               notes: "Düşük kalorili ve besleyici bir atıştırmalık."
        )
    ]

    
    @Binding var searchText: String // <-- Ekledik
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
                ForEach(filteredRecipes, id: \.id) { recipe in // <-- filteredRecipes
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

struct SnackView_Previews: PreviewProvider {
    @State static var searchText = "" 
    
    static var previews: some View {
        SnackView(searchText: $searchText) 
            .environmentObject(BucketViewModel())
    }
}

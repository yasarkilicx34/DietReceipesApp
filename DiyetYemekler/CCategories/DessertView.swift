//
//  DessertView.swift
//  DiyetYemekler
//
//  Created by yasarkilic on 5.09.2023.
//

import SwiftUI

struct DessertView: View {
    let recipes = [
        Recipe(name: "Avokado Çikolatalı Puding",
               image: "avoChocoPuddingImage",
               preparationTime: "15 min",
               cookingTime: "0 min",
               calories: "250 kcal",
               serves: "2",
               ingredients: ["Avokado", "Kakao", "Bal veya Stevia"],
               steps: ["Avokadoyu soyun ve çekirdeğini çıkarın", "Kakao ve tatlandırıcıyı ekleyin", "Karışımı blendırda iyice karıştırın", "Soğuk servis yapın"],
               notes: "Sağlıklı ve lezzetli bir tatlı seçeneği."
        ),

        Recipe(name: "Meyve Dondurması",
               image: "fruitIcecreamImage",
               preparationTime: "10 min",
               cookingTime: "2 hours",
               calories: "180 kcal",
               serves: "4",
               ingredients: ["Muz", "Çilek", "Mango"],
               steps: ["Meyveleri doğrayın", "Doğradığınız meyveleri dondurucuda 2 saat bekletin", "Dondurulmuş meyveleri blendıra koyun ve püre haline getirin", "Servis yapmadan önce 10 dakika daha dondurun"],
               notes: "Tamamen meyveden oluşan doğal bir dondurma."
        ),

        Recipe(name: "Yoğurtlu Çilek",
               image: "strawberryYogurtImage",
               preparationTime: "5 min",
               cookingTime: "0 min",
               calories: "100 kcal",
               serves: "1",
               ingredients: ["Çilek", "Yoğurt", "Bal"],
               steps: ["Çilekleri yıkayın", "Yoğurdu bir kaseye koyun", "Çilekleri yoğurdun üzerine yerleştirin", "Üzerine biraz bal gezdirin"],
               notes: "Hafif ve ferahlatıcı bir tatlı."
        ),

        Recipe(name: "Kabak Tarator",
               image: "pumpkinTaratorImage",
               preparationTime: "20 min",
               cookingTime: "30 min",
               calories: "200 kcal",
               serves: "4",
               ingredients: ["Kabak", "Ceviz", "Yoğurt"],
               steps: ["Kabağı rendeleyin", "Rendelenmiş kabağı bir tencerede soteleyin", "Yoğurt ve cevizleri ekleyin", "Karışımı soğuyana kadar bekletin"],
               notes: "Kabak ile farklı ve sağlıklı bir tatlı."
        ),

        Recipe(name: "Elma Püresi",
               image: "applePureeImage",
               preparationTime: "10 min",
               cookingTime: "20 min",
               calories: "150 kcal",
               serves: "2",
               ingredients: ["Elma", "Tarçın", "Su"],
               steps: ["Elmaları soyun ve doğrayın", "Doğradığınız elmaları bir tencereye koyun", "Biraz su ve tarçın ekleyin", "Elmalar yumuşayana kadar pişirin", "Blendırda püre haline getirin"],
               notes: "Bebeğiniz için de uygun, şeker içermeyen bir tatlı."
        ),

        Recipe(name: "Chia Tohumlu Puding",
               image: "chiaPuddingImage",
               preparationTime: "5 min",
               cookingTime: "3 hours",
               calories: "220 kcal",
               serves: "2",
               ingredients: ["Chia Tohumu", "Badem Sütü", "Vanilya"],
               steps: ["Chia tohumlarını bir kaseye alın", "Badem sütü ve vanilya ekleyin", "Karışımı iyice karıştırın", "Buzdolabında 3 saat veya bir gece bekletin", "Soğuk servis yapın"],
               notes: "Omega-3 kaynağı bir tatlı."
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

struct DessertView_Previews: PreviewProvider {
    static var previews: some View {
        DessertView(searchText: .constant("")) // Test için boş bir binding değeri kullanıyoruz
            .environmentObject(BucketViewModel())
    }
}


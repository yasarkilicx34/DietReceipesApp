import SwiftUI


struct MainCourseView: View {
    let recipes = [
        Recipe(name: "Kinoa ve Sebzeli Tavuk",
               image: "kinoatavuk",
               preparationTime: "20 min",
               cookingTime: "30 min",
               calories: "260 kcal",
               serves: "4",
               ingredients: ["Tavuk göğsü", "Kinoa", "Brokoli", "Kırmızı biber", "Zeytinyağı", "Tuz", "Karabiber"],
               steps: ["Kinoayı suda haşlayın.", "Tavuk göğsünü küçük parçalara ayırın.", "Zeytinyağında tavukları kavurun.", "Brokoli ve kırmızı biberi ekleyin.", "Haşlanmış kinoayı ekleyin.", "Tuz ve karabiberle tatlandırın.", "Kısık ateşte 5-10 dakika daha pişirin."],
               notes: "Bu yemek, protein ve lif açısından zengindir."
        ),

        Recipe(name: "Balık Buğulama",
               image: "balikbugu",
               preparationTime: "10 min",
               cookingTime: "20 min",
               calories: "180 kcal",
               serves: "2",
               ingredients: ["Levrek", "Limon", "Maydanoz", "Zeytinyağı", "Tuz", "Karabiber"],
               steps: ["Balığı temizleyin.", "Limon dilimleri ve maydanozu yerleştirin.", "Zeytinyağı, tuz ve karabiber serpin.", "Fırında 20 dakika buğulayın.", "Maydanoz ile garnitür yapın.", "Sıcak servis yapın."],
               notes: "Bu yemek, omega-3 açısından zengindir."
        ),

        Recipe(name: "Zeytinyağlı Ispanak",
               image: "zeytinyagli",
               preparationTime: "10 min",
               cookingTime: "10 min",
               calories: "120 kcal",
               serves: "4",
               ingredients: ["Ispanak", "Zeytinyağı", "Sarımsak", "Tuz", "Karabiber", "Limon"],
               steps: ["Ispanakları yıkayın ve doğrayın.", "Sarımsakları ezin.", "Zeytinyağı ve sarımsakla kavurun.", "Ispanakları ekleyin.", "Tuz, karabiber ve limon suyu ekleyin.", "Kısık ateşte 5 dakika pişirin."],
               notes: "Ispanak, demir ve vitamin K açısından zengindir."
        ),

        Recipe(name: "Karnabahar Pilavı",
               image: "karnabaharpilav",
               preparationTime: "15 min",
               cookingTime: "10 min",
               calories: "90 kcal",
               serves: "2",
               ingredients: ["Karnabahar", "Zeytinyağı", "Soğan", "Tuz", "Karabiber"],
               steps: ["Karnabaharı rendeleyin.", "Soğanı doğrayın.", "Zeytinyağında soğanı kavurun.", "Rendelenmiş karnabaharı ekleyin.", "Tuz ve karabiber ekleyin.", "Kısık ateşte 5 dakika pişirin.", "Servis yaparken nane yaprakları ile süsleyin."],
               notes: "Bu yemek düşük karbonhidratlı ve glutensizdir."
        ),

        Recipe(name: "Mantarlı Hindi Sote",
               image: "hindimantar",
               preparationTime: "10 min",
               cookingTime: "20 min",
               calories: "200 kcal",
               serves: "2",
               ingredients: ["Hindi eti", "Mantar", "Zeytinyağı", "Tuz", "Karabiber", "Kekik"],
               steps: ["Hindi etini doğrayın.", "Mantarları dilimleyin.", "Zeytinyağında hindi etini soteleyin.", "Mantarları ekleyin.", "Tuz, karabiber ve kekik ile tatlandırın.", "Orta ateşte 10 dakika daha pişirin."],
               notes: "Bu yemek, protein ve lif açısından zengindir."
        ),

        Recipe(name: "Düşük Kalorili Fırın Tavuk",
               image: "baked_chicken",
               preparationTime: "10 min",
               cookingTime: "40 min",
               calories: "250 kcal",
               serves: "4",
               ingredients: ["Tavuk but", "Zeytinyağı", "Tuz", "Karabiber", "Pul biber", "Sarımsak"],
               steps: ["Fırını 180 dereceye ısıtın.", "Tavuk butlarına zeytinyağı sürün.", "Tuz, karabiber, pul biber ve ezilmiş sarımsak ile marine edin.", "Fırın tepsisine yerleştirin.", "40 dakika boyunca fırında pişirin.", "Sıcak servis yapın."],
               notes: "Bu yemek, düşük yağlı ve yüksek protein içerir."
        )
    ]
    
    @Binding var searchText: String  // <-- Ekledik
    @EnvironmentObject var bucketViewModel: BucketViewModel

    @State private var selectedRecipe: Recipe?

    // Filtrelenmiş tarifler
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




struct MainCourseView_Previews: PreviewProvider {
    static var previews: some View {
        MainCourseView(searchText: .constant("")) 
            .environmentObject(BucketViewModel())
    }
}

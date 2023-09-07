//
//  HomeView.swift
//  DiyetYemekler
//
//  Created by yasarkilic on 4.09.2023.
//

import SwiftUI
import Combine

struct HomeView: View {
    @State private var searchText = ""
    @State private var selectedCategory: String? = "Main Course"
    
    let categories = [
        ["name": "Main Course", "image": "main-course"],
        ["name": "Snack", "image": "snack"],
        ["name": "Breakfast", "image": "breakfast"],
        ["name": "Dessert", "image": "dessert"]
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                
                Text("Diyet Tarifleri")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding([.top, .leading], 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                // SearchBar'ı bu bölgeye taşıdım, böylece her zaman sabit kalır.
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                
                ScrollView {
                    VStack {
                       
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(categories, id: \.self) { category in
                                    Button(action: {
                                        self.selectedCategory = category["name"]
                                    }) {
                                        Image(category["image"] ?? "")
                                            .resizable()
                                            .frame(width: 145, height: 220)
                                            .clipped()
                                            .cornerRadius(10)
                                            .shadow(color: .gray, radius: 15, x: 10, y: 5)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.top, 15)
                        }
                        
                        HStack {
                            Image("cooking")
                                .resizable()
                                .frame(width: 35, height: 35)
                            
                            Text("Tarifler")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                        }
                        .padding(.top, 10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        if let category = selectedCategory {
                            selectedView(category: category)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    
    @ViewBuilder
    func selectedView(category: String) -> some View {
        switch category {
        case "Main Course":
            MainCourseView(searchText: $searchText)
        case "Snack":
            SnackView(searchText: $searchText)
        case "Breakfast":
            BreakfastView(searchText: $searchText)
        case "Dessert":
            DessertView(searchText: $searchText)
        default:
            Text("Unknown Category")
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    var body: some View {
        HStack {
            TextField("Arama...", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}



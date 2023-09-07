//
//  SettingsView.swift
//  DiyetYemekler
//
//  Created by yasarkilic on 4.09.2023.
//

import SwiftUI

enum SelectedCard {
    case diet, app
}

struct SettingsView: View {
    @State private var selectedCard: SelectedCard? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    Spacer(minLength: 20)
                    
                    CardView(title: "Diyet Tarifleri",
                             icon: "leaf.arrow.circlepath",
                             description: "Diyet Tarifleri uygulaması sayesinde düşük kalorili tarifler öğrenebilirsiniz.",
                             isSelected: selectedCard == .diet,
                             tag: .diet,
                             selectedCard: $selectedCard)
                    .padding(.bottom, 40)
                    
                    CardView(title: "UYGULAMA",
                             icon: "apps.iphone",
                             description: "Geliştirici: Yaşar KILIÇ\nFikir Sahibi: Yaşar KILIÇ\nSürüm: 1.0.0",
                             isSelected: selectedCard == .app,
                             tag: .app,
                             selectedCard: $selectedCard)
                    
                    Spacer(minLength: 40)
                }
            }
            .padding([.horizontal, .top])
            .navigationBarTitle("Ayarlar")
        }
    }
}

struct CardView: View {
    var title: String
    var icon: String
    var description: String
    var isSelected: Bool
    var tag: SelectedCard
    @Binding var selectedCard: SelectedCard?
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "info.circle")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
            .padding(.bottom)
            
            Divider()
            
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 60))
                    .foregroundColor(.green)
                
                Text(description)
                    .font(.body)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                    .bold()
            }
        }
        .padding(.all, 20)
        .frame(maxWidth: .infinity)
        .background(isSelected ? Color.gray.opacity(0.2) : Color.white)
        .cornerRadius(12)
        .shadow(color: .gray, radius: 5, x: 0, y: 2)
        .padding(.bottom, 20)
        .onTapGesture {
            selectedCard = tag
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}







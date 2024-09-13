////
////  PokemonAbilityView.swift
////  PokemonTemplate
////
////  Created by Mai Tran on 9/12/24.
////
//
//import SwiftUI
//
//struct PokemonAbilityView: View {
//    let ability: PokemonDetailResponse.Ability
//    
//    @State private var showAbilityDetail = false
//    
//    var body: some View {
//        Button(action: {
//            showAbilityDetail.toggle()
//        }) {
//            Text(ability.ability.name.capitalized)
//                .font(.headline)
//                .padding()
//                .background(Color.blue.opacity(0.2))
//                .cornerRadius(0.2)
//        }
//        .sheet(isPresented: $showAbilityDetail) {
//            AbilityDetailView(ability: ability)
//        }
//    }
//}
//
//struct AbilityDetailView: View {
//    let ability: PokemonDetailResponse.Ability
//    
//    var body: some View {
//        
//        }
//    }
//}
//
//#Preview {
//    PokemonAbilityView()
//}

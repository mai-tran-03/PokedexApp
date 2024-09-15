////
////  AbilityDetailView.swift
////  PokemonTemplate
////
////  Created by Mai Tran on 9/13/24.
////
//
//import SwiftUI
//
//struct AbilityDetailView: View {
//    @ObservedObject var viewModel = PokemonViewModel()
//    
//    var body: some View {
//        VStack {
//            Text(viewModel.selectedAbilityEffect)
//                .padding()
//        }
//        .onAppear {
//            if let abilityEffect = ability {
//                viewModel.fetchAbilityDetails(for: abilityEffect, language: "en")
//            }
//        }
//    }
//}
//
//#Preview {
//    AbilityDetailView()
//}

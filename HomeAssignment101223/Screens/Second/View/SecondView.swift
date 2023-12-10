//
//  SecondView.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import SwiftUI

struct SecondView: View {
    @ObservedObject var viewModel: LocationViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.locationModel.hebrewName)
                    .font(.title)
//                Spacer().frame(width: 20)
                Text(viewModel.locationModel.englishName)
                    .font(.title)
            }
            .padding([.top, .leading, .trailing], 40)
            // Region
            Text(viewModel.locationModel.region)
                .font(.title)
                .padding([.leading, .trailing])
            Spacer().frame(height: 100)
            // Heart button
            Button(action: {
                viewModel.toggleLike()
            }) {
                Image(systemName: "heart")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .foregroundColor(.black)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(viewModel.isLiked ? Color.pink : Color.clear)     
        .ignoresSafeArea()
    }
}

//#Preview {
//    SecondView(
//        viewModel: .init(locationModel: LocationVisibleModel(
//            location: Location(
//                hebrewName: "לא רשום",
//                englishName: "Mock city",
//                region: "לא ידוע",
//                regionalCouncil: nil),
//                urlForImage: nil),
//        dataManager: DataManager(dataStore: DataStore())))
//}

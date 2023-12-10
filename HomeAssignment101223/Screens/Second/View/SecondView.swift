//
//  SecondView.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import SwiftUI

struct SecondView: View {
    @StateObject var viewModel: LocationViewModel

        var body: some View {
            VStack {
                Text(viewModel.locationModel.hebrewName)
                    .font(.title)
                    .padding()
                Text(viewModel.locationModel.englishName)
                    .font(.subheadline)
                    .padding()
                Text(viewModel.locationModel.region)
                    .font(.subheadline)
                    .padding()

                LikeButton(viewModel: viewModel)
                    .padding()

                Spacer()
            }
            .background(viewModel.isLiked ? Color.pink : Color.white)
            .onTapGesture {
                viewModel.toggleLike()
            }
        }
}

//#Preview {
//    SecondView(viewModel: <#LocationViewModel#>)
//}

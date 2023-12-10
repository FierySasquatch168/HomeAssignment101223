//
//  HeartButton.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import SwiftUI

struct LikeButton: View {
    @ObservedObject var viewModel: LocationViewModel

    var body: some View {
        Button(action: {
            viewModel.toggleLike()
        }) {
            Image(systemName: viewModel.isLiked ? "heart.fill" : "heart")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.red)
        }
    }
}

//#Preview {
//    LikeButton(viewModel: <#LocationViewModel#>)
//}

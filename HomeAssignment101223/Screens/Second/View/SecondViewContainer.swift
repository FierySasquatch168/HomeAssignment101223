//
//  SecondViewContainer.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import SwiftUI

struct SecondViewContainer: UIViewControllerRepresentable {
    @Binding var locationViewModel: LocationViewModel

    func makeUIViewController(context: Context) -> UIHostingController<SecondView> {
        return UIHostingController(rootView: SecondView(viewModel: locationViewModel))
    }

    func updateUIViewController(_ uiViewController: UIHostingController<SecondView>, context: Context) {
        // Update the UI if needed
    }
}

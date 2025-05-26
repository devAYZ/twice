//
//  LoadingView.swift
//  twice
//
//  Created by Ayokunle Fatokimi on 26/05/2025.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black)
                .opacity(0.5)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                ProgressView()
                    .scaleEffect(2)
                Text("Loading..")
                    .font(.title3)
            }
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white.opacity(0.8))
                .frame(width: 180, height: 180)
            }
            .offset(y: -80)
        }
    }
}

#Preview {
    LoadingView()
}

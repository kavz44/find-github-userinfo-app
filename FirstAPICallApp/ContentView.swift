//
//  ContentView.swift
//  FirstAPICallApp
//
//  Created by Kavin Gregary Anand on 28/09/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing:20) {
            Circle()
                .foregroundStyle(.secondary)
                .frame(width: 150, height: 150)
            Text("Username")
                .font(.title3)
                .bold()
            Text("GithubBIOen legges inn her, tekst tekst tekst teskt teskt tekst tesk")
                .padding()
        }
        .padding()
        
        // Spaceren pusher alt det over til å ligge øverst på skjermen
        Spacer()
    }
}

#Preview {
    ContentView()
}

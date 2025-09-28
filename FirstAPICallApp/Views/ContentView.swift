//
//  ContentView.swift
//  FirstAPICallApp
//
//  Created by Kavin Gregary Anand on 28/09/2025.
//

import SwiftUI


struct ContentView: View {
    @State private var user: GithubUser?
    @State private var searchThisUser: String = ""
    @StateObject var viewModel: GitHubViewModel = GitHubViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            AsyncImage(url: URL(string: user?.avatarUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                
            } placeholder: {
                Circle()
                    .foregroundStyle(.secondary)
            }
            .frame(width: 120, height: 120)
            
            
            Text(user?.login ?? "No user found")
                .font(.title3)
                .bold()
            Text(user?.bio ?? "No bio found")
                .padding()
            
            VStack(spacing: 1) {
                Text("Location: \(user?.location ?? "SECRET")")
                Text("GitHub account made: \(user?.createdAt ?? "UNKNOWN DATE")")
            }
            
            TextField("GitHub-username", text: $searchThisUser)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .frame(maxWidth: 300)
                .multilineTextAlignment(.center)
                .padding()
            
            
            Button(action: {
                Task {
                    await søkBruker()
                }
            }) {
                Text("Click to search")
            }
            
            
            // Spaceren pusher alt det over til å ligge øverst på skjermen
            Spacer()
        }
        .padding()
        // Her legges det til en async task som gjøres før view vises.
        .task{
            do {
                if searchThisUser != "" {
                    user = try await viewModel.getUser(username: searchThisUser)
                }
            } catch GHError.invalidURL {
                print("invalidURL")
            } catch GHError.invalidData {
                print("invalidData")
            } catch GHError.invalidResponse {
                print("invalidResponse")
            } catch {
                print("unexpected error")
            }
            
            
        }
    }
    
    // Søker opp brukeren
    func søkBruker() async {
        guard !searchThisUser.isEmpty else { return }
        
        do {
            user = try await viewModel.getUser(username: searchThisUser)
        } catch GHError.invalidURL {
            print("invalidURL")
        } catch GHError.invalidData {
            print("invalidData")
        } catch GHError.invalidResponse {
            print("invalidResponse")
        } catch {
            print("unexpected error")
        }
    }
        
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


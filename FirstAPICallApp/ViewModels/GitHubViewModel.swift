//
//  GitHubViewModel.swift
//  FirstAPICallApp
//
//  Created by Kavin Gregary Anand on 28/09/2025.
//
import Foundation
import SwiftUI
internal import Combine

class GitHubViewModel: ObservableObject {
    @Published var user: GithubUser?
    
    func getUser(username: String) async throws -> GithubUser {
        print("start hent fra getUser i viewmodel")
        let endpoint: String = "https://api.github.com/users/" + username
        
        // guard gjør at hvis url finnes så går den videre, ellers kastes Error
        guard let url = URL(string: endpoint) else {throw GHError.invalidURL}
        
        let(data, response) = try await URLSession.shared.data(from: url)
        
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Response is not HTTPURLResponse")
            throw GHError.invalidResponse
        }

        guard httpResponse.statusCode == 200 else {
            print("Status code:", httpResponse.statusCode)
            throw GHError.invalidResponse
        }
        
        // dekode JSON-objektet
        do{
            let decoder = JSONDecoder()
            return try decoder.decode(GithubUser.self, from:data)
        } catch {
            throw GHError.invalidData
        }
        //print("slutt hent fra getUser i viewmodel")
        
    }
    
    
}

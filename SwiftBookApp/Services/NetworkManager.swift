//
//  NetworkManager.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 8/31/23.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private let api = "https://swiftbook.ru//wp-content/uploads/api/api_courses"
    
    private init() {}
    
    func fetchData() -> [Course] {
        guard let url = URL(string: api) else { return [] }
        
        var courses: [Course] = []
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No Description")
                return
            }
            
            do {
                courses = try JSONDecoder().decode([Course].self, from: data)
            } catch {
                print("Error serialization json", error)
            }
        }.resume()
        
        return courses
    }
}

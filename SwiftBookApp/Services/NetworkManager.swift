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
    
    func fetchData(completion: @escaping (_ courses: [Course]) -> Void) {
        guard let url = URL(string: api) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No Description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let courses = try decoder.decode([Course].self, from: data)
                
                DispatchQueue.main.async {
                    completion(courses)
                }
            } catch {
                print("Error serialization json", error)
            }
        }.resume()
    }
}

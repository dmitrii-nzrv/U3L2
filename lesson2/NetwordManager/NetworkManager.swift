//
//  NetworkManager.swift
//  lesson2
//
//  Created by Dmitrii Nazarov on 14.09.2024.
//

import Foundation

class NetworkManager {
    func sendRequest(completion: @escaping ([Character]) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "rickandmortyapi.com"
        urlComponents.path = "/api/character"
        
        guard let url = urlComponents.url else {return}
        
        var urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard error == nil else {
                print(error!)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(CharacterResponse.self, from: data!)
                completion(result.results)
            } catch {
                
            }
            
        } .resume()
    }
}

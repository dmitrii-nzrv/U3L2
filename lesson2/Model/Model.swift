//
//  Model.swift
//  lesson2
//
//  Created by Dmitrii Nazarov on 19.09.2024.
//

import Foundation
 
struct CharacterResponse: Codable {
    let results: [Character]
}

struct Character: Codable {
    let name: String
    let species: String
   // let gender: String
    let image: String
}

//
//  JokeModel.swift
//  UIKit API
//
//  Created by Giorgio Giannotta on 19/02/23.
//

import Foundation

struct Joke: Decodable {
    let error: Bool
    let category: String
    let type: String
    let joke: String?
    let setup: String?
    let delivery: String?
    let flags: Flags
    let id: Int
    let safe: Bool
    let lang: String
    
    struct Flags: Decodable {
        let nsfw: Bool
        let religious: Bool
        let political: Bool
        let racist: Bool
        let sexist: Bool
        let explicit: Bool
    }
}

//
//  ModelForTest.swift
//  SnapKit_Tutorial
//
//  Created by Юлия Воротченко on 05.06.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import Foundation


struct DataModel: Decodable, Hashable {
    let id: String
    let author: Author
    let location: String
    let images: [String]
    let isLiked: Bool
    let isSaved: Bool
    let likedBy: [Author]
    let description: Description
    let createdTime: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case author = "author"
        case location = "location"
        case images = "images"
        case isLiked = "is_liked"
        case isSaved = "is_saved"
        case likedBy = "liked_by"
        case description = "description"
        case createdTime = "created_time"
    }
}

struct Author: Decodable, Hashable {
    let id: String
    let username: String
    let profileImage: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case username = "username"
        case profileImage = "profile_picture"
    }
}

struct Description: Decodable, Hashable {
    let text: String
    let author: Author
    
    enum CodingKeys: String, CodingKey {
       case text = "text"
       case author = "author"
    }
}

//
//  CellViewModel.swift
//  Anoda_Test_Task
//
//  Created by Юлия Воротченко on 17.06.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import Foundation

protocol PostModel: CellHeaderModel, CellImagesModel, CellDescriptionModel {}

struct PostModelImpl: PostModel {
    let profileImageUrl: String
    let userName: String
    let location: String
    let imagePaths: [String]
    let peopleWhoLiked: [String]
    let author: String
    let description: String
    let createdTime: String
}

protocol PostViewModel {
    func getPosts(complition: @escaping ([PostModel]) -> Void)
}

final class PostViewModelImpl: PostViewModel {
    
    // MARK: - Properties

    private let jsonParser: JSONParser

    // MARK: - Init and deinit

    init(jsonParser: JSONParser = JSONParserImpl()) {
        self.jsonParser = jsonParser
    }
    
    // MARK: - Public
    
    func getPosts(complition: @escaping ([PostModel]) -> Void) {
        let data = self.jsonParser.parseJSON(file: "json")
        switch data {
        case .success(let models):
            complition(models.map(self.createPostModel))
        case .failure(let error):
            print(error)
        }
    }
    
    private func createPostModel(from model: DataModel) -> PostModelImpl {
        return .init(profileImageUrl: model.author.profileImage,
                     userName: model.author.username,
                     location: model.location,
                     imagePaths: model.images,
                     peopleWhoLiked: model.likedBy.map { $0.username },
                     author: model.author.username,
                     description: model.description.text,
                     createdTime: model.createdTime)
    }

}

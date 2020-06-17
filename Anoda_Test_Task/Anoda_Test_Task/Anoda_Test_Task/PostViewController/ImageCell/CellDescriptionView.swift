//
//  CellDescriptionView.swift
//  Anoda_Test_Task
//
//  Created by Юлия Воротченко on 09.06.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import UIKit

final class CellDescriptionView: UIView {
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    private var likedByLabel: UILabel = {
        let likedByLabel = UILabel()
        likedByLabel.translatesAutoresizingMaskIntoConstraints = false
        likedByLabel.numberOfLines = 0
        return likedByLabel
    }()
    
    private var postDescriptionLabel: UILabel = {
        let postDescriptionLabel = UILabel()
        postDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        postDescriptionLabel.numberOfLines = 0
        return postDescriptionLabel
    }()
    
    private var createdTimeLabel: UILabel = {
        let createdTimeLabel = UILabel()
        createdTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        createdTimeLabel.numberOfLines = 1
        createdTimeLabel.font = UIFont(name: "NunitoSans-ExtraLight", size: 13)
        createdTimeLabel.textColor = .lightGray
        return createdTimeLabel
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func fill(with model: PostModel) {
        self.likedByLabel.attributedText = model.peopleWhoLiked
        self.postDescriptionLabel.attributedText = model.postDescription
        self.createdTimeLabel.text = model.createdTime
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        self.addSubview(self.stackView)
        self.stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().offset(-20)
            $0.centerX.equalToSuperview()
        }
        self.stackView.addArrangedSubview(self.likedByLabel)
        self.stackView.addArrangedSubview(self.postDescriptionLabel)
        self.stackView.addArrangedSubview(self.createdTimeLabel)
    }
}

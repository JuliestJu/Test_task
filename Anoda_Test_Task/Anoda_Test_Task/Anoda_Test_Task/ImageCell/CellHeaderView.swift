//
//  CellHeaderView.swift
//  Anoda_Test_Task
//
//  Created by Юлия Воротченко on 08.06.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class CellHeaderView: UIView {
    
    var primaryStackView: UIStackView = {
        let primaryStackView = UIStackView()
        primaryStackView.translatesAutoresizingMaskIntoConstraints = false
        primaryStackView.axis = .horizontal
        primaryStackView.layoutMargins.left = 5
        primaryStackView.isLayoutMarginsRelativeArrangement = true
        primaryStackView.spacing = 5
        primaryStackView.alignment = .center
        primaryStackView.distribution = .fill
        return primaryStackView
    }()
    
    var secondaryStackView: UIStackView = {
        let secondaryStackView = UIStackView()
        secondaryStackView.translatesAutoresizingMaskIntoConstraints = false
        secondaryStackView.axis = .vertical
        secondaryStackView.spacing = 5 //kkk
        secondaryStackView.alignment = .leading
        return secondaryStackView
    }()
    
    var authorProfileImage: UIImageView = {
        let authorProfileImage = UIImageView()
        authorProfileImage.contentMode = .scaleToFill
        authorProfileImage.layer.borderColor = UIColor.lightGray.cgColor
        authorProfileImage.layer.borderWidth = 1
        return authorProfileImage
    }()
    
    var authorNameLabel: UILabel = {
        let authorNameLabel = UILabel()
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.textAlignment = .left
        authorNameLabel.lineBreakMode = .byCharWrapping
        authorNameLabel.numberOfLines = 0
        authorNameLabel.textColor = .black
        authorNameLabel.font = UIFont(name: "ProximaNova-Regular", size: 17)
        return authorNameLabel
    }()
    
    var locationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.textAlignment = .left
        locationLabel.lineBreakMode = .byCharWrapping
        locationLabel.numberOfLines = 0
        locationLabel.textColor = .lightGray
        locationLabel.font = UIFont(name: "ProximaNova-Regular", size: 15)
        return locationLabel
    }()
    
    // MARK: - Buttons
    
    var authorButton: UIButton = {
        let locationButton = UIButton()
        return locationButton
    }()
    
    var locationButton: UIButton = {
        let locationButton = UIButton()
        return locationButton
    }()
    
    var authorNameButton: UIButton = {
        let locationButton = UIButton()
        return locationButton
    }()
    
    var actionButton: UIButton = {
        let actionButton = UIButton()
        actionButton.imageView?.contentMode = .center
        return actionButton
    }()
    
    
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    func setupUI() {
        
        self.addSubview(self.primaryStackView)
        self.primaryStackView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        self.primaryStackView.addArrangedSubview(self.authorProfileImage)
        self.authorProfileImage.snp.makeConstraints {
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
        
        self.authorProfileImage.addSubview(self.authorButton)
        self.authorButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        self.primaryStackView.addArrangedSubview(self.secondaryStackView)
        self.primaryStackView.addArrangedSubview(self.actionButton)
        self.actionButton.snp.makeConstraints {
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
        
        self.secondaryStackView.addArrangedSubview(self.authorNameLabel)
        self.secondaryStackView.addArrangedSubview(self.locationLabel)
        self.authorNameLabel.addSubview(self.authorNameButton)
        self.authorNameButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        self.locationLabel.addSubview(self.locationButton)
        self.locationButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        self.layoutIfNeeded()
    }
    
    private func uiElementsConfig() {
        self.authorProfileImage.layer.cornerRadius = self.authorProfileImage.frame.height / 2
        self.authorProfileImage.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.uiElementsConfig()
    }
    
    func fill(authorImageURL: String?, authorName: String, locaion: String) {
        guard let imageURL = authorImageURL else { return }
        let url = URL(string: imageURL)
        self.authorProfileImage.kf.setImage(with: url)
        self.authorNameLabel.text = authorName
        self.locationLabel.text = locaion
        self.actionButton.setImage(UIImage(named: "more"), for: .normal)
    }
}

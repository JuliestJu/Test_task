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

final class CellHeaderView: UIView {
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    private var authorProfileImage: UIImageView = {
        let authorProfileImage = UIImageView()
        authorProfileImage.contentMode = .scaleToFill
        authorProfileImage.layer.borderColor = UIColor.lightGray.cgColor
        authorProfileImage.layer.borderWidth = 1
        return authorProfileImage
    }()
    
    private var authorNameLabel: UILabel = {
        let authorNameLabel = UILabel()
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.textAlignment = .left
        authorNameLabel.lineBreakMode = .byCharWrapping
        authorNameLabel.numberOfLines = 0
        authorNameLabel.textColor = .black
        authorNameLabel.font = UIFont(name: "NunitoSans-Bold", size: 16)
        authorNameLabel.isUserInteractionEnabled = true
        authorNameLabel.text = "ajsjdkfkkfk xkckmcmv"
        return authorNameLabel
    }()
    
    private var locationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.textAlignment = .left
        locationLabel.lineBreakMode = .byCharWrapping
        locationLabel.numberOfLines = 0
        locationLabel.textColor = .darkGray
        locationLabel.font = UIFont(name: "NunitoSans-Regular", size: 14)
        locationLabel.isUserInteractionEnabled = true
        locationLabel.text = "dmmdmcmcmcm"
        return locationLabel
    }()
    
    // MARK: - Buttons
    
    private var authorButton: UIButton = {
        let authorButton = UIButton()
        authorButton.backgroundColor = .clear
        return authorButton
    }()
    
    private var actionButton: UIButton = {
        let actionButton = UIButton()
        actionButton.imageView?.contentMode = .center
        actionButton.setImage(UIImage(named: "more"), for: .normal)
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
    
    // MARK: - Public methods
    
    func fill(with model: PostModel) {
        let url = model.profileImage
        guard let imageURL = URL.init(string: url) else { return }
        self.authorProfileImage.kf.setImage(with: imageURL)
        self.authorNameLabel.text = model.userName
        self.locationLabel.text = model.location
        self.actionButton.setImage(UIImage(named: "more"), for: .normal)
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        self.snp.makeConstraints {
            $0.height.equalTo(55)
        }
        
        self.addSubview(self.authorProfileImage)
        self.authorProfileImage.snp.makeConstraints {
            $0.left.equalTo(self.snp.left).inset(12.0)
            $0.centerY.equalTo(self.snp.centerY)
            $0.height.width.equalTo(42.0)
        }
        
        self.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.authorNameLabel)
        self.stackView.addArrangedSubview(self.locationLabel)
        
        self.stackView.snp.makeConstraints {
            $0.left.equalTo(authorProfileImage.snp.right).offset(15.0)
            $0.right.equalToSuperview().inset(20.0)
            $0.top.equalToSuperview().inset(8.0)
            $0.bottom.equalTo(self.snp.bottom).inset(8.0)
        }
        
        self.addSubview(self.actionButton)
        self.actionButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(15)
            $0.centerY.equalTo(self.snp.centerY)
            $0.height.equalTo(self.snp.height)
        }
        
        self.authorProfileImage.addSubview(self.authorButton)
        self.authorButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.layoutIfNeeded()
    }
    
    private func authorImageConfigure() {
        self.authorProfileImage.layer.cornerRadius = self.authorProfileImage.frame.height / 2
        self.authorProfileImage.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.authorImageConfigure()
    }
}

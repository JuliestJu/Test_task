//
//  CellImageView.swift
//  Anoda_Test_Task
//
//  Created by Юлия Воротченко on 08.06.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import UIKit
import Kingfisher

final class CellImagesView: UIView {
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private var leftButtonsStackView: UIStackView = {
        let leftButtonsStackView = UIStackView()
        leftButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        leftButtonsStackView.axis = .horizontal
        leftButtonsStackView.spacing = 1
        leftButtonsStackView.distribution = .fillProportionally
        leftButtonsStackView.contentMode = .scaleAspectFill
        return leftButtonsStackView
    }()
    
    private var likeButton: UIButton = {
        let likeButton = UIButton()
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        return likeButton
    }()
    
    private var commentButton: UIButton = {
        let commentButon = UIButton()
        commentButon.translatesAutoresizingMaskIntoConstraints = false
        return commentButon
    }()
    
    private var shareButton: UIButton = {
        let shareButton = UIButton()
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        return shareButton
    }()
    
    private var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .systemBlue
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPage = 0
        return pageControl
    }()
    
    private var saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        return saveButton
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
    
    func fill(imageURLstrings: [String]) {
        self.arrangeScrollView(images: imageURLstrings, scrollView: self.scrollView)
        self.pageControl.numberOfPages = imageURLstrings.count
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
       
        self.addSubview(imageView)
        self.imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(self.imageView.snp.width)
        }
        
        self.addSubview(self.leftButtonsStackView)
        self.leftButtonsStackView.snp.makeConstraints {
            $0.top.equalTo(self.imageView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalTo(120)
        }
        
        self.leftButtonsStackView.addArrangedSubview(self.likeButton)
        self.likeButton.setImage(UIImage(named: "heart"), for: .normal)
    
        self.leftButtonsStackView.addArrangedSubview(self.commentButton)
        self.commentButton.setImage(UIImage(named: "comment"), for: .normal)
        
        self.leftButtonsStackView.addArrangedSubview(self.shareButton)
        self.shareButton.setImage(UIImage(named: "send"), for: .normal)
        
        self.addSubview(self.pageControl)
        self.pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.imageView.snp.bottom).offset(5)
        }
        
        self.addSubview(self.saveButton)
        self.saveButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(5)
            $0.top.equalToSuperview().inset(2)
            $0.bottom.equalToSuperview().inset(2)
        }
        self.saveButton.setImage(UIImage(named: "bookmark"), for: .normal)
        
        self.imageView.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.layoutIfNeeded()
    }
    
    private func arrangeScrollView(images: [String], scrollView: UIScrollView) {
        let imagesURLs = images.map { URL(string: $0) }
        imagesURLs.forEach {
            let imageView = UIImageView()
            imageView.kf.setImage(with: $0)
            imageView.contentMode = .scaleToFill
            scrollView.addSubview(imageView)
        }
    }
}

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
    
    private var actionsContainer: UIView = {
        let actionsContainer = UIView()
        return actionsContainer
    }()
    
    private var leftButtonsStackView: UIStackView = {
        let leftButtonsStackView = UIStackView()
        leftButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        leftButtonsStackView.axis = .horizontal
        leftButtonsStackView.spacing = 1
        leftButtonsStackView.distribution = .fillEqually
        leftButtonsStackView.contentMode = .scaleAspectFill
        return leftButtonsStackView
    }()
    
    private var likeButton: UIButton = {
        let likeButton = UIButton()
        likeButton.contentMode = .scaleToFill
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.backgroundColor = .blue
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
        saveButton.backgroundColor = .blue
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
        
        self.backgroundColor = .systemIndigo
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
            $0.height.equalTo(self.imageView.snp.width)
        }
        
        self.addSubview(self.actionsContainer)
        self.actionsContainer.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        self.actionsContainer.addSubview(self.leftButtonsStackView)
        self.actionsContainer.addSubview(self.pageControl)
        self.actionsContainer.addSubview(self.saveButton)
        
        self.leftButtonsStackView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        self.leftButtonsStackView.addArrangedSubview(self.likeButton)
        self.likeButton.setImage(UIImage(named: "heart"), for: .normal)
        self.likeButton.snp.makeConstraints {
            $0.width.height.equalTo(40)
        }
        
        self.leftButtonsStackView.addArrangedSubview(self.commentButton)
        self.commentButton.setImage(UIImage(named: "comment"), for: .normal)
        self.commentButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        
        self.leftButtonsStackView.addArrangedSubview(self.shareButton)
        self.shareButton.setImage(UIImage(named: "send"), for: .normal)
        self.shareButton.snp.makeConstraints {
            $0.width.height.equalTo(40)
        }
        
        
        self.pageControl.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.centerX.centerY.equalToSuperview()
        }
        
        self.saveButton.setImage(UIImage(named: "bookmark"), for: .normal)
        self.saveButton.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        
        
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

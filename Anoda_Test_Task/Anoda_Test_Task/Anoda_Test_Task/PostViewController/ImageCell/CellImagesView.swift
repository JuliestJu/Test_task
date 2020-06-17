//
//  CellImageView.swift
//  Anoda_Test_Task
//
//  Created by Юлия Воротченко on 08.06.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import UIKit
import Kingfisher

protocol CellImagesModel {
    var imagePaths: [String] { get }
}

struct CellImagesModelImpl: CellImagesModel {
    let imagePaths: [String]
}

final class CellImagesView: UIView, UIScrollViewDelegate {
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.indicatorStyle = .white
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
    
    func fill(with model: CellImagesModel) {
        self.arrangeScrollView(images: model.imagePaths)
        self.pageControl.numberOfPages = model.imagePaths.count
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        self.snp.makeConstraints {
            $0.height.equalTo(self.snp.width).offset(55)
        }
        
        self.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
            $0.height.equalTo(self.scrollView.snp.width)
        }
        
        self.addSubview(self.actionsContainer)
        self.actionsContainer.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(55)
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
            $0.centerX.centerY.equalToSuperview()
        }
        
        self.saveButton.setImage(UIImage(named: "bookmark"), for: .normal)
        self.saveButton.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        
        self.layoutIfNeeded()
    }
    
    private func arrangeScrollView(images: [String]) {
        let scrollView = self.scrollView
        let imagesURLs = images.compactMap(URL.init)
        var frame = CGRect.zero
        for index in 0..<imagesURLs.count {
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            let imageView = UIImageView(frame: frame)
            imageView.frame = frame
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: imagesURLs[index])
            scrollView.addSubview(imageView)
        }
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(images.count),
                                        height: scrollView.frame.size.height)
        scrollView.delegate = self
    }
    
    // MARK: - ScrollView Delegate
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = self.scrollView.contentOffset.x / self.scrollView.frame.size.width
        self.pageControl.currentPage = Int(pageNumber)
    }
}

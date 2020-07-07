//
//  ViewController.swift
//  Anoda_Test_Task
//
//  Created by Юлия Воротченко on 08.06.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import UIKit

final class PostViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: self.view.frame.width, height: 650)
        layout.minimumLineSpacing = 2
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private let postViewModel: PostViewModel
    private var postModels: [PostModel]?
    
    init(postViewModel: PostViewModel) {
        self.postViewModel = postViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        self.setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.postViewModel.getPosts { [weak self] in
            self?.postModels = $0
            self?.collectionView.reloadData()
        }
        
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        self.collectionView.register(PostCollecttionViewCell.self, forCellWithReuseIdentifier: PostCollecttionViewCell.identifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    // MARK: - CollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.postModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollecttionViewCell.identifier, for: indexPath) as! PostCollecttionViewCell
        let currentPost = self.postModels?[indexPath.item]
        currentPost.map(cell.fill)
        
        return cell
    }
}


//
//  CollectionViewCell.swift
//  Anoda_Test_Task
//
//  Created by Юлия Воротченко on 10.06.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import UIKit

final class PostCollecttionViewCell: UICollectionViewCell {
    
    static let identifier = "PostCollecttionViewCell"
    private let headerView = CellHeaderView()
    private let cellImagesView = CellImagesView()
    private let cellDescriptionView = CellDescriptionView()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    // MARK: - Inittialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    public func fill(model: PostModel) {
        self.headerView.fill(with: model)
        self.cellImagesView.fill(with: model)
        self.cellDescriptionView.fill(with: model)
    }
    
    // MARK: - Private methods
    
    func setupUI() {
        self.addSubview(self.stackView)
        self.stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.stackView.addArrangedSubview(self.headerView)
        self.headerView.snp.makeConstraints  {
            $0.left.right.equalToSuperview()
        }
        
        self.stackView.addArrangedSubview(self.cellImagesView)
        self.cellImagesView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        self.stackView.addArrangedSubview(self.cellDescriptionView)
        self.cellDescriptionView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        self.layoutIfNeeded()
    }
}

//
//  AppViewVC.swift
//  Three_AppStore
//
//  Created by 이윤수 on 2022/08/04.
//

import UIKit

import Then
import SnapKit

final class AppViewVC : UIViewController{
    
    var layoutInit = UICollectionViewLayout()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutInit).then{
        $0.delegate = self
        $0.dataSource = self
        $0.register(LargeCell.self, forCellWithReuseIdentifier: "LargeCell")
        $0.register(ListCell.self, forCellWithReuseIdentifier: "ListCell")
        $0.register(AppHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "AppHeaderCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
    }
}

private extension AppViewVC{
    func setView(){
        self.navigationItem.title = "앱"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        self.collectionView.collectionViewLayout = collectionViewLayout()
    }
    
    func collectionViewLayout() -> UICollectionViewLayout{
        return UICollectionViewCompositionalLayout{ [weak self]section, _ -> NSCollectionLayoutSection? in
            if section == 0{
                return self?.largeLayout()
            }else{
                return self?.listLayout()
            }
        }
    }
    
    func largeLayout() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalWidth(1.2))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalWidth(1.2))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 15)
        section.orthogonalScrollingBehavior = .continuous
        
        
        return section
    }
    
    func listLayout() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(80))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(350))
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(20))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)
        let hGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: group, count: 1)
        hGroup.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 15)
        
        let hedaer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        let section = NSCollectionLayoutSection(group: hGroup)
        section.contentInsets = .init(top: 0, leading: 15, bottom: 10, trailing: 15)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [hedaer]
        
        return section
    }
}

extension AppViewVC : UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 1 && kind == UICollectionView.elementKindSectionHeader{
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "AppHeaderCell", for: indexPath) as? AppHeaderCell else {return UICollectionReusableView()}
            header.mainTitle.text = "MAIN TITLE"
            header.moreBtn.setTitle("모두 보기", for: .normal)
            return header
        }
           return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LargeCell", for: indexPath) as? LargeCell else {return UICollectionViewCell()}
            cell.topTitle.text = "TOP TITLE"
            cell.subTitle.text = "SUB TITLE"
            cell.mainTitle.text = "MAIN TITLE"
            cell.imageView.backgroundColor = .blue
            
            return cell
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath) as? ListCell else {return UICollectionViewCell()}
            cell.appName.text = "APP NAME"
            cell.subTitle.text = "SUB TITLE"
            cell.icon.backgroundColor = .gray
            return cell
        }
    }
    
}

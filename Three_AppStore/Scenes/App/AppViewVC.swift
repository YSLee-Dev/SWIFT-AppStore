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
    
    var featureList : [Feature] = []
    var rankingFeatureList : [RankingFeature] = []
    
    var layoutInit = UICollectionViewLayout()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutInit).then{
        $0.delegate = self
        $0.dataSource = self
        $0.register(LargeCell.self, forCellWithReuseIdentifier: "LargeCell")
        $0.register(ListCell.self, forCellWithReuseIdentifier: "ListCell")
        $0.register(CodeBtnCell.self, forCellWithReuseIdentifier: "CodeBtnCell")
        $0.register(AppHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "AppHeaderCell")
        $0.register(SeparatorCell.self, forSupplementaryViewOfKind: "border", withReuseIdentifier: "border")
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
        
        self.featureDataFetch()
        self.rankingFeatureDataFetch()
        
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
            }else if section == 1{
                return self?.listLayout()
            }else {
                return self?.btnLayout()
            }
        }
    }
    
    func largeLayout() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1.2))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1.2))
        let borderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(0.5))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = .init(top: 10, leading: 15, bottom: 10, trailing: 15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        let border = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: borderSize, elementKind: "border", alignment: .bottom)
        section.boundarySupplementaryItems = [border]
        
        return section
    }
    
    func listLayout() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(70))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(280))
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(20))
        let borderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(0.5))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)
        group.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 15)
        let hGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: group, count: 1)
        
        
        let hedaer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        hedaer.contentInsets = .init(top: 30, leading: 15, bottom: 0, trailing: 15)
        
        let border = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: borderSize, elementKind: "border", alignment: .bottom)
        
        let section = NSCollectionLayoutSection(group: hGroup)
        section.orthogonalScrollingBehavior = .paging
        section.boundarySupplementaryItems = [hedaer, border]
        section.contentInsets = .init(top: 40, leading: 0, bottom: 10, trailing: 0)
        
        return section
    }
    
    func btnLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}

extension AppViewVC : UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return self.featureList.count
        }else if section == 1{
            return self.rankingFeatureList.count
        }else {
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 1 && kind == UICollectionView.elementKindSectionHeader{
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "AppHeaderCell", for: indexPath) as? AppHeaderCell else {return UICollectionReusableView()}
            header.mainTitle.text = "iPhone이 처음이라면"
            header.moreBtn.setTitle("모두 보기", for: .normal)
            return header
        }else if kind == "border"{
            guard let border = collectionView.dequeueReusableSupplementaryView(ofKind: "border", withReuseIdentifier: "border", for: indexPath) as? SeparatorCell else {return UICollectionReusableView()}
            return border
        }
           return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LargeCell", for: indexPath) as? LargeCell else {return UICollectionViewCell()}
            cell.topTitle.text = self.featureList[indexPath.row].type
            cell.subTitle.text = self.featureList[indexPath.row].description
            cell.mainTitle.text = self.featureList[indexPath.row].appName
            
            guard let url = URL(string: self.featureList[indexPath.row].imageURL) else {return UICollectionViewCell()}
            
            cell.imageView.kf.setImage(with: url)
            
            return cell
        }else if indexPath.section == 1{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath) as? ListCell else {return UICollectionViewCell()}
            cell.appName.text = self.rankingFeatureList[indexPath.row].title
            cell.subTitle.text = self.rankingFeatureList[indexPath.row].description
            cell.inAppInfo.isHidden = !self.rankingFeatureList[indexPath.row].isInPurchaseApp
            cell.icon.backgroundColor = .systemGray
            return cell
        }else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CodeBtnCell", for: indexPath) as? CodeBtnCell else {return UICollectionViewCell()}
            return cell
        }
    }
    
}

private extension AppViewVC{
    func featureDataFetch(){
        guard let url = Bundle.main.url(forResource: "Feature", withExtension: "plist") else {return}
        
        do{
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([Feature].self, from: data)
            
            self.featureList = result
        }catch{
            print("featureDataFetch ERROR")
        }
    }
    
    func rankingFeatureDataFetch(){
        guard let url = Bundle.main.url(forResource: "RankingFeature", withExtension: "plist") else {return}
        
        do{
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([RankingFeature].self, from: data)
            
            self.rankingFeatureList = result
        }catch{
            print("RankingFeatureDataFetch ERROR")
        }
    }
}

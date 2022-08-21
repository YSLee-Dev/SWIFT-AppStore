//
//  TodayVC.swift
//  Three_AppStore
//
//  Created by 이윤수 on 2022/08/03.
//

import UIKit

import Then
import SnapKit
import Kingfisher

final class TodayVC : UIViewController{
    
    private var todayList : [Today] = []
    
    var layoutInit = UICollectionViewLayout()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutInit).then{
        $0.delegate = self
        $0.dataSource = self
        $0.register(TodayCell.self, forCellWithReuseIdentifier: "TodayCell")
        $0.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()
        
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        self.collectionView.collectionViewLayout = collectionViewLayout()
        
    }
    
    func collectionViewLayout() -> UICollectionViewLayout{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [header]
        section.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 15)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension TodayVC : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.todayList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayCell", for: indexPath) as? TodayCell else {return UICollectionViewCell()}
        cell.mainTitle.text = self.todayList[indexPath.row].title
        cell.subTitle.text = self.todayList[indexPath.row].subTitle
        cell.footerTitle.text = self.todayList[indexPath.row].description
        
        guard let imgUrl = URL(string: self.todayList[indexPath.row].imageURL) else {return UICollectionViewCell()}
        
        cell.imageView.kf.setImage(with: imgUrl)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderCell else{ return UICollectionReusableView()}
            let now = Date()
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ko")
            formatter.dateFormat = "MM월 dd일 E요일"
            
            header.date.text = formatter.string(from: now)
            header.titleLabel.text = "투데이"
            return header
        }else{
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.present(DetailVC(Today: self.todayList[indexPath.row]), animated: true)
    }
}


private extension TodayVC {
    func fetchData(){
        guard let url = Bundle.main.url(forResource: "Today", withExtension: "plist") else {return}
        
        do{
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([Today].self, from: data)
            self.todayList = result
        }catch{
            print("FETCH DATA ERROR")
        }
    }
}

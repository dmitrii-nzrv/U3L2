//
//  ViewController.swift
//  lesson2
//
//  Created by Dmitrii Nazarov on 14.09.2024.
//

import UIKit

//view
class ViewController: UIViewController {
    private let networkManager = NetworkManager()
    private var characters: [Character] = []
     
    lazy var btn: UIButton = {
        $0.frame.size = CGSize(width: 390, height: 66)
        $0.frame.origin = CGPoint(x: view.frame.minX+20, y: view.frame.height - 100)
        $0.layer.cornerRadius = 20
        $0.backgroundColor = .black
        $0.setTitle("Получить записи", for: .normal)
       // $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.tintColor = .white
          
        return $0
    }(UIButton(primaryAction: sendRequest))
    
    lazy var collectionView: UICollectionView = {
        var layout = $0.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width/2 - 30 , height: 235)
        
        layout.minimumLineSpacing = 7
        layout.minimumInteritemSpacing = 0
        
        $0.dataSource = self
        $0.register(MyCell.self, forCellWithReuseIdentifier: MyCell.reuseID)
        $0.contentInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        
    return $0
    }(UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout()))

    lazy var sendRequest = UIAction { _ in
        self.sendReq()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        view.addSubview(collectionView)
        
        view.addSubview(btn)
    }
}

// controller
extension ViewController{
    func sendReq(){
        networkManager.sendRequest { [weak self] chars in
            guard let self = self else { return }
            self.characters = chars
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCell.reuseID, for: indexPath) as! MyCell
       
        let item = characters[indexPath.item]
        
        cell.setupCell(item: item)
        
        //cell.contentView.backgroundColor = .red
        return cell
    }
}

//
//  ViewController.swift
//  test1
//
//  Created by Dhruv Shrivastava on 14/09/22.
//

import UIKit
import SnapKit
import SDWebImage

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ViewModelDelegate, UITableViewDataSource, UITableViewDelegate {

    var viewModel = ViewModel()
    var myTableView: UITableView!
    
    let mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        return view
    }()
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.frame.size.width/3) - 3, height: (view.frame.size.width/3) - 3)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.layer.cornerRadius = 20
        view.register(CellForCharacter.self, forCellWithReuseIdentifier: CellForCharacter.identifier)
        return view
    }()
    let label: UILabel = {
        let label = UILabel()
        label.text = "Episodes Appeared"
        label.textAlignment = .center
        return label
    }()
    var array = ["https://rickandmortyapi.com/api/episode/1", "https://rickandmortyapi.com/api/episode/2", "https://rickandmortyapi.com/api/episode/3", "https://rickandmortyapi.com/api/episode/4", "https://rickandmortyapi.com/api/episode/5", "https://rickandmortyapi.com/api/episode/6", "https://rickandmortyapi.com/api/episode/7", "https://rickandmortyapi.com/api/episode/8", "https://rickandmortyapi.com/api/episode/9", "https://rickandmortyapi.com/api/episode/10", "https://rickandmortyapi.com/api/episode/11", "https://rickandmortyapi.com/api/episode/12", "https://rickandmortyapi.com/api/episode/13", "https://rickandmortyapi.com/api/episode/14", "https://rickandmortyapi.com/api/episode/15", "https://rickandmortyapi.com/api/episode/16", "https://rickandmortyapi.com/api/episode/17", "https://rickandmortyapi.com/api/episode/18", "https://rickandmortyapi.com/api/episode/19", "https://rickandmortyapi.com/api/episode/20", "https://rickandmortyapi.com/api/episode/21", "https://rickandmortyapi.com/api/episode/22", "https://rickandmortyapi.com/api/episode/23", "https://rickandmortyapi.com/api/episode/24", "https://rickandmortyapi.com/api/episode/25", "https://rickandmortyapi.com/api/episode/26", "https://rickandmortyapi.com/api/episode/27", "https://rickandmortyapi.com/api/episode/28", "https://rickandmortyapi.com/api/episode/29", "https://rickandmortyapi.com/api/episode/30", "https://rickandmortyapi.com/api/episode/31", "https://rickandmortyapi.com/api/episode/32", "https://rickandmortyapi.com/api/episode/33", "https://rickandmortyapi.com/api/episode/34", "https://rickandmortyapi.com/api/episode/35", "https://rickandmortyapi.com/api/episode/36", "https://rickandmortyapi.com/api/episode/37", "https://rickandmortyapi.com/api/episode/38", "https://rickandmortyapi.com/api/episode/39", "https://rickandmortyapi.com/api/episode/40", "https://rickandmortyapi.com/api/episode/41", "https://rickandmortyapi.com/api/episode/42", "https://rickandmortyapi.com/api/episode/43", "https://rickandmortyapi.com/api/episode/44", "https://rickandmortyapi.com/api/episode/45", "https://rickandmortyapi.com/api/episode/46", "https://rickandmortyapi.com/api/episode/47", "https://rickandmortyapi.com/api/episode/48", "https://rickandmortyapi.com/api/episode/49", "https://rickandmortyapi.com/api/episode/50", "https://rickandmortyapi.com/api/episode/51"]
    
    
    @objc private func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let touchPoint = sender.location(in: collectionView)
            if let indexPath = collectionView.indexPathForItem(at: touchPoint) {
                print(indexPath)
                let cellViewController = CellViewController(person: viewModel.characters[indexPath.item])
                cellViewController.title = viewModel.characters[indexPath.item].name
                navigationController?.pushViewController(cellViewController, animated: true)
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let str = array[indexPath.row]
        let arr = str.components(separatedBy:"/")
        cell.textLabel?.text = (arr[4]+" "+arr[5]).capitalized
        return cell
    }

    func reload() {
        collectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.topMargin.left.equalTo(10)
            make.bottomMargin.right.equalTo(-10)
        }
        // Collection View
        
        viewModel.delegate = self
        viewModel.loadData()
        collectionView.delegate = self
        collectionView.delaysContentTouches = false
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
        collectionView.addGestureRecognizer(longPress)
        mainView.addSubview(collectionView)
        
        let ref = 550
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(mainView).inset(UIEdgeInsets(top: 10, left: 10, bottom: CGFloat(ref), right: 10))
        }
        
        
        // Table view
        myTableView = UITableView()
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.layer.cornerRadius = 20
        mainView.addSubview(myTableView)
        mainView.addSubview(label)
        let ret = 230
        myTableView.snp.makeConstraints { make in
            make.edges.equalTo(mainView).inset(UIEdgeInsets(top: CGFloat(ret), left: 10, bottom: 10, right: 10))
        }
        label.snp.makeConstraints { make in
            make.edges.equalTo(mainView).inset(UIEdgeInsets(top: CGFloat(ret-50), left: 10, bottom: CGFloat(ref-50), right: 10))
        }
    }
}

extension ViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CellForCharacter = collectionView.dequeueReusableCell(withReuseIdentifier: CellForCharacter.identifier, for: indexPath) as? CellForCharacter ?? CellForCharacter()
        
        cell.configure(image: viewModel.characters[indexPath.item].image, label: viewModel.characters[indexPath.item].name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isSelected = true
        array = viewModel.characters[indexPath.item].episode
        myTableView.reloadData()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            if offsetY > contentHeight - scrollView.frame.size.height {
                viewModel.loadData()
            }
    }
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.5, delay: 0, options: .beginFromCurrentState, animations: {
            cell?.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
        })
    }
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.5, delay: 0, options: .beginFromCurrentState, animations: {
            cell?.transform = .identity
        })
    }
}

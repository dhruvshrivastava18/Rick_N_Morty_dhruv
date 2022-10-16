//
//  CellViewController.swift
//  test1
//
//  Created by Dhruv Shrivastava on 14/09/22.
//

import UIKit
import SnapKit
import SDWebImage

class characterLabel: UILabel{
    override init(frame: CGRect){
        super.init(frame: frame)
        self.font = .systemFont(ofSize: 20)
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CellViewController: UIViewController{

    var person: CharacterModel
    init(person: CharacterModel){
        self.person = person
        super.init(nibName: nil, bundle: nil)
        makeStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.blue]
    }
    
    lazy var image: UIImageView = {
        let temp = UIImageView()
        temp.sd_setImage(with: URL(string: person.image))
        return temp
    }()
    
    lazy var statusLabel: characterLabel = {
        let tmp = characterLabel()
        tmp.textColor = .blue
        var txt = person.status
        if txt.isEmpty {
            txt = "unknown"
        }
        tmp.text = "Status: " + txt
        return tmp
    }()
    
    lazy var speciesLabel: characterLabel = {
        let tmp = characterLabel()
        var txt = person.species
        tmp.textColor = .blue
        if txt.isEmpty {
            txt = "unknown"
        }
        tmp.text = "Species: " + txt
        return tmp
    }()
    lazy var typeLabel: characterLabel = {
        let tmp = characterLabel()
        var txt = person.type
        tmp.textColor = .blue
        if txt.isEmpty {
            txt = "unknown"
        }
        tmp.text = "Type: " + txt
        return tmp
    }()
    lazy var genderLabel: characterLabel = {
        let tmp = characterLabel()
        var txt = person.gender
        tmp.textColor = .blue
        if txt.isEmpty {
            txt = "unknown"
        }
        tmp.text = "Gender: " + txt
        return tmp
    }()
    
    lazy var originLabel: characterLabel = {
        let tmp = characterLabel()
        var txt = person.origin.name
        tmp.textColor = .blue
        if txt.isEmpty {
            txt = "unknown"
        }
        tmp.text = "Origin: " + txt
        return tmp
    }()
    
    lazy var locationLabel: characterLabel = {
        let tmp = characterLabel()
        var txt = person.location.name
        tmp.textColor = .blue
        if txt.isEmpty {
            txt = "unknown"
        }
        tmp.text = "Location: " + txt
        return tmp
    }()
    
    lazy var stackView: UIStackView = {
        let tmp = UIStackView(arrangedSubviews: [image, statusLabel, speciesLabel, typeLabel, genderLabel, originLabel, locationLabel])
        tmp.axis = .vertical
        tmp.distribution = .fill
        tmp.spacing = 20
        return tmp
    }()
    
    func makeStackView(){
        view.addSubview(stackView)
        makeStackConstraint()
        view.backgroundColor = .cyan
    }
    
    func makeStackConstraint(){
        stackView.snp.makeConstraints {
            make in make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
    }
}

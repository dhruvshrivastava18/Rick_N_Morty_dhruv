//
//  ViewModel.swift
//  test1
//
//  Created by Dhruv Shrivastava on 14/09/22.
//

import Foundation
protocol ViewModelDelegate {
    func reload()
}
class ViewModel{
    var characters: [CharacterModel] = []
    var delegate: ViewModelDelegate?
    var info: CharacterInfo?
    var isLoading: Bool = false
    func loadData(){
        var url = "https://rickandmortyapi.com/api/character/"
        if let next = info?.next {
            url = next
        }
        guard let url = URL(string: url) else{
            return
        }
        let session = URLSession.shared.dataTask(with: url){
            data, responce, error in
            guard let data = data, error == nil else {
                print("There was an error")
                return
            }
            var result: CharacterDataModel?
            do{
                result = try JSONDecoder().decode(CharacterDataModel.self, from: data)
            }
            catch{
                print("The error is \(error)")
            }
            guard let jsonData = result else{
                return
            }
            self.characters.append(contentsOf: jsonData.results)
            self.info = jsonData.info
            
            DispatchQueue.main.async {
                self.delegate?.reload()
            }
        }
        session.resume()
    }
}

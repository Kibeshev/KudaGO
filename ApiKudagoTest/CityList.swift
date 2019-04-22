//
//  CityList.swift
//  ApiKudagoTest
//
//  Created by Кирилл Кибешев on 18.03.2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import UIKit

class Location {
    
    let slug: String?
    let name: String?
    
    init(slug: String?, name: String?) {
        self.slug = slug
        self.name = name
    }
}


class LocationAPIManager{
    
    func getLocation(completion: @escaping (([Location])?) -> Void){
        let urlStringTwo = "https://kudago.com/public-api/v1.4/locations/?lang=ru&fields=name,slug=&order_by="
        guard let urlTwo = URL(string: urlStringTwo) else {
            return
        }
        // Создаем задачу загрузки данных с сервера
        let taskTwo = URLSession.shared.dataTask(with: urlTwo) { (data, response, error) in // Замыкание
            // Вызывается не в главном потоке потому что под капотом переходит в бэкграунд поток
            
            // Проверяем не nil ли data
            if let data = data {
                // Преобразуем data в словарь [String: Any]
                if let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String: Any]] {
                    // Создаем пустой массив под наши ивенты
                    var locations: [Location] = []
                    
                    // Проходим по массиву результатов
                    for element in dictionary ?? [] {
                        // Пытаемся получить title и description по их ключам и привести их к String
                        if
                            let name = element["name"] as? String{
                            let slug = element["slug"] as? String
                            let location = Location(slug: slug, name: name)
                            // добавляем его в массив локаций
                            locations.append(location)
                        }
                    }
                    
                    
                    // вызываем замыкание
                    completion(locations)
                    return
                }
            }
            
            completion(nil)
        }
        taskTwo.resume()
    }


}

class CityList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    
    
 
    
    
    let manager = LocationAPIManager()
    
    @IBOutlet weak var tableViewTwo: UITableView!
    var cityLists: [Location] = []

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return cityLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cellTwo = tableView.dequeueReusableCell(withIdentifier: "TestCellTwo", for: indexPath) as? CityListCell
        
        let locations2 = self.cityLists[indexPath.row]
        
        cellTwo?.labelLocations.text = locations2.name
        
        return cellTwo ?? UITableViewCell()
    }
    // эта функция помогает закрыть экран городов 
    @objc func closeButtonAction(){
        dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
              //добавляем кнопочку в навигуцию для бара
       
        
        let backButton = UIButton(type: .custom)
        backButton.frame = CGRect(x: 16, y: 32, width: 70, height: 21)
        
        backButton.setImage(UIImage(named: "backButton"), for: .normal)
        backButton.setTitleColor(backButton.tintColor, for: .normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        //нужно чтоб наша кнопочка возвращала экарн назад
        backButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
//
//        func closeButtonAction(){
//            dismiss(animated: true, completion: nil)
//        }
//
     
    
        
   

        
        
        // Это надо чтобы мы могли показывать наши данные в таблице
            tableViewTwo.delegate = self
            tableViewTwo.dataSource = self
        manager.getLocation(completion: { locations in
            DispatchQueue.main.async {
                
                self.cityLists = locations ?? []
                self.tableViewTwo.reloadData()
            }
        })
    }

}




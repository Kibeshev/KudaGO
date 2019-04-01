//
//  ViewController.swift
//  ApiKudagoTest
//
//  Created by Кирилл Кибешев on 02.03.2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import UIKit
import Nuke

class Event {
    
    let title: String
    let description: String
    let price:String
    let place:String?
    let location:String?
//    let images:UIImage
//    let dates:Date
    
    init(title: String, description: String, price: String,place:String?, location:String?) {
        self.title = title
        self.description = description
        self.price = price
        self.place = place
        self.location = location
//        self.images = images
//        self.dates = dates

    }
    
}

class KudagoAPIManager {

    func getEvents(completion: @escaping ([Event]?) -> Void) {
        let urlString = "https://kudago.com/public-api/v1.4/events/?fields=id,dates,title,description,body_text,location,images,price,place,is_free&text_format=text"
        guard let url = URL(string: urlString) else {
            return
        }
        // Создаем задачу загрузки данных с сервера
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in // Замыкание
            // Вызывается не в главном потоке потому что под капотом переходит в бэкграунд поток
            
            // Проверяем не nil ли data
            if let data = data {
                // Преобразуем data в словарь [String: Any]
                let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                
                // Пытаемся вытащить массив результатов [[String: Any]] по ключу "results"
                if let results = dictionary??["results"] as? [[String: Any]] {
                    // Выводим этот массив консоль
                    print("results: \(results)")

                    // Создаем пустой массив под наши ивенты
                    var events: [Event] = []

                    // Проходим по массиву результатов
                    for element in results {
                        // Пытаемся получить title и description по их ключам и привести их к String
                        if let title = element["title"] as? String,
                            let price = element["price"] as? String,
//                            let images = element["images"] as? UIImage,
                           
                            let description = element["description"] as? String {
                            let location = element["location"] as? String
                            
                            let place = element["place"] as? String
                            // Создаем объект ивента
                            let event = Event(title: title, description: description, price: price, place: place, location: location)
                            // Добавляем его в массив events
                            events.append(event)
                           
                        }
                    }
                    
                    // Выводим наш массив ивентов
                    print(events)
                    // Вызываем замыкание и передаем туда наши ивенты
                    completion(events)
                    // Обрываем выполнение функции чтобы комплишен ниже не вызвался
                    return
                }
            } else {
                completion(nil)
            }
            
        }
        // Отправляем нашу задачу на выполнение
        task.resume()
    }
    
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let manager = KudagoAPIManager()
    
    var events: [Event] = []
    
    @IBOutlet weak var cityButton: UIBarButtonItem!
    
    
   
    
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.estimatedRowHeight = 150
//        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        cityButton.title = "Москва ˅"
        
       
        
//        cityButton.image = UIImage(named: "arrow")
//        cityButton.
        let logo = UIImage(named: "leftBarImage")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        imageView.frame = CGRect(x: 0.0, y: 0.0, width: 106.4, height: 44)
         let imageViev = UIBarButtonItem.init(customView: imageView)
        let widthConstraint = imageView.widthAnchor.constraint(equalToConstant: 106.4)
        let heightConstraint = imageView.heightAnchor.constraint(equalToConstant: 44)
        heightConstraint.isActive = true
        widthConstraint.isActive = true
        navigationItem.leftBarButtonItem = imageViev
//        106.7 44
        
//        navigationItem
//        
//        viewInCell.layer.cornerRadius = 100
//        viewInCell.masksToBounds = true
//        let dateString = "2014-01-12"
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let dates = dateFormatter.date(from: dateString)
//
        
//        let dateFormatterGet = DateFormatter()
        
//        dateFormatterGet.dateStyle = .short
//        dateFormatterGet.timeStyle = .short
        
    
       
      
        
        

        
        
        // Это надо чтобы мы могли показывать наши данные в таблице
        tableView.delegate = self
        tableView.dataSource = self
        // Показываем индикатор загрузки
        activityIndicator.startAnimating()
        // Загружаем наши данные
        manager.getEvents(completion: { events in
            // Ещё не главный поток
            DispatchQueue.main.async { // Теперь главный поток
                // Присваиваем нашему свойству events ивенты
                self.events = events ?? [] // Если придет nil, то положим пустой массив []
                // Выключаем индикатор загрузки
                self.activityIndicator.stopAnimating()
                // -------
                // Тут нужно сделать tableView.reloadData()
                // Чтобы таблица перезагрузилась и нарисовала те events то что мы загрузили
                self.tableView.reloadData()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count // Тут напиши свой код
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath) as? KGCell
        
        let events2 = self.events[indexPath.row]
        cell?.labelTitle.text = events2.title
        cell?.labelDescriotions.text = events2.description
//        cell?.labelDate.text = events2.dates
       cell?.labelPlace.text = events2.place
//        cell?.kudaGoImage.image = events2.images
        
        
        cell?.labelPrice.text = events2.price
        
        if events2.price != ""{
             cell?.labelPrice.text = events2.price
        } else {
             cell?.labelPrice.text = "Бесплатно"
        }
        
        
//        let cellCity = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath) as? CellCityList
//        
//        cellCity?.cellList.text = events2.location
        
    
      
      
        
//        var j = UIImage(named: "ruble")
//        var rubleImageView = UIImageView(image: ruble)
        
       
        
    
      
        
        
        
        
        
        
        
        return cell ?? UITableViewCell() // И тут тоже
        
     
        }
    //функиция которая получает событие по индексу
    // очень крутая фунция всем советую 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
        
//        let viewTwo = self.events[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SecondViewInKudaGo")
        self.navigationController?.pushViewController(controller, animated: true)

        
        //        present(controller, animated: true, completion: nil)
//
//        let labelPuk = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
//        labelPuk.center = CGPoint(x: 160, y: 285)
//        labelPuk.textAlignment = .center
//        self.view.addSubview(labelPuk)
        
        
//        labelPuk.text = viewTwo.title
        
        
        
        
    }
    }






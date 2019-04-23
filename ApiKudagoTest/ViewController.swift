//
//  ViewController.swift
//  ApiKudagoTest
//
//  Created by Кирилл Кибешев on 02.03.2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import UIKit
import Nuke

//class Event {
//
//    let title: String
//    let description: String
//    let price:String
//    let place:String?
//    let location:String?
//    let images: [String]
////    let dates:Date
//
//    init(title: String, description: String, price: String,place:String?, location:String?, images: [String]) {
//        self.title = title
//        self.description = description
//        self.price = price
//        self.place = place
//        self.location = location
//
//       self.images = images
////        self.dates = dates
//
//    }
//
//}
// Короче, мы тут работаем с парсингом при помощи Codable
// Создаем модельки, которые названием полей точь-в-точь повторяют названия полей в наших словарях

// Соответственно создаем сначала GetEventsRawResponse с полями count(простой Int), опциональными next, previous (String?) и массивом [Event] (который тоже Codable)

// Внутри Event ещё лежит словарь с массивом картинок по ключу "images", соответсвенно я создал модель для картинки - Image, и там ещё внутри был ещё один словарь "sources", его я тоже моделькой завел, хотя для приложения он не пригодится, просто для примера, можно на самом деле удалить его использование

// На самом деле можно не называть поля точь в точь, но для этого придется писать ещё дополнительный код, могу показать позже


struct GetEventsRawResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Event]
}

struct Event: Codable {
    let id: Int
    let title: String 
    let dates: [DateEvent]?
    let description: String
    let body_text: String
    let price: String
    let place: Place?
    let is_free: Bool
    let images: [Image]?
}
struct DateEvent: Codable {
    let start: Int
    let end: Int
}
struct Place: Codable {
    let title: String?
    let id: Int
}

struct Image: Codable {
    let image: String
    let source: Source
}

struct Source: Codable {
    let name: String
    let link: String
}

class KudaGoAPIManager {
    
    
    func getEvents(urlString: String, completion: @escaping (GetEventsRawResponse?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                if let rawResponse = try? decoder.decode(GetEventsRawResponse.self, from: data) {
                    completion(rawResponse)
                    return
                }
            }
            completion(nil)
        }
        task.resume()
    }
    
}

//class KudagoAPIManager {
//
//    func getEvents(completion: @escaping ([Event]?) -> Void) {
//        let urlString = "https://kudago.com/public-api/v1.4/events/?fields=id,dates,title,description,body_text,location,images,price,place,is_free&text_format=text"
//        guard let url = URL(string: urlString) else {
//            return
//        }
//
//        // Создаем задачу загрузки данных с сервера
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in // Замыкание
//            // Вызывается не в главном потоке потому что под капотом переходит в бэкграунд поток
//
//            // Проверяем не nil ли data
//            if let data = data {
//                // Преобразуем data в словарь [String: Any]
//                let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
//
//                // Пытаемся вытащить массив результатов [[String: Any]] по ключу "results"
//                if let results = dictionary??["results"] as? [[String: Any]] {
//                    // Выводим этот массив консоль
//                    print("results: \(results)")
//
//                    // Создаем пустой массив под наши ивенты
//                    var events: [Event] = []
//
//                    // Проходим по массиву результатов
//                    for element in results {
//                        // Пытаемся получить title и description по их ключам и привести их к String
//                        if let title = element["title"] as? String, let price = element["price"] as? String, let description = element["description"] as? String {
//
//                            let location = element["location"] as? String
//
//                            let place = element["place"] as? String
//
//                            // Мы вытаскиваем массив словарей из нашего словаря element по ключу images и пытаемся закастить к типу массива словарей ключ: значение
//                            let imagesDictionary = element["images"] as? [[String: Any]]
//
//                            // Создаем пустой массив под картинки чтобы его потом заполнить и положить в объект Event
//                            var images: [String] = []
//
//                            for imageDictionary in imagesDictionary ?? [] {
//                                if let imageString = imageDictionary["image"] as? String {
//                                    images.append(imageString)
//                                }
//                            }
//
//                            // Создаем объект ивента
//                            let event = Event(title: title, description: description, price: price, place: place, location: location, images: images)
//
//                            // Добавляем его в массив events
//                            events.append(event)
//
//                        }
//                    }
//
//                    // Выводим наш массив ивентов
//                    print(events)
//                    // Вызываем замыкание и передаем туда наши ивенты
//                    completion(events)
//                    // Обрываем выполнение функции чтобы комплишен ниже не вызвался
//                    return
//                }
//            } else {
//                completion(nil)
//            }
//
//        }
//        // Отправляем нашу задачу на выполнение
//        task.resume()
//    }
//
//}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let manager = KudaGoAPIManager()
     var events: [Event] = []
    var pageNext: String?
    
    
    
    
    
//    let managerImage = DownloadImage()
//     var getImage: [Image] = []
    
    
    
    @IBOutlet weak var cityButton: UIBarButtonItem!
    
    
   
    
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
//        tableView.estimatedRowHeight = 150
//        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        cityButton.title = "vjcrdf"
        
       
        
//        cityButton.image = UIImage(named: "arrow")
//        cityButton.
        
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
       
      
        
    
       
      
        
        
        let dateNow = Date().timeIntervalSince1970
        let urlString = "https://kudago.com/public-api/v1.4/events/?fields=id,dates,title,description,body_text,location,images,price,place,is_free&text_format=text&expand=place&actual_since=\(dateNow)"
        
        
        // Это надо чтобы мы могли показывать наши данные в таблице
        tableView.delegate = self
        tableView.dataSource = self
        // Показываем индикатор загрузки
        activityIndicator.startAnimating()
        // Загружаем наши данные
        manager.getEvents(urlString: urlString , completion: { getEventsRawResponseStruct in
            // Ещё не главный поток
            DispatchQueue.main.async { // Теперь главный поток
                // Присваиваем нашему свойству events ивенты
                self.events = getEventsRawResponseStruct?.results ?? [] // Если придет nil, то положим пустой массив []
                // Выключаем индикатор загрузки
                self.activityIndicator.stopAnimating()
                self.pageNext = getEventsRawResponseStruct?.next
                // -------
                // Тут нужно сделать tableView.reloadData()
                // Чтобы таблица перезагрузилась и нарисовала те events то что мы загрузили
                self.tableView.reloadData()
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let logo = UIImage(named: "leftBarImage")
        let imageView = UIImageView(image:logo)
        
        let imageViev = UIBarButtonItem.init(customView: imageView)
        let widthConstraint = imageView.widthAnchor.constraint(equalToConstant: 106.4)
        let heightConstraint = imageView.heightAnchor.constraint(equalToConstant: 44)
        heightConstraint.isActive = true
        widthConstraint.isActive = true
        navigationItem.leftBarButtonItem = imageViev
    }
   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count // Тут напиши свой код
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        
        
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath) as? KGCell
        
     
        
        
        
        let events2 = self.events[indexPath.row]
        
        
        cell?.labelTitle.text = events2.title
        cell?.labelDescriotions.text = events2.description
       
        cell?.labelPlace.text = events2.place?.title
        
        if let image = events2.images?.first {
            if let imageURL = URL(string: image.image), let imageView = cell?.kudaGoImage {
                Nuke.loadImage(with: imageURL, into: imageView)
            }
        }
        
        
        cell?.labelPrice.text = events2.price
        
        if events2.price != ""{
             cell?.labelPrice.text = events2.price
        } else {
             cell?.labelPrice.text = "Бесплатно"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd"
//        dateFormatter.timeStyle = .none
        let date = Date(timeIntervalSince1970: TimeInterval(events2.dates?.first?.start ?? 0))
       let dateStart = dateFormatter.string(from: date)
        
        let dateEnd = Date(timeIntervalSince1970: TimeInterval(events2.dates?.first?.end ?? 0))
        dateFormatter.dateFormat = "dd MMMM"
       let dateEndString = dateFormatter.string(from: dateEnd)
        
        
         cell?.labelDate.text = "\(dateStart) - \(dateEndString)"
        
        
//        let cellCity = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath) as? CellCityList
//        
//        cellCity?.cellList.text = events2.location
        
    
      
      
        
//        var j = UIImage(named: "ruble")
//        var rubleImageView = UIImageView(image: ruble)
        
       
        
    
      
        
        
        
        
        
        
        
        return cell ?? UITableViewCell() // И тут тоже
    
     
        }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItemIndex = events.count - 3
        if indexPath.row == lastItemIndex {
           loadMoreEvents()
        }
    }
    func loadMoreEvents() {
        manager.getEvents(urlString: pageNext ?? "" ) { (getEventsRawResponseStruct) in
            DispatchQueue.main.async {
                self.events.append(contentsOf: getEventsRawResponseStruct?.results ?? [] )
                
                self.pageNext = getEventsRawResponseStruct?.next
                self.tableView.reloadData()
            }
        }
    }
 
    //функиция которая получает событие по индексу
    // очень крутая фунция всем советую 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
        
//        let viewTwo = self.events[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SecondViewInKudaGo") as? SecondViewInKudaGo
        self.navigationController?.pushViewController(controller!, animated: true)
        controller?.event = self.events[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
        
       
    
    
    //This method will call when you press button.
 
        

        
        //        present(controller, animated: true, completion: nil)
//
//        let labelPuk = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
//        labelPuk.center = CGPoint(x: 160, y: 285)
//        labelPuk.textAlignment = .center
//        self.view.addSubview(labelPuk)
        
        
//        labelPuk.text = viewTwo.title
        
        
        
        
    }
  
    }




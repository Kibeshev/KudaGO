//
//  secondViewInKudaGo.swift
//  ApiKudagoTest
//
//  Created by Кирилл Кибешев on 21.03.2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import UIKit
import Nuke



class SecondViewInKudaGo: UIViewController, UIScrollViewDelegate {
    //  аутлеты горизонтального скролла второго экрана
    @IBOutlet weak var pageControlImage: UIPageControl!
    @IBOutlet weak var scrollForImage: UIScrollView!
    
    @IBOutlet weak var labelRuble: UILabel!
    @IBOutlet weak var labelDates: UILabel!
    @IBOutlet weak var labelPlace: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var labelDescriptions: UILabel!
    @IBOutlet weak var labelBodyText: UILabel!
    
    
    var event: Event!
//    var imageSecondView: [Image]!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create a new button
        let button = UIButton(type: .custom)
        //set image for button
        button.setImage(UIImage(named: "navBarImageSecondView"), for: .normal)
        //add function for button
        button.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 375, height: 64)
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.leftBarButtonItem = barButton

        //нужно чтоб наша кнопочка возвращала экарн назад
        button.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)

       
        
 // делаю прозрачный навигейшн бар
self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.isTranslucent = true
    self.navigationController?.view.backgroundColor = .clear
        
        
        // вывожу данные в лейблы
      labelBodyText.text = self.event.body_text
        labelTitle.text = self.event.title
        labelDescriptions.text = self.event.description
      labelPlace.text = self.event.place?.title
        
        
        if self.event.price != ""{
             labelRuble.text = self.event.price
            } else {
           labelRuble.text =  "Бесплатно"
        }
        
        // делаю массив картинок в горизонтальном скролл вью 
        var sliderImagesArray = event.images
        scrollForImage.delegate = self

        for i in 0..<sliderImagesArray!.count {
            let xOrigin = UIApplication.shared.keyWindow!.bounds.width * CGFloat(i)
            let imageViewCarousel = UIImageView()
            imageViewCarousel.isUserInteractionEnabled = true
            imageViewCarousel.frame = CGRect(x: xOrigin, y: 0, width: UIApplication.shared.keyWindow!.bounds.width, height: 240)
            scrollForImage.addSubview(imageViewCarousel)

            let urlStr = sliderImagesArray![i]

            if let imageURL = URL(string: urlStr.image) {
                Nuke.loadImage(with: imageURL, into: imageViewCarousel)
            }
        }

        self.scrollForImage.isPagingEnabled = true
        //self.scrollForImage.bounces = false
        //self.scrollForImage.showsVerticalScrollIndicator = false
        //self.scrollForImage.showsHorizontalScrollIndicator = false
        self.scrollForImage.contentSize = CGSize(width:
            UIApplication.shared.keyWindow!.bounds.width * CGFloat(sliderImagesArray!.count), height: 240 )
        pageControlImage.addTarget(self, action: #selector(changePage(sender: )), for: UIControl.Event.valueChanged)
        
        self.pageControlImage.numberOfPages = sliderImagesArray!.count
        self.pageControlImage.currentPage = 0
        self.pageControlImage.tintColor = UIColor.red
        self.pageControlImage.pageIndicatorTintColor = UIColor.black
        self.pageControlImage.currentPageIndicatorTintColor = UIColor.blue
        
    }
    
    
 
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @objc func  changePage(sender: AnyObject) -> () {
        //let x = CGFloat(pageControlImage.currentPage) * scrollForImage.frame.size.width
        //scrollForImage.setContentOffset(CGPoint(x: x,y :0), animated: true)
    }
    @objc func closeButtonAction(){
        dismiss(animated: true, completion: nil)
    }
    @objc func fbButtonPressed() {
        
        print("Share to fb")
    }
    

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollForImage.contentOffset.x / scrollForImage.frame.size.width)
        pageControlImage.currentPage = Int(pageNumber)
    }
}

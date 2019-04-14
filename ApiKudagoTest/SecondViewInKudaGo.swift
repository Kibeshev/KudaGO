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
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      labelBodyText.text = self.event.body_text
        labelTitle.text = self.event.title
        labelDescriptions.text = self.event.description
      labelPlace.text = self.event.place?.title
        
        
        if self.event.price != ""{
             labelRuble.text = self.event.price
            } else {
           labelRuble.text =  "Бесплатно"
        }
        
        var sliderImagesArray = NSMutableArray()
        sliderImagesArray = [event.images?.randomElement() as Any]
        scrollForImage.delegate = self

        for i in 0..<sliderImagesArray.count {
            var imageViewCarousel : UIImageView?
            let xOrigin = self.scrollForImage.frame.size.width * CGFloat(i)
            imageViewCarousel = UIImageView(frame: CGRect(x: xOrigin, y: 0, width: self.scrollForImage.frame.size.width, height: self.scrollForImage.frame.size.height))
            imageViewCarousel?.isUserInteractionEnabled = true
            let urlStr = sliderImagesArray.object(at: i)
            print(scrollForImage,imageViewCarousel as Any, urlStr)
            if let image = self.event.images?.randomElement() {
                if let imageURL = URL(string: image.image), let imageView = imageViewCarousel {
                    Nuke.loadImage(with: imageURL, into: imageView)
                }
                self.scrollForImage.isPagingEnabled = true
                self.scrollForImage.bounces = false
                self.scrollForImage.showsVerticalScrollIndicator = false
                self.scrollForImage.showsHorizontalScrollIndicator = false
                self.scrollForImage.contentSize = CGSize(width:
                    self.scrollForImage.frame.size.width * CGFloat(sliderImagesArray.count), height: self.scrollForImage.frame.size.height)
                pageControlImage.addTarget(self, action: #selector(changePage(sender: )), for: UIControl.Event.valueChanged)
                
                self.pageControlImage.numberOfPages = sliderImagesArray.count
                self.pageControlImage.currentPage = 0
                self.pageControlImage.tintColor = UIColor.red
                self.pageControlImage.pageIndicatorTintColor = UIColor.black
                self.pageControlImage.currentPageIndicatorTintColor = UIColor.blue
            }
      
        
        
        
        
        
        
    
       
      

        // Do any additional setup after loading the view.
    }
 
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
    @objc func  changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControlImage.currentPage) * scrollForImage.frame.size.width
        scrollForImage.setContentOffset(CGPoint(x: x,y :0), animated: true)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollForImage.contentOffset.x / scrollForImage.frame.size.width)
        pageControlImage.currentPage = Int(pageNumber)
    }
}

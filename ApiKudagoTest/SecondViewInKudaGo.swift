//
//  secondViewInKudaGo.swift
//  ApiKudagoTest
//
//  Created by Кирилл Кибешев on 21.03.2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import UIKit




class SecondViewInKudaGo: UIViewController, UIScrollViewDelegate {
    
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

//
//  secondViewInKudaGo.swift
//  ApiKudagoTest
//
//  Created by Кирилл Кибешев on 21.03.2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import UIKit




class SecondViewInKudaGo: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var labelBodyText: UILabel!
    
    
    var event: Event!
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      labelBodyText.text = self.event.body_text
        
        
        
        
    
       
      

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

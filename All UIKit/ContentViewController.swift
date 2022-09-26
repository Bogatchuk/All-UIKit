//
//  ContentViewController.swift
//  All UIKit
//
//  Created by Roma Bogatchuk on 26.09.2022.
//

import UIKit

class ContentViewController: UIViewController {
    @IBOutlet weak var presentTextLabel: UILabel!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var presentText = ""
    var emoji = ""
    var curentPage = 0
    var numberOfPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presentTextLabel.text = presentText
        emojiLabel.text = emoji
        pageControl.numberOfPages = numberOfPage
        pageControl.currentPage = curentPage
        
        
    }
    


}

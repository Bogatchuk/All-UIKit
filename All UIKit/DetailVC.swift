//
//  DetailVC.swift
//  All UIKit
//
//  Created by Roma Bogatchuk on 25.09.2022.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var trackName = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        image.image = UIImage(named: trackName)
        titleLabel.text = trackName
    }
    

   

}

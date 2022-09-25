//
//  TrackCollections.swift
//  All UIKit
//
//  Created by Roma Bogatchuk on 25.09.2022.
//

import UIKit

private let reuseIdentifier = "Cell"

class TrackCollections: UICollectionViewController {

    let imageNameArray = ["Вечный жид — Oxxxymiron",
                          "Горгород — Oxxxymiron",
                          "Город Под Подошвой — Oxxxymiron",
                          "Оксимирон – Красота и Уродство",
                          "Оксимирон – Микстейп 3. Смутное время",
                          "Mixxxtape 2— Oxxxymiron",
                          "miXXXtape I — Oxxxymiron",
                          "Oxxxymiron - miXXXtape III- Смутное Время",
                          "Оксимирон – Микстейп 3. Смутное время"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

   




    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNameArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TrackCell
     
        cell.imageView.image = UIImage(named: imageNameArray[indexPath.row])
    
        return cell
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            if let indexPath = self.collectionView.indexPathsForSelectedItems?.first {
                let detailsVC = segue.destination as! DetailVC
                detailsVC.trackName = imageNameArray[indexPath.row]
            }
        }
    }
}

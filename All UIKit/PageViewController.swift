//
//  PageViewController.swift
//  All UIKit
//
//  Created by Roma Bogatchuk on 26.09.2022.
//

import UIKit

class PageViewController: UIPageViewController {

    let presentScreenConten = ["Вечный жид — Oxxxymiron",
                               "Горгород — Oxxxymiron",
                               "Город Под Подошвой — Oxxxymiron",
                               "Оксимирон – Красота и Уродство",
                               ""]
    
    let emojiArray = ["🤖","👾","🎃","🦾", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        if let contentViewController = showViewControllerAtIndex(0) {
            setViewControllers([contentViewController], direction: .forward, animated: true)
        }
       
    }
    
    func showViewControllerAtIndex (_ index: Int) -> ContentViewController? {
        guard index >= 0 else {return nil}
        guard index < presentScreenConten.count else {
            if let mainViewController = storyboard?.instantiateViewController(withIdentifier: "mainViewController") as? ViewController {
                mainViewController.modalPresentationStyle = .fullScreen
                present(mainViewController, animated: true)
            }
            
            return nil}
        guard let contenViewController = storyboard?.instantiateViewController(
            withIdentifier: "ContentViewController") as? ContentViewController else {return nil}
        
        contenViewController.presentText = presentScreenConten[index]
        contenViewController.emoji = emojiArray[index]
        contenViewController.curentPage = index
        contenViewController.numberOfPage = presentScreenConten.count
        
        return contenViewController
    }

    

}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! ContentViewController).curentPage
        pageNumber -= 1
        return showViewControllerAtIndex(pageNumber)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! ContentViewController).curentPage
        pageNumber += 1
        return showViewControllerAtIndex(pageNumber)
    }
    
    
}

//
//  PageViewController.swift
//  SapoAdmin
//
//  Created by Trương Quang on 8/23/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

protocol PageViewControllerDelegate: class {
    func selectedItemFromPageViewController(_ selected: Int, from viewController: UIViewController)
}

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    lazy var listViewController: [UIViewController] = {
        return [SaleViewController.instance,
                WarehouseViewController.instance,
                FinancialViewController.instance]
    }()
    
    var selectedIndex: Int = 0 {
        didSet {
            jump(toIndex: selectedIndex, animated: true)
        }
    }
    
    weak var indexDelegate: PageViewControllerDelegate?
    
    var currentViewController: UIViewController? {
        get {
            return viewControllers?.first
        }
    }
    
   
    
    var index: Int {
        guard currentViewController != nil else {
            return NSNotFound
        }
        
        return indexOfViewController(currentViewController!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        if let viewControlerDefault = listViewController.first {
            setViewControllers([viewControlerDefault], direction: .forward, animated: true, completion: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    func jump(toIndex: Int, animated: Bool = true) {
        guard toIndex != NSNotFound && toIndex >= 0 else {
            return
        }
        
        if let viewController = viewControllerAtIndex(toIndex) {
            if toIndex > index {
                setViewControllers([viewController], direction: .forward, animated: true, completion: nil)
            } else {
                setViewControllers([viewController], direction: .reverse, animated: true, completion: nil)
            }
        }
    }
    
    func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        if listViewController.count == 0 || index >= listViewController.count || index < 0 {
            return nil
        }
        
        return listViewController[index]
    }
    
    func indexOfViewController(_ viewController: UIViewController) -> Int {
        return listViewController.firstIndex(of: viewController) ?? NSNotFound
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let indexCurrentVC = listViewController.firstIndex(of: viewController) else { return nil }
        
        let previous = indexCurrentVC - 1
        
        guard previous >= 0 else {
            return nil
        }
        
        return listViewController[previous]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let indexCurrentVC = listViewController.firstIndex(of: viewController) else { return nil }
        
        let next = indexCurrentVC + 1
        
        guard listViewController.count != next else {
            return nil
        }
        
        return listViewController[next]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let vc = pendingViewControllers.first else {return}
        indexDelegate?.selectedItemFromPageViewController(self.indexOfViewController(vc), from: self)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if !completed {
            guard let vc = previousViewControllers.first else {return}
            indexDelegate?.selectedItemFromPageViewController(self.indexOfViewController(vc), from: self)
        }
    }
    

}

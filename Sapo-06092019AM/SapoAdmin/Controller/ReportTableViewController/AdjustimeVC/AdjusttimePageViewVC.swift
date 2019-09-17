//
//  AdjusttimePageViewVC.swift
//  SapoAdmin
//
//  Created by Minh.Thang on 8/29/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

class AdjusttimePageViewVC: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {


    var selectedIndex: Int = 0 {
        didSet {
            jump(toIndex: selectedIndex, animated: true)
        }
    }
    
    
    var listVC: [UIViewController] = [
        DayTableVC.instance,
        WeekTableVC.instance,
        MonthTableVC.instance,
        CustomizeTimeTableVC.instance
    ]
    
    
    var currentVC: UIViewController? {
        return viewControllers?.first
    }
    var index: Int {
        guard currentVC != nil else {
            return NSNotFound
        }
        
        return indexOfViewController(currentVC!)
    }
    
    var indexDelegate: AdjustTimePageVCDelegate?
    
    var startViewControllerIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
       
        
        if let startingViewcontroller: UIViewController = self.viewcontrollerAtIndex(startViewControllerIndex) {
            let startVC = [startingViewcontroller]
            setViewControllers(startVC, direction: .forward, animated: true, completion:  {done in})
        }
    }
    

    func jump(toIndex: Int, animated: Bool = true) {
        guard toIndex != NSNotFound && toIndex >= 0 else {
            return
        }
        let direction: UIPageViewController.NavigationDirection = toIndex > index ? .forward : .reverse
        if let viewcontroller = viewcontrollerAtIndex(toIndex) {
            self.setViewControllers([viewcontroller], direction: direction, animated: true, completion: {done in})
        }
    }
    
    func viewcontrollerAtIndex(_ index: Int) -> UIViewController? {
        if (self.listVC.count == 0) || (index >= self.listVC.count) || (index < 0) {
            return nil
        }
        return listVC[index]
    }
    
    func indexOfViewController(_ viewController: UIViewController) -> Int {
        return listVC.firstIndex(of: viewController) ?? NSNotFound
    }
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        index -= 1
        
        return self.viewcontrollerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController)
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        if index == self.listVC.count {
            return nil
        }
        
        return self.viewcontrollerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let vc = pendingViewControllers.first else { return }
        indexDelegate?.setSelectedIndex(sender: self, selectedIndex: indexOfViewController(vc))
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if !completed {
            guard let vc = previousViewControllers.first else { return }
            indexDelegate?.setSelectedIndex(sender: self, selectedIndex: self.indexOfViewController(vc))
        }
    }


}

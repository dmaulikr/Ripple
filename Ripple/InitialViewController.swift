//
//  PageViewController.swift
//  Ripple
//
//  Created by Keith Lee on 12/22/16.
//  Copyright © 2016 Keith Lee. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    var pageViewController: UIPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            self.pageViewController.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
        self.pageViewController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate(set) lazy var orderedViewControllers: [UIViewController] = {
        return [
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppViewController"),
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController"),
        ]
    }()
}

extension InitialViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        let previousIndex = index - 1
        guard previousIndex >= 0 else {
            return nil
        }
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        let nextIndex = index + 1
        guard nextIndex >= 0 else {
            return nil
        }
        guard orderedViewControllers.count > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
}

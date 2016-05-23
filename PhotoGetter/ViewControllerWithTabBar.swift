//
//  ViewControllerWithTabBar.swift
//  PhotoGetter
//
//  Created by IrynaP on 5/11/16.
//  Copyright © 2016 IrynaP. All rights reserved.
//

import UIKit


class ViewControllerWithTabBar: UIViewController, UIPageViewControllerDataSource, UITabBarDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var feedProfileTabBar: UITabBar!
    @IBOutlet weak var feedBarItem: UITabBarItem!
    @IBOutlet weak var galleryCameraBarItem: UITabBarItem!
    @IBOutlet weak var profileBarItem: UITabBarItem!
    
    
    
   // var contentViewController: BaseViewController = BaseViewController()
    var contentViewControllers: [UIViewController] = []
    var pageIndex: Int = 0
    
    var pageViewController: UIPageViewController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.feedProfileTabBar.delegate = self
        
        self.navigationController?.navigationBarHidden = true

        self.feedBarItem.setFAIcon(FAType.FAHome)
        self.galleryCameraBarItem.setFAIcon(FAType.FACamera)
        self.profileBarItem.setFAIcon(FAType.FAUser)
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        
        self.hidesBottomBarWhenPushed = true        
        
        
       let firstPage = self.storyboard?.instantiateViewControllerWithIdentifier("ViewWithTable") as! BaseViewController
       let secondPage = self.storyboard?.instantiateViewControllerWithIdentifier("GalleryCameraViewController") as! BaseViewController
       let thirdPage = self.storyboard?.instantiateViewControllerWithIdentifier("NavController") as! UINavigationController
        self.contentViewControllers = [firstPage, secondPage, thirdPage]
        //add first page by default
        
        let startingContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ViewWithTable") as! BaseViewController
        let viewControllers: [BaseViewController] = [startingContentViewController]
        self.pageViewController.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
       
        self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - self.feedProfileTabBar.frame.size.height)
        
        self.addChildViewController(pageViewController)
        self.view.addSubview(pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
        //set first barItem selected by default
        self.feedProfileTabBar.selectedItem = self.feedBarItem
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
      
//        var index = (viewController as! BaseViewController).pageIndex
//        self.setItemSelected(index)
//        if index  == 0 {
//        return nil
//       }
//        else {
//            index = index - 1
//            
//            return self.viewControllerAtIndex(index)
//        
//        }
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
//        var index = (viewController as! BaseViewController).pageIndex
//        self.setItemSelected(index)
//        print("Current pageIndex \(index)")
//        if index == 2 {
//            return nil
//        }
//        else {
//            index = index + 1
//        }
//        
//        return self.viewControllerAtIndex(index)
        return nil

    }
    
//    func viewControllerAtIndex(index: Int) -> BaseViewController {
//        if index == 0 {
//        self.contentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ViewWithTable") as! BaseViewController
//            self.contentViewController.pageIndex = index }
//        else {
//            self.contentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Profile") as! BaseViewController
//            self.contentViewController.pageIndex = index
//        }
//        
//        return self.contentViewController
//    }
    
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        
        
        if pageIndex == item.tag {
            return
        }
        else if (pageIndex == 1) {
            if item.tag == 0 {
                pageIndex = 0
                print("Feed from Camera")
                print("From \(pageIndex) to \(item.tag)")
                self.pageViewController.setViewControllers([self.contentViewControllers[0]], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
                return
            }
            else if item.tag == 2 {
                pageIndex = 2
                print("Profile from Camera")
                print("From \(pageIndex) to \(item.tag)")
                self.pageViewController.setViewControllers([self.contentViewControllers[2]], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
                return
            }
        }
        else if pageIndex == 0 {
            if item.tag == 1 {
                
                pageIndex = 0
                print("Camera from Feed")
                print("From \(pageIndex) to \(item.tag)")
                self.presentViewController(self.contentViewControllers[1], animated: true, completion: nil)
                self.feedProfileTabBar.selectedItem = self.feedBarItem
                return
            }
            else if item.tag == 2 {
                pageIndex = 2
                print("Profile from Feed")
                print("From \(pageIndex) to \(item.tag)")
                self.pageViewController.setViewControllers([self.contentViewControllers[2]], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
                return
            }
        }
        else if (pageIndex == 2) {
            if item.tag == 0 {
                pageIndex = 0
                print("Feed from Profile")
                print("From \(pageIndex) to \(item.tag)")
                self.pageViewController.setViewControllers([self.contentViewControllers[0]], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
                return
            }
            else if item.tag == 1 {
                print("Camera from Profile")
                print("From \(pageIndex) to \(item.tag)")
                self.presentViewController(self.contentViewControllers[1], animated: true, completion: nil)
                self.feedProfileTabBar.selectedItem = self.profileBarItem
                return
            }
            
        }
        
    }


    func changePageInPageViewController(page: BaseViewController, direction: String) {
        var viewControllers: [BaseViewController] = [page]
        if direction == "forward" {
        self.pageViewController.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        }
        else if direction == "reverse" {
            self.pageViewController.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Reverse, animated: true, completion: nil)
        
        }
        else {
            return
        }
        
    }
    
    func setItemSelected(index: Int) {
        if index == 0 {
            self.feedProfileTabBar.selectedItem = self.feedBarItem
        }
        else if index == 1 {
            self.feedProfileTabBar.selectedItem = self.galleryCameraBarItem
        }
        else if index == 2 {
            self.feedProfileTabBar.selectedItem = self.profileBarItem
        }
        else {
            return
        }
    
    }
    
   
}
    
    


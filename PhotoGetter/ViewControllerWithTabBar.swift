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
    
    
    
    var contentViewController: BaseViewController = BaseViewController()
    var pageViewController: UIPageViewController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.feedProfileTabBar.delegate = self
        
       
        
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        
        self.hidesBottomBarWhenPushed = true
        
        
        //add first page by default
        let startingContentViewController = self.viewControllerAtIndex(0)
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
    
    func viewControllerAtIndex(index: Int) -> BaseViewController {
        if index == 0 {
        self.contentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ViewWithTable") as! BaseViewController
            self.contentViewController.pageIndex = index }
        else {
            self.contentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Profile") as! BaseViewController
            self.contentViewController.pageIndex = index
        }
        
        return self.contentViewController
    }
    
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        let currentIndex = self.contentViewController.pageIndex
        
//        if currentIndex == item.tag {
//            return
//        }
//        else if currentIndex < item.tag {
//            self.contentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentOfPageViewController") as! ContentOfPageViewController
//            self.contentViewController.pageIndex = item.tag
//            print("From \(currentIndex) to \(item.tag)")
//            changePageInPageViewController(self.contentViewController, direction: "forward")
//        
//        }
//        else {
//            self.contentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentOfPageViewController") as! ContentOfPageViewController
//            self.contentViewController.pageIndex = item.tag
//            print("From \(currentIndex) to \(item.tag)")
//            changePageInPageViewController(self.contentViewController, direction: "reverse")
//        
//        }
        
        if currentIndex == item.tag {
            return
        }
        else if (currentIndex == 1) {
            if item.tag == 0 {
                self.contentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ViewWithTable") as! BaseViewController
                self.contentViewController.pageIndex = 0
                print("Feed from Camera")
                print("From \(currentIndex) to \(item.tag)")
                changePageInPageViewController(self.contentViewController, direction: "reverse")
                return
            }
            else if item.tag == 2 {
                self.contentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Profile") as! BaseViewController
                self.contentViewController.pageIndex = 2
                print("Profile from Camera")
                print("From \(currentIndex) to \(item.tag)")
                changePageInPageViewController(self.contentViewController, direction: "forward")
                return
            }
        }
            else if currentIndex == 0 {
                if item.tag == 1 {
                    self.contentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ViewWithTable") as! BaseViewController
                    self.contentViewController.pageIndex = 0
                    print("Camera from Feed")
                    print("From \(currentIndex) to \(item.tag)")
                    
                    let viewWithGallery = self.storyboard?.instantiateViewControllerWithIdentifier("GalleryCameraViewController") as! BaseViewController
                    //performSegueWithIdentifier("Modal", sender: self)
                    self.presentViewController(viewWithGallery, animated: true, completion: nil)
                    changePageInPageViewController(self.contentViewController, direction: "forward")
                    self.feedProfileTabBar.selectedItem = self.feedBarItem
                    return
                }
                else if item.tag == 2 {
                    self.contentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Profile") as! BaseViewController
                    self.contentViewController.pageIndex = 2
                    print("Profile from Feed")
                    print("From \(currentIndex) to \(item.tag)")
                    changePageInPageViewController(self.contentViewController, direction: "forward")
                    return
                }
        }
                else if (currentIndex == 2) {
                    if item.tag == 0 {
                        self.contentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ViewWithTable") as! BaseViewController
                        self.contentViewController.pageIndex = 0
                        print("Feed from Profile")
                        print("From \(currentIndex) to \(item.tag)")
                        changePageInPageViewController(self.contentViewController, direction: "reverse")
                        return
                    }
                    else if item.tag == 1 {
                        self.contentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Profile") as! BaseViewController
                        self.contentViewController.pageIndex = 2
                        print("Camera from Profile")
                        print("From \(currentIndex) to \(item.tag)")
                        
                       let viewWithGallery = self.storyboard?.instantiateViewControllerWithIdentifier("GalleryCameraViewController") as! BaseViewController
                         //performSegueWithIdentifier("Modal", sender: self)
                       self.presentViewController(viewWithGallery, animated: true, completion: nil)
                        
                        changePageInPageViewController(self.contentViewController, direction: "reverse")
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
    
    


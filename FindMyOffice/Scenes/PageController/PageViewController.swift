//
//  PageViewController.swift
//  FindMyOffice
//
//  Created by Emincan on 20.08.2022.
//

import UIKit

class PageViewController: UIPageViewController {
    
    let listvc = OfficesViewController()
    let mapvc = MapViewViewController()
    var vcs = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard1 = UIStoryboard(name: "Offices", bundle: nil)
        let destinationVC1: OfficesViewController = storyboard1.instantiateViewController(withIdentifier: "OfficesViewController") as! OfficesViewController
        let storyboard2 = UIStoryboard(name: "MapView", bundle: nil)
        let destinationVC2: MapViewViewController = storyboard2.instantiateViewController(withIdentifier: "MapViewViewController") as! MapViewViewController
        navigationItem.setHidesBackButton(true, animated: false)
        vcs = [destinationVC1,destinationVC2]
        
        
        if let vc = vcs.first {
            setViewControllers([vc], direction: .forward, animated: true)
        }
        
        delegate = self
        dataSource = self
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
extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController == vcs.last {
            return vcs.first
        } else    if viewController == vcs.first {
            return nil
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController == vcs.first {
            return vcs.last
        } else    if viewController == vcs.last {
            return nil
        } else {
            return nil
        }
    }
    
    
}

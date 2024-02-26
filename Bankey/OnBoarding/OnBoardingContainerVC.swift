//
//  OnBoardingContainerVC.swift
//  Bankey
//
//  Created by Ranjit Mahto on 08/09/23.
//

import UIKit

protocol OnBoardingContainerVCDelgate:AnyObject{
    func didFinishOnBoarding()
}

class OnBoardingContainerVC: UIViewController {

    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    var currentVC: UIViewController {
        didSet {
        }
    }
    var closeButton = UIButton(type:.system)
    var nextBUtton = UIButton(type: .system)
    var backButton = UIButton(type: .system)
    
    weak var delegate: OnBoardingContainerVCDelgate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        let page1 = OnBoardingViewController(imageName:"delorean",
                                          descText: "Banky is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in the 80s.")
        let page2 = OnBoardingViewController(imageName:"world",
                                          descText: "Move your money around the world quickly and securily")
        let page3 = OnBoardingViewController(imageName:"thumbs",
                                          descText: "Learn more at www.bankey.com")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        style()
        layout()
    }
    
    private func setup(){
        view.backgroundColor = .systemPurple
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
        ])
        
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        currentVC = pages.first!
    }
    
    private func style(){
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("Close", for:[])
        closeButton.addTarget(self, action:#selector(closeTapped), for:.primaryActionTriggered)
        
        nextBUtton.translatesAutoresizingMaskIntoConstraints = false
        nextBUtton.setTitle("Next", for: [])
        nextBUtton.addTarget(self, action: #selector(nextTapped), for: .primaryActionTriggered)
        
    }
    
    private func layout(){
        view.addSubview(closeButton)
        view.addSubview(nextBUtton)
        
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter:view.leadingAnchor, multiplier:2),
            closeButton.topAnchor.constraint(equalToSystemSpacingBelow:view.safeAreaLayoutGuide.topAnchor, multiplier:2)
        ])
        
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalToSystemSpacingAfter:nextBUtton.trailingAnchor, multiplier: 2),
            nextBUtton.bottomAnchor.constraint(equalToSystemSpacingBelow:view.safeAreaLayoutGuide.bottomAnchor, multiplier:2)
        ])
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnBoardingContainerVC: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }

    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        currentVC = pages[index - 1]
        return pages[index - 1]
    }

    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        currentVC = pages[index + 1]
        return pages[index + 1]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}

//MARK : Actions
extension OnBoardingContainerVC {
    
    @objc func closeTapped(_ sender:UIButton){
        delegate?.didFinishOnBoarding()
    }
    
    @objc func nextTapped(_ sender:UIButton){
        
    }
}




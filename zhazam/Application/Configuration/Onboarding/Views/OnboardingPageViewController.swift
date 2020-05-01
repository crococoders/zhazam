//
//  OnboardingPageViewController.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/1/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class OnboardingPageViewController: UIPageViewController {

    private let pages: [OnboardingPage]
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = R.color.textColor()
        pageControl.pageIndicatorTintColor = R.color.defaultGray()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    init(with pages: [OnboardingPage]) {
        self.pages = pages
        
        super.init(transitionStyle: .scroll,
                   navigationOrientation: .horizontal,
                   options: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPageControl()
        setInitialViewController()
        configurePageViewController()
    }
    
    private func configurePageViewController() {
        delegate = self
        dataSource = self
        view.backgroundColor = R.color.background()
    }
    
    private func setInitialViewController() {
        guard let viewController = getPage(for: 0) else { return }
        setViewControllers([viewController],
                           direction: .forward,
                           animated: false,
                           completion: nil)
    }
    
    private func setupPageControl() {
        view.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50),
            pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    private func getPage(for index: Int) -> OnboardingViewController? {
        guard index >= 0, index < pages.count else { return nil }
        let viewController = OnboardingViewController(with: pages[index], index: index)
        
        return viewController
    }
}

extension OnboardingPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let pageVC = viewController as? OnboardingViewController,
            pageVC.getIndex() > 0 else { return nil }
        
        return getPage(for: pageVC.getIndex() - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let pageVC = viewController as? OnboardingViewController else { return nil }
        let index = pageVC.getIndex()
        
        return getPage(for: index + 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        guard let viewController = viewControllers?.first as? OnboardingViewController else { return }
        let index = viewController.getIndex()
        pageControl.currentPage = index
    }
}

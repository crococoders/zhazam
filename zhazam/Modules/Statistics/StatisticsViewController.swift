//
//  StatisticsViewController.swift
//  zhazam
//
//  Created by Abai Kalikov on 4/30/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class StatisticsViewController: UIViewController, Reusable {
    
    private enum Constants {
        static let loopingMargin = 100
        static let pickerViewRowHeight: CGFloat = 150
        static let cellSpacing: CGFloat = 10
        static let cellSize: CGFloat = 150
    }
    
    @IBOutlet private var collectionView: UICollectionView!
    
    weak var delegate: UICollectionViewDelegate?
    private let storage: StatisticsStorage = StatisticsStorage()
    private var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            StatisticsCollectionCell.self,
            forCellWithReuseIdentifier: identifier)
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        didSetMaskDisabled()
    }
 
    private func scrollToItem(at index: Int, animated: Bool = false) {
        collectionView.scrollToItem(
            at: IndexPath(
                item: index,
                section: 0),
            at: .centeredVertically,
            animated: animated)
    }

    private func selectItem(at index: Int, animated: Bool, scroll: Bool, notifySelection: Bool) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.selectItem(
            at: indexPath,
            animated: animated,
            scrollPosition: UICollectionView.ScrollPosition())
        if scroll {
            scrollToItem(at: index, animated: animated)
        }
        
        selectedIndex = index
        self.delegate?.collectionView?(collectionView, didSelectItemAt: indexPath)
    }
    
    private func didSetMaskDisabled() {
        collectionView.layer.mask = {
            let maskLayer = CAGradientLayer()
            maskLayer.frame = collectionView.bounds
            maskLayer.colors = [
                UIColor.clear.cgColor,
                UIColor.black.cgColor,
                UIColor.black.cgColor,
                UIColor.clear.cgColor]
            maskLayer.locations = [0.0, 0.33, 0.66, 1.0]
            maskLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            maskLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
            return maskLayer
        }()
    }
}

extension StatisticsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectItem(at: indexPath.item, animated: true, scroll: true, notifySelection: true)
    }
}

extension StatisticsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.loopingMargin * storage.statistics.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: identifier,
            for: indexPath) as! StatisticsCollectionCell
        let currentIndex = indexPath.item % storage.statistics.count
        let statisticsModel = storage.statistics[currentIndex]
        cell.configureItems(model: statisticsModel)
        
        return cell
    }
}

extension StatisticsViewController: UIScrollViewDelegate {
    func didScroll(end: Bool) {
        let center = view.convert(collectionView.center, to: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: center) {
            self.selectItem(at: indexPath.item, animated: true, scroll: end, notifySelection: true)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidEndDecelerating?(scrollView)
        
        didScroll(end: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        delegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
        
        if !decelerate {
            didScroll(end: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll?(scrollView)
        
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        collectionView.layer.mask?.frame = collectionView.bounds
        CATransaction.commit()
    }
}

extension StatisticsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: Constants.cellSize)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.cellSpacing
    }
}

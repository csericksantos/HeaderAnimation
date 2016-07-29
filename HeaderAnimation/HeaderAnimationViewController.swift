//
//  AnimationViewController.swift
//  HeaderAnimation
//
//  Created by Erick Santos on 7/29/16.
//  Copyright © 2016 Erick Santos. All rights reserved.
//

import UIKit

class HeaderAnimationViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var animationTopView: UIView!
    
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIView!
    
    @IBOutlet weak var topHeaderViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightHeaderViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topAnimationViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topUserImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightUserImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthUserImageConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bottomNameLabelConstraint: NSLayoutConstraint!
    
    let dataSource = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    override func viewDidLoad() {
        collectionView.reloadData()
    }
    
}

extension HeaderAnimationViewController : UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) 
        
        return cell
    }
    
}

extension HeaderAnimationViewController : UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(floor(self.view.bounds.width/2), floor(self.view.bounds.width/2))
    }
    
}


extension HeaderAnimationViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
    
        scrollHeaderView(yScrollView: scrollView.contentOffset.y)
        scrollAnimationView(yScrollView: scrollView.contentOffset.y)
        resizeUserImage(yScrollView: scrollView.contentOffset.y)
        scrollNameLabel(yScrollView: scrollView.contentOffset.y)
        changeLabelColor(yScrollView: scrollView.contentOffset.y)
        
    }
    
    func scrollHeaderView(yScrollView y: CGFloat) {
        
        let headerTop = -(y)
        let initialTop: CGFloat = 0
        
        if headerTop <= initialTop {
            topHeaderViewConstraint.constant = headerTop
        } else {
            topHeaderViewConstraint.constant = initialTop
        }
    }
    
    func scrollAnimationView(yScrollView y: CGFloat) {
        
        let headerTop = -(y)
        let limitHeaderTop: CGFloat = 30
        
        if headerTop <= -(limitHeaderTop) {
            topAnimationViewConstraint.constant = -(headerTop + limitHeaderTop)
        } else {
            topAnimationViewConstraint.constant = 0
        }
    }
    
    func resizeUserImage(yScrollView y: CGFloat) {
        
        let imageDefaulSize: CGFloat = 90
        let imageMinimumSize: CGFloat = 58
        let imageDefaulTop: CGFloat = 60
        
        let imageSize = (imageDefaulSize - y)
        let imageTop = y + imageDefaulTop
        
        if imageSize <= imageMinimumSize {
            heightUserImageConstraint.constant = imageMinimumSize
            widthUserImageConstraint.constant = imageMinimumSize
            
            if headerView.subviews.indexOf(userImageView)! > headerView.subviews.indexOf(animationTopView)!{
                headerView.exchangeSubviewAtIndex(headerView.subviews.indexOf(userImageView)!, withSubviewAtIndex: headerView.subviews.indexOf(animationTopView)!)
            }
        } else {
            
            if headerView.subviews.indexOf(userImageView)! < headerView.subviews.indexOf(animationTopView)!{
                headerView.exchangeSubviewAtIndex(headerView.subviews.indexOf(userImageView)!, withSubviewAtIndex: headerView.subviews.indexOf(animationTopView)!)
            }
            
            if imageSize >= imageDefaulSize {
                heightUserImageConstraint.constant = imageDefaulSize
                widthUserImageConstraint.constant = imageDefaulSize
                topUserImageConstraint.constant = imageDefaulTop
            } else {
                heightUserImageConstraint.constant = imageSize
                widthUserImageConstraint.constant = imageSize
                topUserImageConstraint.constant = imageTop
            }
        }
        
    }
    
    func scrollNameLabel(yScrollView y: CGFloat) {
        
        let centerLabelY: CGFloat = 150
        let labelDefaultBottom: CGFloat = 56
        
        if y >= centerLabelY {
            bottomNameLabelConstraint.constant = labelDefaultBottom - (y - centerLabelY)
        } else {
            bottomNameLabelConstraint.constant = labelDefaultBottom
        }
        
    }
    
    func changeLabelColor(yScrollView y: CGFloat) {
        
        if y >= 120 && y < 150{
            
            let colorUpdate = ((y - 120) * 100 / 5) / 100
            
            userNameLabel.textColor = UIColor(red: colorUpdate, green: colorUpdate, blue: colorUpdate, alpha: 1)
        }
        
        if y >= 150 {
            
            userNameLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        }
        
        if y < 120 {
            userNameLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
    
    }
}

//
//  ProfileInfoHeaderCollectionReusableView.swift
//  Little Oven V3
//
//  Created by MacPro on 11/5/20.
//

import UIKit

class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
        static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .systemPurple
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  ProfileViewController.swift
//  Little Oven V3
//
//  Created by MacPro on 10/19/20.
//

import UIKit
///Profile view controller
final class ProfileViewController: UIViewController {
    
    
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .vertical
        let size = (view.width - 4)/3
        layout.itemSize = CGSize(width: size, height: size)
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 0)
        
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        
        
        collectionView?.backgroundColor = .secondarySystemBackground
        //Cell
        collectionView?.register(PhotoCollectionViewCell.self,
                                 forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        //Header
        collectionView?.register(ProfileInfoHeaderCollectionReusableView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                 withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)
        
        collectionView?.register(ProfileTabsCollectionReusableView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                 withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
        
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
        
    }
    private func configureNavigationBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettingsButton) )
    }
    
    
    @objc private func didTapSettingsButton(){
        let vc = SettingsViewController()
        vc.title = "Settings"
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}


extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 0
        }
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        cell.backgroundColor = .label
        cell.configure(debug: "Test")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader else{
            
            return UICollectionReusableView()
            
        }
        if indexPath.section == 1 {
            //tabs header
            let tabControlHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier:  ProfileTabsCollectionReusableView.identifier,
                                                                         for: indexPath) as!
                                                                            ProfileTabsCollectionReusableView
            return tabControlHeader
        
        }
        
        let profileHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier,
                                                                     for: indexPath) as!ProfileInfoHeaderCollectionReusableView
        return profileHeader
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.width,
                          height: collectionView.height/3)
        }
        return CGSize(width: collectionView.width,
                      height: 65)
    }
}

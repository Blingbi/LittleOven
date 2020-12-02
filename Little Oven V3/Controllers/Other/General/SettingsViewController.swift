//
//  SettingsViewController.swift
//  Little Oven V3
//
//  Created by MacPro on 10/20/20.
//
import SafariServices
import UIKit
///View controller to display settings

struct SettingCellModel {
    let title: String
    let handler: (() -> Void)
}

final class SettingsViewController: UIViewController{
    
    
    private let tableview: UITableView = {
        let tableView = UITableView(frame: .zero,
                                    style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    private var data = [[SettingCellModel]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
    }
    
    private func configureModels(){
        data.append([
            SettingCellModel(title: "Edit Profile") { [weak self] in
                self?.didTapLEditProfile()
                
            },
            SettingCellModel(title: "Invite Friends") { [weak self] in
                self?.didTapInviteFriends()
                
            },
            SettingCellModel(title: "Save Original Posts") { [weak self] in
                self?.didTapSaveOriginalPosts()
                
            }
            
        ])
        data.append([
            SettingCellModel(title: "Privacy Policy") { [weak self] in
                self?.openURL(type: .privacy)
                
            }
            
        ])
        data.append([
            SettingCellModel(title: "Help and Feedback") { [weak self] in
                self?.openURL(type: .help)
                
            }
            
        ])
        data.append([
            SettingCellModel(title: "Terms Of Service") { [weak self] in
                self?.openURL(type: .terms)
                
            }
            
        ])
        data.append([
            SettingCellModel(title: "Log Out") { [weak self] in
                self?.didTapLogout()
                
            }
            
        ])
        
    }
    enum SettingsURLType{
        case terms, privacy, help
    }
    private func openURL(type: SettingsURLType){
        let urlString: String
        switch type {
        case .terms: urlString = "https://heeeeeeeey.com"
        case .privacy: urlString = "https://heeeeeeeey.com"
        case .help: urlString = "https://heeeeeeeey.com"
            
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    private func didTapSaveOriginalPosts(){
        
    }
    private func didTapLEditProfile(){
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    private func didTapInviteFriends(){
        
    }
    
    private func didTapLogout(){
        
        let actionSheet = UIAlertController(title: "Log Out",
                                            message: "Are you sure you want to log out",
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: "Log Out",
                                            style: .destructive,
                                            handler: {  _ in
                                                
                                                AuthManager.shared.logOut(completion: { success in
                                                    
                                                    DispatchQueue.main.async {
                                                        if success{
                                                            //present login
                                                            let loginVC = LoginViewController()
                                                            loginVC.modalPresentationStyle = .fullScreen
                                                            self.present(loginVC, animated: true) {
                                                                self.navigationController?.popToRootViewController(animated: false)
                                                                self.tabBarController?.selectedIndex = 0
                                                            }
                                                        }
                                                        else{
                                                            fatalError("Could not log out user")
                                                            
                                                        }
                                                    }
                                                })
                                            }))
        actionSheet.popoverPresentationController?.sourceView = tableview
        actionSheet.popoverPresentationController?.sourceRect = tableview.bounds
        
        present(actionSheet, animated: true)
        
    }
}









extension SettingsViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)-> Int {
        return data[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        // handle cell selection
        data[indexPath.section][indexPath.row].handler()
    }
}

//
//  AccountSummaryVC.swift
//  Bankey
//
//  Created by Ranjit Mahto on 15/09/23.
//

import Foundation
import UIKit

class AccountSummaryVC: UIViewController {
    
    //Request Models
    var profile:Profile?
    var accounts: [Account] = []

    
    //view models
    var accountCellViewModel: [AccountSummaryCell.ViewModel] = []
    var headerViewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage:"Welcome",
                                                             name:"rkm",
                                                             date:Date())
    var tableView = UITableView()
    var headerView = AccountSummaryHeaderView(frame:.zero)
    var refreshControl = UIRefreshControl()
    
    let profileManager = ProfileManager()
    
    //Error Alert
    lazy var errorAlert: UIAlertController = {
        let alert = UIAlertController(title:"", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"OK", style:.default))
        return alert
    }()
    
    var isLoaded = false
    
    lazy var logoutBarButtonItem : UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title:"LogOut", style: .plain, target: self, action: #selector(logOutTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
}

extension AccountSummaryVC {
    
    private func setUp(){
        setUpNavigationBar()
        setUpTableView()
        setUpTableHeaderView()
        setUpRefreshControll()
        setUpSkeleton()
        fetchData()
    }
    
    private func setUpNavigationBar(){
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
    private func setUpTableView(){
        
        tableView.backgroundColor = appColor
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(SkeletonCell.self, forCellReuseIdentifier: SkeletonCell.reuseID)
        
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
    }
    
    private func setUpTableHeaderView(){
                
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        tableView.tableHeaderView = headerView
        
    }
    
    private func setUpRefreshControll(){
        refreshControl.tintColor = appColor
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func setUpSkeleton(){
        let row = Account.makeSkeleton()
        accounts = Array(repeating: row, count: 10)
        configureTableCell(with: accounts)
    }
}

extension AccountSummaryVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountCellViewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard !accountCellViewModel.isEmpty else { return UITableViewCell() }
        let accountData = accountCellViewModel[indexPath.row]
        
        if isLoaded {
            let cell = tableView.dequeueReusableCell(withIdentifier:AccountSummaryCell.reuseID, for:indexPath) as! AccountSummaryCell
            //cell.typeLabel.text = games[indexPath.row]
            //let accountData = accountCellViewModel[indexPath.row]
            cell.configure(with: accountData)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier:SkeletonCell.reuseID, for: indexPath) as! SkeletonCell
        return cell
        
    }
}

extension AccountSummaryVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//MARK: Action
extension AccountSummaryVC {
    
    @objc private func logOutTapped(_ sender:UIButton){
        NotificationCenter.default.post(name:.logout, object:nil)
    }
    
//    @objc private func refreshContent(){
//        fetchData()
//    }
    
    @objc private func refreshContent(){
        reset()
        setUpSkeleton()
        tableView.reloadData()
        fetchData()
    }
    
    private func reset() {
        profile = nil
        accounts = []
        isLoaded = false
    }
    
    
}

//MARK: Network With Local Data
/*
extension AccountSummaryVC {
    
    private func fetchData() {
        fetchAccounts()
        //fetchProfile()
    }
    
    private func fetchAccounts(){
        
        let saving = AccountSummaryCell.ViewModel(accountType: .Banking,
                                                  accountName:"Basic Saving",
                                                  balance: 929466.23)
        
        let chequing = AccountSummaryCell.ViewModel(accountType: .Banking,
                                                    accountName: "No-Fee All-In Chequing",
                                                    balance: 17562.44)
        
        let visa = AccountSummaryCell.ViewModel(accountType: .CreditCard,
                                                accountName: "Visa Avion Card",
                                                balance: 412.83)
        
        let masterCard = AccountSummaryCell.ViewModel(accountType: .CreditCard,
                                                accountName: "Student Mastercard",
                                                balance: 50.83)
        
        let investment1 = AccountSummaryCell.ViewModel(accountType: .Investment,
                                                       accountName: "Tax-Free Saver",
                                                       balance: 2000.00)
        
        let investment2 = AccountSummaryCell.ViewModel(accountType: .Investment,
                                                       accountName: "Growth Fund",
                                                       balance: 15000.00)
        
        accountCellViewModel.append(saving)
        accountCellViewModel.append(chequing)
        accountCellViewModel.append(visa)
        accountCellViewModel.append(masterCard)
        accountCellViewModel.append(investment1)
        accountCellViewModel.append(investment2)
        
    }
}
*/


// MARK: - Networking
extension AccountSummaryVC {
    
    private func fetchData(){
        
        let group = DispatchGroup()
        let userId = String(Int.random(in: 1..<4))
        
        fetchProfile(group: group, userId: userId)
        fetchAccount(group: group, userId: userId)

        group.notify(queue: .main) {
            self.reloadView()
        }
    }
    
    private func fetchProfile(group: DispatchGroup, userId: String) {
        group.enter()
        profileManager.fetchProfile(forUserId: userId) { result in
            switch result {
            case .success(let profile):
                self.profile = profile
            case .failure(let error):
                print(error.localizedDescription)
                self.displayError(error: error)
            }
            group.leave()
        }
    }
    
    private func fetchAccount(group: DispatchGroup, userId: String) {
        group.enter()
        fetchAccounts(forUserId: userId) { result in
            switch result {
                case .success(let accounts):
                    self.accounts = accounts
                case .failure(let error):
                    print(error.localizedDescription)
                    self.displayError(error: error)
            }
            group.leave()
        }
    }
    
    private func reloadView(){
        self.tableView.refreshControl?.endRefreshing()
        
        guard let profile = self.profile else {return}
        
        self.isLoaded = true
        self.configureTableHeaderView(with:profile)
        self.configureTableCell(with: self.accounts)
        self.tableView.reloadData()
    }
    
    /*
    private func fetchData() {
        
        let group = DispatchGroup()
        
        //for testing random number user id select
        let userId = String(Int.random(in: 1..<4))
        
        group.enter()
        profileManager.fetchProfile(forUserId: userId) { result in
            switch result {
            case .success(let profile):
                self.profile = profile
            case .failure(let error):
                print(error.localizedDescription)
                self.displayError(error: error)
            }
            group.leave()
        }

        group.enter()
        fetchAccounts(forUserId: userId) { result in
            switch result {
                case .success(let accounts):
                    self.accounts = accounts
                case .failure(let error):
                    print(error.localizedDescription)
                    self.displayError(error: error)
            }
            group.leave()
        }
        
        group.notify(queue: .main){
            
            self.tableView.refreshControl?.endRefreshing()
            
            guard let profile = self.profile else {return}
            
            self.isLoaded = true
            self.configureTableHeaderView(with:profile)
            self.configureTableCell(with: self.accounts)
            self.tableView.reloadData()
        }
       
    }
    */
    
    private func configureTableHeaderView(with profile: Profile) {
        let vm = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Good morning",
                                                    name: profile.firstName,
                                                    date: Date())
        headerView.configure(viewModel: vm)
    }
    
    private func configureTableCell(with accounts: [Account]) {
        accountCellViewModel = accounts.map{
            AccountSummaryCell.ViewModel(accountType: $0.type,
                                         accountName: $0.name,
                                         balance: $0.amount)
        }
    }
    
    private func displayError(error: NetworkError){
        let titleAndMessage = titleAndMessage(for: error)
        self.showErrorAlert(title: titleAndMessage.0, message: titleAndMessage.1)
    }
    
    func titleAndMessage(for error:NetworkError) -> (String, String){
        var title : String
        var message : String
        switch error {
            case .serverError:
                title = "Server Error"
                message = "Ensure you are connected to the internet, please try again."
            case .decodingError:
                title = "Decoding Error"
                message = "We coluld not process your request. Please try agian"
        }
        return (title, message)
    }
    
    private func showErrorAlert(title:String, message:String){
        errorAlert.title = title
        errorAlert.message = message
        present(errorAlert, animated: true)
    }
}


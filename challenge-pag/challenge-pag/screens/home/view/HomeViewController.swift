//
//  HomeViewController.swift
//  challenge-pag
//
//  Created by Leonardo Sugano on 08/03/21.
//

import UIKit
import UIScrollView_InfiniteScroll

class HomeViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView?
    
    //MARK: - Lets
    let cellIdentifier = "homeTableViewCell"
    
    //MARK: - Vars
    var presenter: ViewToPresenterHomeProtocol?
    var refreshControl = UIRefreshControl()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
       
    }
    
    private func setup() {
        self.setupTableView()
        self.setupNavigationBar()
        presenter?.fetchBeers(pagination: false, refresh: false)
    }
    
    //MARK: - Setups
    private func setupNavigationBar() {
        self.title = "home_title".localized()
    }
    
    private func setupTableView() {
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.tableFooterView = UIView()
        self.refreshControl.addTarget(self, action: #selector(getBeers), for: .valueChanged)
        
        self.tableView?.addInfiniteScroll(handler: { [weak self] (tableView) in
            if let self = self {
                self.presenter?.fetchBeers(pagination: true, refresh: false)
            }
        })
        
        if #available(iOS 10.0, *) {
            self.tableView?.refreshControl = self.refreshControl
        } else {
            self.tableView?.addSubview(self.refreshControl)
        }
    }
    
    //MARK: - API
    @objc func getBeers() {
        presenter?.fetchBeers(pagination: false, refresh: true)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let navigation = self.navigationController {
            self.presenter?.showDetailController(navigationController: navigation, indexPath: indexPath)
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.beersResponse?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HomeTableViewCell, let beer = self.presenter?.beersResponse?[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.setupCellWithBeer(beer: beer)
        return cell
    }
}

extension HomeViewController: PresenterToViewHomeProtocol{
    func showBeers() {
        self.tableView?.reloadData()
    }
    
    func showLoader() {
        self.view?.showLoader()
    }
    
    func endLoader() {
        self.view?.removeLoader()
        self.refreshControl.endRefreshing()
        self.tableView?.finishInfiniteScroll()
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "error_title".localized(), message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok".localized(), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}



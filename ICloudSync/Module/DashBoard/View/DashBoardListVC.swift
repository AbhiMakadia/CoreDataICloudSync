//
//  DashBoardListVC.swift
//  ICloudSync
//
//  Created by Abhi Makadiya on 03/11/20.
//  Copyright © 2020 Abhi Makadiya. All rights reserved.
//

import UIKit

class DashBoardListVC: UIViewController {
    
    // MARK: - Variables
    var coordinator: HomeCoordinator?
    var viewModel = DashboardViewModel()
    
    // MARK: - Outlets
    @IBOutlet weak var tblPlaceList: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.refreshPlaces()
    }
    
    // MARK: - Function Declaration
    func setupUI() {
        ///navigation bar button
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button.tintColor = R.color.orange()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(rightBarButtonAction), for: .touchUpInside)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 40, height: 40)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        ///tableview
        tblPlaceList.register(R.nib.placeListTVCell)
        ///closures
        closures()
    }
    
    func closures() {
        viewModel.reloadData = { [weak self] in
            guard let `self` = self else {
                return
            }
            self.tblPlaceList.reloadData()
        }
    }
    
    @objc func rightBarButtonAction() {
        coordinator?.toAddDetailScreen()
    }
    
}

// MARK: - Tableview Delegates
extension DashBoardListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.placeListTVCell, for: indexPath) else {
            return UITableViewCell()
        }
        cell.configCell(viewModel.arrPlaces[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            CoreDataAccess.shared.deletePlace(viewModel.arrPlaces[indexPath.row])
            viewModel.arrPlaces.remove(at: indexPath.row)
            tableView.endUpdates()
        }
    }
}

extension DashBoardListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        coordinator?.toDetailScreen(viewModel.arrPlaces[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

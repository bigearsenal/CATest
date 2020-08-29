//
//  TableViewController.swift
//  CATest
//
//  Created by Chung Tran on 8/28/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    lazy var viewControllers: [UIViewController] = [
        LayerCustomTranstionVC(nibName: nil, bundle: nil),
        DisableImplicitAnimsVC(nibName: nil, bundle: nil),
        UsingPresentationLayerVC(nibName: nil, bundle: nil),
        CAAnimationDelegateVC(nibName: nil, bundle: nil),
        MovingAircraftVC(nibName: nil, bundle: nil),
        TransitionVC(nibName: nil, bundle: nil),
        KeyframeAnimationsVC(nibName: nil, bundle: nil),
        VirtualPropertyAnimsVC(nibName: nil, bundle: nil),
        AnimationGroupVC(nibName: nil, bundle: nil),
        TranstionUIKitVC(nibName: nil, bundle: nil),
        TransitionTabBarVC(nibName: nil, bundle: nil),
        RenderInContextVC(nibName: nil, bundle: nil),
        CancellableAnimationVC(nibName: nil, bundle: nil),
        SwingingDoorVC(nibName: nil, bundle: nil),
        TimeOffsetAndSpeedVC()
    ].reversed()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewControllers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = "\(type(of: viewControllers[indexPath.row]).self)"

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        show(viewControllers[indexPath.row], sender: nil)
    }

}

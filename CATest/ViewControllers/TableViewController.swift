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
        LayerCustomTranstionVC(),
        DisableImplicitAnimsVC(),
        UsingPresentationLayerVC(),
        CAAnimationDelegateVC(),
        MovingAircraftVC(),
        TransitionVC(),
        KeyframeAnimationsVC(),
        VirtualPropertyAnimsVC(),
        AnimationGroupVC(),
        TranstionUIKitVC(),
        TransitionTabBarVC(),
        RenderInContextVC(),
        CancellableAnimationVC(),
        SwingingDoorVC(),
        TimeOffsetAndSpeedVC(),
        PausingAnimation(),
        EasingAnimationVC(),
        EasingKeyframeAnimationVC(),
        ClockVC()
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

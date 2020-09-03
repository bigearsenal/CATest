//
//  TableViewController.swift
//  CATest
//
//  Created by Chung Tran on 8/28/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    lazy var viewControllers: [(String, [UIViewController])] = [
        ("Layer animations", [
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
            ClockVC(),
            BoucingBallVC(),
            BouncingBall2VC(),
            BouncingFunctionVC(),
            BouncingBallTimer(),
            BouncingBallCADisplayLink(),
            CustomDrawingVC<PathStrokeDrawingView>(),
            CustomDrawingVC<LayerDrawingView>(),
            ChalkBoardVC(),
            ChalkBoardReducingDrawingVC(),
            ImageCarouselVC()
        ].reversed()),
        ("View animations", [
            CrossfadingAnimationVC(),
            CubeTransitionVC(),
            ViewKeyframeAnimationVC()
        ].reversed()),
        ("ViewController Transition", [
            VinylPlayerVC()
        ])
    ].reversed()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewControllers.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewControllers[section].1.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = "\(type(of: viewControllers[indexPath.section].1[indexPath.row]).self)"

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        show(viewControllers[indexPath.section].1[indexPath.row], sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewControllers[section].0
    }

}

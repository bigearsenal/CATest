//
//  TableViewController.swift
//  CATest
//
//  Created by Chung Tran on 8/28/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    lazy var viewControllers: [(String, [BaseViewController.Type])] = [
        ("Layer animations", [
            LayerCustomTranstionVC.self,
            DisableImplicitAnimsVC.self,
            UsingPresentationLayerVC.self,
            CAAnimationDelegateVC.self,
            MovingAircraftVC.self,
            TransitionVC.self,
            KeyframeAnimationsVC.self,
            VirtualPropertyAnimsVC.self,
            AnimationGroupVC.self,
            TranstionUIKitVC.self,
//            TransitionTabBarVC.self,
            RenderInContextVC.self,
            CancellableAnimationVC.self,
            SwingingDoorVC.self,
            TimeOffsetAndSpeedVC.self,
            PausingAnimation.self,
            EasingAnimationVC.self,
            EasingKeyframeAnimationVC.self,
            ClockVC.self,
            BoucingBallVC.self,
            BouncingBall2VC.self,
            BouncingFunctionVC.self,
            BouncingBallTimer.self,
            BouncingBallCADisplayLink.self,
            CustomDrawingVC<PathStrokeDrawingView>.self,
            CustomDrawingVC<LayerDrawingView>.self,
            ChalkBoardVC.self,
            ChalkBoardReducingDrawingVC.self,
            ImageCarouselVC.self
        ].reversed()),
        ("View animations", [
            CrossfadingAnimationVC.self,
            CubeTransitionVC.self,
            ViewKeyframeAnimationVC.self
        ].reversed()),
        ("ViewController Transition", [
            VinylPlayerVC.self,
            SplashRevealVC.self
        ].reversed()),
        ("UIViewPropertyAnimator (iOS 10)", [
            UIViewPropertyAnimatorVC.self,
            UIViewPropertyAnimatorKeyframesVC.self,
            BlurAnimationVC.self,
            SpringAnimatorVC.self,
            ConstraintAnimationVC.self,
            ExpandableListVC.self
        ].reversed())
    ].reversed()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "animations"
        navigationController?.navigationBar.prefersLargeTitles = true
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
        cell.textLabel?.text = "\(viewControllers[indexPath.section].1[indexPath.row])"

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        show(viewControllers[indexPath.section].1[indexPath.row].init(), sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewControllers[section].0
    }

}

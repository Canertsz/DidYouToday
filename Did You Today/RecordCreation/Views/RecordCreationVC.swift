//
//  RecordCreationVC.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 21.03.2025.
//

import UIKit
import Lottie

protocol RecordCreationViewProtocol: AnyObject {
    func setupUI()
    func setupAnimation()
    func dismissViewController(animated: Bool, completion: (() -> Void)?)
}

private extension RecordCreationVC {
    enum constants {
        static let scaleFactor: CGFloat = 0.5
        static let animationSpeed: CGFloat = 0.5
    }
}

final class RecordCreationVC: UIViewController {
    
    var viewModel: RecordCreationViewModelProtocol!
    private var animationView: LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

}

//MARK: - RecordCreationViewProtocol
extension RecordCreationVC: RecordCreationViewProtocol {
    func setupUI() {
        
    }
    
    func setupAnimation() {
        animationView = .init(name: "rabbit")
        
        let scaleFactor: CGFloat = constants.scaleFactor
        animationView!.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)

        animationView!.center = view.center
        animationView!.contentMode = .center
        animationView!.loopMode = .loop
        animationView!.animationSpeed = constants.animationSpeed
        
        view.addSubview(animationView!)
        animationView!.play()
    }
    
    func dismissViewController(animated: Bool, completion: (() -> Void)?) {
        self.dismiss(animated: animated, completion: completion)
    }
}

extension RecordCreationVC: StoryboardInstantiable {
    static var storyboardName: String { "RecordCreation" }
    static var identifier: String { "RecordCreationVC" }
}

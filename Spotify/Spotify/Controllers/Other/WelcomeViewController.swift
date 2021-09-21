//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by Akash G Krishnan on 21/09/21.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private let signInButton : UIButton = {
        let b = UIButton()
        b.backgroundColor = .white
        b.setTitle("Sign in with Spotify", for: .normal)
        b.setTitleColor(.blue, for: .normal)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Spotify"
        view.backgroundColor =  .systemGreen
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        signInButton.frame = CGRect(
            x: 20,
            y: view.height - 100 - view.safeAreaInsets.bottom,
            width: view.width - 50,
            height: 50)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @objc func didTapSignIn()  {
        let vc = AuthViewController()
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

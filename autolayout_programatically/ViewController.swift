//
//  ViewController.swift
//  autolayout_programatically
//
//  Created by shin seunghyun on 2020/03/31.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Let's avoid polluting viewDidLoad
    // {} is referred to as closure, or anonymous functions
    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "icon"))
        //This enables autolayout for our imageview
        //자동으로 imageView의 Constraint 값이 지정되어버리면 안된다.
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let titleTextView: UITextView = {
        let textView = UITextView()
        
        let attributedtext = NSMutableAttributedString(string: "Join us today in our fun and games!", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        attributedtext.append(NSAttributedString(string: "\n\nAre you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        textView.attributedText = attributedtext
        
        //이 값을 false로 바꾸어야지 coding으로 레이아웃을 짤 수 있게 됨.
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.boldSystemFont(ofSize: 18)
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let buttonPref: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("PREV", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.backgroundColor = .white
        button.sizeToFit()
        return button
    }()
    
    let buttonNext: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont(name: "NEXT", size: 20)
        button.setTitleColor(.red, for: .normal)
        button.sizeToFit()
        return button
    }()
    
//    let buttonNext: UIButton = {
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(logoImageView)
        view.addSubview(titleTextView)
        view.addSubview(buttonPref)
        view.addSubview(buttonNext)
        setupLayout()
    }
    
    //코드로 auto layout 위치 지정해주기.
    func setupLayout(){
        let topImageContainerView = UIView()
        topImageContainerView.backgroundColor = .white
        view.addSubview(topImageContainerView)
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        topImageContainerView.addSubview(logoImageView)
        
        logoImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        logoImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5).isActive = true
        
        titleTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor, constant: 20).isActive = true
        titleTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        titleTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        buttonPref.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        buttonPref.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        
        buttonNext.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        buttonNext.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
    }
    

}



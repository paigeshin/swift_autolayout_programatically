//
//  PageCell.swift
//  autolayout_programatically
//
//  Created by shin seunghyun on 2020/04/01.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    //Get Set Design pattern like Java
    var page: Page? {
        didSet {
            guard let unwrappedPage = page else { return }
            
            logoImageView.image = UIImage(named: unwrappedPage.imageName)
    
            let attributedText = NSMutableAttributedString(
                string: unwrappedPage.headerText,
                attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
            )
            
            attributedText.append(
                NSAttributedString(
                    string: "\n\n\nAre you read for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon.",
                    attributes: [
                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
                        NSAttributedString.Key.foregroundColor: UIColor.gray
                    ]
                )
            )
            
            titleTextView.attributedText = attributedText
            titleTextView.textAlignment = .center
            
        }
    }
    
    //View 만들기
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "icon"))
        //This enables autolayout for our imageview
        //자동으로 imageView의 Constraint 값이 지정되어버리면 안된다.
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    //View 만들기
    private let titleTextView: UITextView = {
        let textView = UITextView()
        let attributedtext =
            NSMutableAttributedString(
                string: "Join us today in our fun and games!",
                attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
            )
        attributedtext.append(
            NSAttributedString(
                string: "\n\nAre you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon.",
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]
            )
        )
        textView.attributedText = attributedtext
        
        //이 값을 false로 바꾸어야지 coding으로 레이아웃을 짤 수 있게 됨.
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellLayout()
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //코드로 auto layout 위치 지정해주기.
    func setupCellLayout(){
        let topImageContainerView = UIView()
        topImageContainerView.backgroundColor = .white
        self.addSubview(topImageContainerView)
        self.addSubview(logoImageView)
        self.addSubview(titleTextView)
        
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        topImageContainerView.addSubview(logoImageView)
        
        logoImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        logoImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5).isActive = true
        
        titleTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor, constant: 20).isActive = true
        titleTextView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        titleTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
    }

}


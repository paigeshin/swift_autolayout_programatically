# swift_autolayout_programatically

참고자료:  https://www.youtube.com/watch?v=1UQ-Y1-FNMQ&list=PL0dzCUj1L5JHdeOlzJtp5zlsdrliJTC7F&index=7

notion: https://www.notion.so/Autolayout-Programmatically-collection-view-example-3efc6b2ce9bd4faa8070362608ad66bf


### 🔵 Background color

    view.backgroundColor = .brown

### 🔵 translateAutoresizingMaskIntoConstraints

- 모든 view에 이것을 설정해줘야지 constraint를 customizing이 가능하다.

### 🔵 Constraint Syntax

- widthAnchor
- heightAnchor
- centerXAnchor
- centerYAnchor
- leadingAnchor
- trailingAnchor
- NSLayoutConstraint( [ ] )

### 🔵 TextView Example

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

### 🔵 Button Example

    let buttonPref: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("PREV", for: .normal)
            button.setTitleColor(.gray, for: .normal)
            button.backgroundColor = .white
            button.sizeToFit()
            return button
        }()

### 🔵 Image Example

    let logoImageView: UIImageView = {
            let imageView = UIImageView(image: #imageLiteral(resourceName: "icon"))
            //This enables autolayout for our imageview
            //자동으로 imageView의 Constraint 값이 지정되어버리면 안된다.
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()

### 🔵 Multiplier

- 비율로 값을 정해줌

    topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true

### 🔵 Constraint

- Direct from view

        logoImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        logoImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5).isActive = true

- NSLayoutConstraint.activate([])

        NSLayoutConstraint.activate([
            previousButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            previousButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            previousButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            previousButton.heightAnchor.constraint(equalToConstant: 50)
        ])

### 🔵 StackView Example

    let yellowView = UIView()
            yellowView.backgroundColor = .yellow
            
            let greenView = UIView()
            greenView.backgroundColor = .green
            
            let blueView = UIView()
            blueView.backgroundColor = .blue
            
            let bottomControlsStackView = UIStackView(arrangedSubviews:[
                yellowView, greenView, blueView
            ])
            
            bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
            bottomControlsStackView.distribution = .fillEqually
            bottomControlsStackView.axis = .horizontal //참고로 horizontal이 default임
            
            view.addSubview(bottomControlsStackView)
            
            NSLayoutConstraint.activate([
                bottomControlsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                bottomControlsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50),
                bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])

### 🔵 Parent View and Child View

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

### 🔵 Page Control

    private let pageControl: UIPageControl = {
            let pc = UIPageControl()
            pc.currentPage = 0
            pc.numberOfPages = 4
            pc.currentPageIndicatorTintColor = .red
            pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
            return pc
    }()

### 🔵 Extension

    extension UIColor {
        static var mainPink = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
        static var subMainPink = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
    }

### 🔵 Scene Delegate, programmatically render scene

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            
           //This is how we build out our app in code
        /*
            ios 이전 버전에서는 SceneDelegate가 아니라, App Delegate에서 이 code를 작성해야 했음.
            window = UIWindow()
            window?.makeKeyAndVisible()
        */
           let randomViewController = UIViewController()
           randomViewController.view.backgroundColor = .brown
           window?.rootViewController = randomViewController
            
            guard let _ = (scene as? UIWindowScene) else { return }
        }

### 🔵 Scene Delegate, programmatically render collectionViewController

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            
           //This is how we build out our app in code
        /*
            ios 이전 버전에서는 SceneDelegate가 아니라, App Delegate에서 이 code를 작성해야 했음.
            window = UIWindow()
            window?.makeKeyAndVisible()
        */
            
           
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            let swipingController = SwipingController(collectionViewLayout: layout)
            window?.rootViewController = swipingController
            
            guard let _ = (scene as? UIWindowScene) else { return }
        }

- `UICollectionViewFlowLayout()`
- `SwipingController(collectionViewLayout: )`

### 🔵 Custom Cell Initialization

- PageCell.swift

    import UIKit
    
    class PageCell: UICollectionViewCell {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .purple
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    
    }

### 🔵 CollectionViewController

    import UIKit
    
    class SwipingController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
     
        override func viewDidLoad() {
            super.viewDidLoad()
            collectionView?.backgroundColor = .green
            
            //Programatically Register Cell
    //        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellId")
            
            //When you added a new class to customize it
            collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "CellId")
            
            //Swipe기능이 자동으로 추가됨
            collectionView?.isPagingEnabled = true
        
            //Horizontal Swiping
            
        }
        
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 4 
        }
        
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as! PageCell
            cell.backgroundColor = indexPath.item % 2 == 0 ? .red : . green
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: view.frame.width, height: view.frame.height)
        }
        
        
    }

### 🔵 Swift Get & Set Design pattern

- model

        import Foundation
        
        struct Page {
            
            let imageName: String
            let headerText: String
            
        }

- TableViewCell OR CollectionViewCell 에 아예 변수로 모델을 추가, 그리고 나서 didSet으로 값을 설정해준다.

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

- 실제 화면에 값을 지정해주는 부분

        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as! PageCell
                
                //* Get Set Model 적용, Direct로 변수에 접근을 막음 *
                let page = pages[indexPath.item]
        //        cell.titleTextView.text = pages[indexPath.item].headerText
                cell.page = page //자동으로 Mapping이 된다. PageCell에 설정해둠
                
                return cell
            }

### 🔵 lazy var

- It gives access to your member

        //Page Control
          private lazy var pageControl: UIPageControl = {
              let pc = UIPageControl()
              pc.currentPage = 0
              pc.numberOfPages = pages.count
              pc.currentPageIndicatorTintColor = .red
              pc.pageIndicatorTintColor = UIColor.subMainPink
              return pc
          }()

- `lazy`

    A lazy stored property is a property whose initial value is not calculated until the first time it is used. You indicate a lazy stored property by writing the lazy modifier before its declaration.

    ⇒ 즉, 미리 initialization이 되는 것이 아니라서 같은 class 내부의 member에 접근이 가능해짐

### 🔵 Max & Min

- max

        let maxInt = max(5, 12) // returns 12
        let maxiNT = max(12, 5) // returns 12

- min

        let minInt = min(1, 3) // returns 1 
        let minInt = min(3, 1) // returns 1 

### 🔵 Swiping Collection View `PageControl` Handling

ℹ️ `UICollectionView` inherits `UIScrollView.` Therefore, it inherits methods from `UIScrollView`

    //Swiping Collection View, Essential Method
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        pageControl.currentPage = Int(targetContentOffset.pointee.x / view.frame.width)
    }

### 🔵 Landscape mode fix

    //fix when in landscape mode
        override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            coordinator.animate(alongsideTransition: { (_) in
                self.collectionViewLayout.invalidateLayout()
                
                if self.pageControl.currentPage == 0 {
                    self.collectionView.contentOffset = .zero
                } else {
                    //Scroll To Correct Index
                    let indexPath: IndexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                    self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                }
    
            }, completion: nil)
        }

### 🔵 Paging 했을 시에 item에 중간으로 정렬이 되지 않는 경우 - `minimumLineSpacingForSectionAt`

    //Paging 했을 시에 item에 중간으로 정렬이 되지 않는 경우 - `minimumLineSpacingForSectionAt`
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }

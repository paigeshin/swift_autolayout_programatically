//
//  SwipingController.swift
//  autolayout_programatically
//
//  Created by shin seunghyun on 2020/04/01.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit

//전체 CollectionViewController Initialization
//UICollectionView subclasses UIScrollView, therefore it can inherit methods from UIScrollView
class SwipingController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let pages: [Page] = [
        Page(imageName: "icon", headerText: "Title1"),
        Page(imageName: "icon", headerText: "Title2"),
        Page(imageName: "icon", headerText: "Title3"),
        Page(imageName: "icon", headerText: "Title4")
    ]
    
    let previousButton: UIButton = {
        let button = UIButton(type: .system) //system으로 설정해야 기본적인 default animation이 들어가진다.
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Prev", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.systemGray, for: .normal)
        button.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        let pickColor: UIColor = UIColor.mainPink
        button.setTitleColor(pickColor, for: .normal)
                button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    @objc func handlePrevious(){
        let previousIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: previousIndex, section: 0)
        pageControl.currentPage = previousIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc func handleNext(){
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    //Page Control
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = .red
        pc.pageIndicatorTintColor = UIColor.subMainPink
        return pc
    }()
    

    fileprivate func setUpBottomControls() {
        
        let bottomControlsStackView = UIStackView(arrangedSubviews:[
            previousButton, pageControl, nextButton
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
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBottomControls()
        //Programatically Register Cell
//        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellId")
        
        //When you added a new class to customize it
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "CellId")
        
        //Swipe기능이 자동으로 추가됨
        collectionView?.isPagingEnabled = true
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as! PageCell
        
        //* Get Set Model 적용, Direct로 변수에 접근을 막음 *
        let page = pages[indexPath.item]
//        cell.titleTextView.text = pages[indexPath.item].headerText
        cell.page = page //자동으로 Mapping이 된다. PageCell에 설정해둠
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    //Swiping Collection View, Essential Method
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        pageControl.currentPage = Int(targetContentOffset.pointee.x / view.frame.width)
        print(targetContentOffset.pointee.x)
    }
    
    //Paging 했을 시에 item에 중간으로 정렬이 되지 않는 경우 - `minimumLineSpacingForSectionAt`
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    
}


extension SwipingController {
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
}

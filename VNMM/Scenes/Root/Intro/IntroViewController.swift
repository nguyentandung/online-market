////
////  IntroViewController.swift
////  Quản lý
////
////  Created by Nguyễn Văn Phú on 13/04/21.
//
////
//
//import UIKit
//
//class IntroViewController:  UIViewController, UIScrollViewDelegate {
//    
//    @IBOutlet weak var scrollView: UIScrollView!{
//        didSet{
//            scrollView.delegate = self
//        }
//    }
//    
//    @IBOutlet weak var pageControl: UIPageControl!
//    
//    
//    var slides:[Slide] = [];
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        slides = createSlides()
//        setupSlideScrollView(slides: slides)
//        
//        pageControl.numberOfPages = slides.count
//        pageControl.currentPage = 0
//        view.bringSubviewToFront(pageControl)
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//    
//    
//    @IBAction func actionNextLogin(_ sender: Any) {
////        var loginViewController: LoginViewController?
////        loginViewController = UIStoryboard.loginViewController()
////        self.navigationController!.pushViewController(loginViewController!, animated: false)
//        
//        var loginTypeViewController: LoginTypeViewController?
//        loginTypeViewController = UIStoryboard.loginTypeViewController()
//        self.navigationController!.pushViewController(loginTypeViewController!, animated: false)
//
//    }
//    
//    
//    func createSlides() -> [Slide] {
//        
//        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
//        slide1.imageView.image = UIImage(named: "ic_onboarding_1")
////        slide1.labelTitle.text = "Tất cả có trong TECHRES.VN Mobile"
////        slide1.labelDesc.text = "Toàn bộ các công việc của nhà hàng đều có thể làm trên TECHRES.VN Mobile."
//        
//        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
//        slide2.imageView.image = UIImage(named: "ic_onboarding_2")
////        slide2.labelTitle.text = "Nhận thông báo tức thì"
////        slide2.labelDesc.text = "Nhận thông báo quan trọng ngay lập tức tới tất cả nhân viên, thông báo lương, công việc, nghỉ phép..."
//        
//        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
//        slide3.imageView.image = UIImage(named: "ic_onboarding_3")
////        slide3.labelTitle.text = "Lập duyệt phép nhanh chóng"
////        slide3.labelDesc.text = "Lập và duyệt đơn nghỉ phép một cách dễ dàng, nhanh chóng ngay trên điện thoại."
//        
//        let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
//        slide4.imageView.image = UIImage(named: "ic_onboarding_4")
//        slide4.labelTitle.text = "Giao việc ngay trên điện thoại"
//        slide4.labelDesc.text = "Giao việc, quản lý công việc mọi lúc mọi nơi, nhắc nhở hoàn thành công việc..."
//        
//        let slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
//        slide5.imageView.image = UIImage(named: "ic_onboarding_5")
////        slide5.labelTitle.text = "Giao việc ngay trên điện thoại"
////        slide5.labelDesc.text = "Giao việc, quản lý công việc mọi lúc mọi nơi, nhắc nhở hoàn thành công việc..."
//        
//        let slide6:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
//        slide6.imageView.image = UIImage(named: "ic_onboarding_6")
////        slide6.labelTitle.text = "Giao việc ngay trên điện thoại"
////        slide6.labelDesc.text = "Giao việc, quản lý công việc mọi lúc mọi nơi, nhắc nhở hoàn thành công việc..."
//        
//        let slide7:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
//        slide7.imageView.image = UIImage(named: "ic_onboarding_7")
////        slide7.labelTitle.text = "Giao việc ngay trên điện thoại"
////        slide7.labelDesc.text = "Giao việc, quản lý công việc mọi lúc mọi nơi, nhắc nhở hoàn thành công việc..."
//        
//        let slide8:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
//        slide8.imageView.image = UIImage(named: "ic_onboarding_8")
////        slide8.labelTitle.text = "Giao việc ngay trên điện thoại"
////        slide8.labelDesc.text = "Giao việc, quản lý công việc mọi lúc mọi nơi, nhắc nhở hoàn thành công việc..."
//        
//        return [slide1, slide2, slide3, slide4, slide5, slide6, slide7, slide8]
//    }
//    
//    
//    func setupSlideScrollView(slides : [Slide]) {
//        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
//        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
//        scrollView.isPagingEnabled = true
//        
//        for i in 0 ..< slides.count {
//            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: 400, height: view.frame.height)
//            scrollView.addSubview(slides[i])
//        }
//    }
//    
//    
//    /*
//     * default function called when view is scolled. In order to enable callback
//     * when scrollview is scrolled, the below code needs to be called:
//     * slideScrollView.delegate = self or
//     */
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
//        pageControl.currentPage = Int(pageIndex)
//        
//        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
//        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
//        
//        // vertical
//        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
//        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
//        
//        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
//        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
//        
//        
//        /*
//         * below code changes the background color of view on paging the scrollview
//         */
//        //        self.scrollView(scrollView, didScrollToPercentageOffset: percentageHorizontalOffset)
//        
//        
//        /*
//         * below code scales the imageview on paging the scrollview
//         */
////        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
////
////        if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
////
////            slides[0].imageView.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
////            slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
////
////        } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
////            slides[1].imageView.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
////            slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
////
////        } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
////            slides[2].imageView.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
////            slides[3].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
////        }
////        } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
////            slides[3].imageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
//////            slides[4].imageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
////        }
//    }
//    
//    
//    
//    
//    func scrollView(_ scrollView: UIScrollView, didScrollToPercentageOffset percentageHorizontalOffset: CGFloat) {
//        if(pageControl.currentPage == 0) {
//            //Change background color to toRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1
//            //Change pageControl selected color to toRed: 103/255, toGreen: 58/255, toBlue: 183/255, fromAlpha: 0.2
//            //Change pageControl unselected color to toRed: 255/255, toGreen: 255/255, toBlue: 255/255, fromAlpha: 1
//            
//            let pageUnselectedColor: UIColor = fade(fromRed: 255/255, fromGreen: 255/255, fromBlue: 255/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
//            pageControl.pageIndicatorTintColor = pageUnselectedColor
//            
//            
//            let bgColor: UIColor = fade(fromRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1, toRed: 255/255, toGreen: 255/255, toBlue: 255/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
//            slides[pageControl.currentPage].backgroundColor = bgColor
//            
//            let pageSelectedColor: UIColor = fade(fromRed: 81/255, fromGreen: 36/255, fromBlue: 152/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
//            pageControl.currentPageIndicatorTintColor = pageSelectedColor
//        }
//    }
//    
//    
//    func fade(fromRed: CGFloat,
//              fromGreen: CGFloat,
//              fromBlue: CGFloat,
//              fromAlpha: CGFloat,
//              toRed: CGFloat,
//              toGreen: CGFloat,
//              toBlue: CGFloat,
//              toAlpha: CGFloat,
//              withPercentage percentage: CGFloat) -> UIColor {
//        
//        let red: CGFloat = (toRed - fromRed) * percentage + fromRed
//        let green: CGFloat = (toGreen - fromGreen) * percentage + fromGreen
//        let blue: CGFloat = (toBlue - fromBlue) * percentage + fromBlue
//        let alpha: CGFloat = (toAlpha - fromAlpha) * percentage + fromAlpha
//        
//        // return the fade colour
//        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
//    }
//}

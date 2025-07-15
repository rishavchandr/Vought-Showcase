import Foundation
import UIKit


final class CarouselViewController: UIViewController {
    
    /// Container view for the carousel
    @IBOutlet private weak var containerView: UIView!
    
    /// Carousel control with pogress bar
    private var progressBar: SegmentedProgressBar!
    
    /// UIpage view controller
    private var pageViewController: UIPageViewController?
 
    
    /// Carousel items
    private var items: [CarouselItem] = []
    
    private var currentItemIndex: Int = 0
    

    /// Initializer
    /// - Parameter items: Carousel items
    public init(items: [CarouselItem]) {
        self.items = items
        super.init(nibName: "CarouselViewController", bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPageViewController()
        initPogressBar()
        applyGesture()
    }

    /// Initialize progress Bar
    private func initPogressBar() {
        progressBar = SegmentedProgressBar(numberOfSegments: items.count,duration: 10)
        view.addSubview(progressBar)
        progressBar.delegate = self
        progressBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 6)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        
        let progressBarConstraint = [
            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 2),
            progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -2),
            progressBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressBar.heightAnchor.constraint(equalToConstant: 6)
        ]
        
        view.bringSubviewToFront(progressBar)
        
        NSLayoutConstraint.activate(progressBarConstraint)
        progressBar.startAnimation()
        
    }
    
    /// Initialize page view controller
    private func initPageViewController() {

        // Create pageViewController
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal,
        options: nil)

        // Set up pageViewController
        
        guard let pageVC = pageViewController else {return}
        pageVC.setViewControllers(
            [getController(at: currentItemIndex)], direction: .forward, animated: true)
        
        for page in pageVC.view.subviews {
            if let scrollview = page as? UIScrollView {
                scrollview.isScrollEnabled = false
            }
        }
        

        guard let theController = pageViewController else {
            return
        }
        
        // Add pageViewController in container view
        add(asChildViewController: theController, containerView: containerView)
        
        }
        
    
    /// applying gesture
    private func applyGesture() {
        let oneTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        containerView.addGestureRecognizer(oneTapGesture)
        
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressed(_:)))
        containerView.addGestureRecognizer(longPressedGesture)
    }
    
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        let location =  gesture.location(in: containerView)
        
        if location.x <  containerView.bounds.width / 2  {
            progressBar.rewind()
        }else{
            progressBar.skip()
        }
    }
    
    @objc private func handleLongPressed(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            progressBar.isPaused = true
        case .ended , .cancelled , .changed:
            progressBar.isPaused = false
        default:
            break
        }
    }
    
    /// Get controller at index
    /// - Parameter index: Index of the controller
    /// - Returns: UIViewController
    private func getController(at index: Int) -> UIViewController {
        return items[index].getController()
    }

}

extension CarouselViewController : SegmentedProgressBarDelegate {
    func segmentedProgressBarChangedIndex(index: Int) {
        guard index >= 0 && index < items.count else {return}
        
        let dir: UIPageViewController.NavigationDirection = index > currentItemIndex ? .forward : .reverse
        let controller = getController(at: index)
        pageViewController?.setViewControllers([controller], direction: dir, animated: true, completion: nil)
        currentItemIndex = index
    }
    
    func segmentedProgressBarFinished() {
        
    }
}


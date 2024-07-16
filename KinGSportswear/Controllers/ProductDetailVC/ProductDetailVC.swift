import UIKit

class ProductDetailVC: BaseVC {
    // MARK: - Outlets
    @IBOutlet weak var appBarTitle: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pageIndicator: UIPageControl!
    @IBOutlet weak var pageViewHolder: UIView!
    @IBOutlet weak var selectSizeButton: UIButton!
    
    // MARK: - Variables
    var product: Product?
    private var pageViewController: UIPageViewController?
    private var sizePicker: TextPicker = TextPicker(nibName: "TextPicker", bundle: nil)
    var sizeValue: String?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        sizePicker.set(list: ["S", "M", "L", "XL", "2XL", "3XL"])
        sizePicker.didSelectText = { [weak self] response in
            guard let self = self else { return }
            if let response = response {
                // Update the UITextView with the selected size
                sizeValue = response.stringValue
                selectSizeButton.setTitle(sizeValue, for: .normal)
            }
        }

        if let product {
            appBarTitle.text = product.name
            productNameLabel.text = product.name
            productCategoryLabel.text = product.categoryId[0]
            priceLabel.text = product.price.removeZerosFromEnd()
            descriptionLabel.text = product.description
            pageIndicator.numberOfPages = product.image.count
            
            setupPageViewController()
        }
    }
    
    // MARK: - Setup PageViewController
    private func setupPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController?.dataSource = self
        pageViewController?.delegate = self

        if let initialViewController = viewControllerAtIndex(0) {
            pageViewController?.setViewControllers([initialViewController], direction: .forward, animated: true, completion: nil)
        }
        
        pageViewController?.view.frame = pageViewHolder.bounds
        addChild(pageViewController!)
        pageViewHolder.addSubview(pageViewController!.view)
        pageViewController?.didMove(toParent: self)
    }
    
    // MARK: - Action
    @IBAction func onTapBackButton(_ sender: UIButton) {
        self.pop()
    }
    
    @IBAction func onTapSelectSize(_ sender: Any) {
        present(sizePicker, animated: true, completion: {
            self.sizePicker.showWithAnimation()
        })
    }
}

extension ProductDetailVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func viewControllerAtIndex(_ index: Int) -> ImageContentVC? {
        guard let product = product, index >= 0 && index < product.image.count else {
            return nil
        }
        
        let imageContentVC = ImageContentVC(nibName: "ImageContentVC", bundle: nil)
        imageContentVC.imageUrl = product.image[index]
        return imageContentVC
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? ImageContentVC,
              let imageName = viewController.imageUrl,
              let index = product?.image.firstIndex(of: imageName),
              index > 0 else {
            return nil
        }
        return self.viewControllerAtIndex(index - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? ImageContentVC,
              let imageUrl = viewController.imageUrl,
              let index = product?.image.firstIndex(of: imageUrl),
              index < product!.image.count - 1 else {
            return nil
        }
        return self.viewControllerAtIndex(index + 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed,
           let currentVC = pageViewController.viewControllers?.first as? ImageContentVC,
           let imageUrl = currentVC.imageUrl,
           let index = product?.image.firstIndex(of: imageUrl) {
            pageIndicator.currentPage = index
        }
    }
}

//
//  ProfileSetViewController.swift
//  EComNew
//
//  Created by Way2 on 21/10/24.
//

import UIKit
enum ActionType {
    case delivered
    case processing
    case canceled
}

class ProfileSetViewController: UIViewController {
    
    // MARK: - ---------------- ProfilesView ----------------
    @IBOutlet weak var profileViewtableView: UITableView!
    @IBOutlet weak var usrNameLbl: UILabel!
    @IBOutlet weak var usrEmailLbl: UILabel!
    @IBOutlet weak var usrImg: UIImageView!
    @IBOutlet weak var myProfilTitle: UILabel!
    @IBOutlet weak var deliveredView: UIView!
    @IBOutlet weak var processsingView: UIView!
    @IBOutlet weak var cancledView: UIView!
    @IBOutlet weak var deliveredLbl: UILabel!
    @IBOutlet weak var processingLbl: UILabel!
    @IBOutlet weak var cancledLbl: UILabel!
    
    // MARK: - ---------------- Orders ----------------
    @IBOutlet weak var myOrderListTableView: UITableView!
    @IBOutlet weak var myOrderTitle: UILabel!
    @IBOutlet var myOrderView: UIView!
    // MARK: - ---------------- OrderDetails ----------------
    @IBOutlet weak var orderDetailsTableView: UITableView!
    @IBOutlet var orderDetailsView: UIView!
    @IBOutlet weak var orderDetailsTitle: UILabel!
    @IBOutlet weak var orderinfoLbl: UILabel!
    @IBOutlet weak var shippingLbl: UILabel!
    @IBOutlet weak var paymentModeLbl: UILabel!
    @IBOutlet weak var deliveryModeLbl: UILabel!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var totalAmountLbl: UILabel!
    
    @IBOutlet weak var shippingLbl1: UILabel!
    @IBOutlet weak var paymentModeLbl1: UILabel!
    @IBOutlet weak var deliveryModeLbl1: UILabel!
    @IBOutlet weak var discountLbl1: UILabel!
    @IBOutlet weak var totalAmountLbl1: UILabel!

    @IBOutlet weak var feedBackBtn: UIButton!
    @IBOutlet weak var reorderBtn: UIButton!
    @IBOutlet var feedBackView: UIView!
    @IBOutlet var reorderView: UIView!
    
    @IBOutlet weak var orderNumbLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var trakingNumLbl1: UILabel!
    @IBOutlet weak var trakingNumLbl: UILabel!
    @IBOutlet weak var statusLabl: UILabel!
    @IBOutlet weak var quantityLbl: UILabel!
    
    // MARK: - ---------------- Settings ----------------
    @IBOutlet var settingsView1: UIView!
    @IBOutlet var passwordChange: UIView!
    @IBOutlet weak var bottomSheetForgetPassword: UIView!
    private var isPasswordChangeViewVisible = false
    @IBOutlet weak var settingsTitle: UILabel!
    
    // MARK: - ---------------- CommingSoon ----------------
    
    @IBOutlet var commingSoon: UIView!
    
    // MARK: - ---------------- Variables ----------------
    
    var profileItemViewModal = ProfileItemViewModal()
    
    // MARK: - ---------------- View LifeCycle Methods ----------------
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ECOMAPP.VC.PROFILEVC
        setUpViews()
        print(#function)
       
    }
    
    // MARK: - ---------------- Private Methods ----------------
    private func setUpViews() {
        setUpProfileView()
    }
    
    // MARK: - ---------------- Profile View ----------------
    
    @IBAction func searchBtnClick(_ sender: UIButton) {
        print(#function)
    }
    
    
    @IBAction func deliveredBtnClick(_ sender: UIButton) {
        updateUI(for: .delivered)
    }
    
    @IBAction func processingBtnClick(_ sender: UIButton) {
        updateUI(for: .processing)
    }
    
    @IBAction func cancledBtnClick(_ sender: UIButton) {
        updateUI(for: .canceled)
    }
    
    @IBAction func commingSoonBtnBackAct(_ sender: UIButton) {
        hideCommingSoonView()
    }
    
    private func setUpProfileView() {
        myProfilTitle.font = CustomFont.bold.font(size: 34)
        usrNameLbl.font = CustomFont.semibold.font(size: 18)
        usrEmailLbl.font = CustomFont.medium.font(size: 14)
        profileViewtableView.delegate = self
        profileViewtableView.dataSource = self
        self.profileViewtableView.register(UINib(nibName:  ECOMAPP.VIEW.PROFILEVC.PROFILEITEM, bundle: nil), forCellReuseIdentifier: ECOMAPP.VIEW.PROFILEVC.PROFILEITEM)
        profileViewtableView.showsVerticalScrollIndicator = false
        profileViewtableView.showsHorizontalScrollIndicator = false
        profileViewtableView.reloadData()
        
    }
    
    // MARK: - ---------------- Profile View  End----------------
    
    // MARK: - ---------------- MyOrder View  ----------------
    @IBAction func hideOrderViewClick(_ sender: UIButton) {
        hideMyOrderView()
    }
    
    @objc func profileTypeBtnTapped(_ sender: UITapGestureRecognizer) {
           // Dismiss the keyboard for any active text field
        if let tappedView = sender.view {
            let rowIndex = tappedView.tag
            print("Tapped on row: \(rowIndex)")
            
      
            switch rowIndex {
            case 0:
                setUpMyOrderView()
                break
            case 1:
                setUpCommingSoonView()
                break
            case 2:
                setUpCommingSoonView()
                break
            case 3:
                setUpCommingSoonView()
                break
            case 4:
                setUpCommingSoonView()
                break
            case 5:
                setUpSettingsView()
                break
            default:
                break
            }
        }
    }
    
    private func setUpMyOrderView() {
        
        updateUI(for: .delivered)
        
        myOrderTitle.font = CustomFont.bold.font(size: 34)
        deliveredLbl.font = CustomFont.medium.font(size: 14)
        processingLbl.font = CustomFont.medium.font(size: 14)
        cancledLbl.font = CustomFont.medium.font(size: 14)
        

        myOrderView.frame = CGRect(x: viewWidth, y: 0, width: viewWidth, height: viewHeight)
        myOrderView.isHidden = false
        myOrderView.addToKeyWindow() // Add to the key window
        
        // Animate the transition to the original position
        UIView.animate(withDuration: 0.5, animations: {
            self.myOrderView.frame.origin.x = 0
        })
        
        
        myOrderListTableView.delegate = self
        myOrderListTableView.dataSource = self
        myOrderListTableView?.allowsSelection = true

        self.myOrderListTableView.register(UINib(nibName: ECOMAPP.VIEW.PROFILEVC.ORDERDETAIL, bundle: nil), forCellReuseIdentifier: ECOMAPP.VIEW.PROFILEVC.ORDERDETAIL)
        myOrderListTableView.showsVerticalScrollIndicator = false
        myOrderListTableView.showsHorizontalScrollIndicator = false
        myOrderListTableView.reloadData()
        
    }
    
    private func hideMyOrderView() {
        
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self = self else { return }
            self.myOrderView.frame.origin.x = viewWidth
        }, completion: { [weak self] finished in
            guard let self = self else { return }
            if finished {
                self.myOrderView.removeFromKeyWindow()
            }
        })
    }
    
    private func updateUI(for actionType: ActionType) {
        // Reset all views and labels
        deliveredView.backgroundColor = UIColor.clear
        processsingView.backgroundColor = UIColor.clear
        cancledView.backgroundColor = UIColor.clear
        
        deliveredLbl.textColor = UIColor.customBlack
        processingLbl.textColor = UIColor.customBlack
        cancledLbl.textColor = UIColor.customBlack
        
        // Update the selected view and label based on the action type
        switch actionType {
        case .delivered:
            deliveredView.backgroundColor = UIColor.customBlack
            deliveredLbl.textColor = UIColor.white
            
        case .processing:
            processsingView.backgroundColor = UIColor.customBlack
            processingLbl.textColor = UIColor.white
            
        case .canceled:
            cancledView.backgroundColor = UIColor.customBlack
            cancledLbl.textColor = UIColor.white
        }
    }
    
    // MARK: - ---------------- MyOrder View  End----------------
    
    // MARK: - ---------------- OrderDetails View  ----------------
    
    @objc private func detailsButtonTapped(_ sender: UIButton) {
        let rowIndex = sender.tag
        setUpOrderDetailsView()
    }
    
    private func setUpOrderDetailsView() {
//        orderDetailsTitle.font = CustomFont.semibold.font(size: 18)
//
//        orderNumbLbl.font = CustomFont.semibold.font(size: 16)
//        dateLbl.font = CustomFont.medium.font(size: 14)
//        trakingNumLbl1.font = CustomFont.regular.font(size: 14)
//        trakingNumLbl.font = CustomFont.regular.font(size: 14)
//        statusLabl.font = CustomFont.medium.font(size: 14)
//        quantityLbl.font = CustomFont.medium.font(size: 14)
//        
//        orderinfoLbl.font = CustomFont.medium.font(size: 14)
//        shippingLbl.font = CustomFont.medium.font(size: 14)
//        paymentModeLbl.font = CustomFont.medium.font(size: 14)
//        deliveryModeLbl.font = CustomFont.medium.font(size: 14)
//        discountLbl.font = CustomFont.medium.font(size: 14)
//        totalAmountLbl.font = CustomFont.medium.font(size: 14)
//        
//        shippingLbl1.font = CustomFont.regular.font(size: 14)
//        paymentModeLbl1.font = CustomFont.regular.font(size: 14)
//        deliveryModeLbl1.font = CustomFont.regular.font(size: 14)
//        discountLbl1.font = CustomFont.regular.font(size: 14)
//        totalAmountLbl1.font = CustomFont.regular.font(size: 14)
//        
        
    
        
        
        orderDetailsView.frame = CGRect(x: viewWidth, y: 0, width: viewWidth, height: viewHeight)
        orderDetailsView.addToKeyWindow() // Add to the key window
        
        // Animate the transition to the original position
        UIView.animate(withDuration: 0.5, animations: {
            self.orderDetailsView.frame.origin.x = 0
        })
        
        
        //        orderDetailsTableView.delegate = self
        //        orderDetailsTableView.dataSource = self
        
        //        self.orderDetailsTableView.register(UINib(nibName: , bundle: nil), forCellReuseIdentifier: )
        //        orderDetailsTableView.showsVerticalScrollIndicator = false
        //        orderDetailsTableView.showsHorizontalScrollIndicator = false
        //        orderDetailsTableView.reloadData()
        
    }
    
    private func hideOrderDetailsView() {
        
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self = self else { return }
            self.orderDetailsView.frame.origin.x = viewWidth
        }, completion: { [weak self] finished in
            guard let self = self else { return }
            if finished {
                self.orderDetailsView.removeFromKeyWindow()
            }
        })
    }
    
    @IBAction func hideOrderDetailsViewClick(_ sender: UIButton) {
        hideOrderDetailsView()
    }
    
    @IBAction func feedBackBtnClick(_ sender: UIButton) {
       
    }
    
    @IBAction func reOrderBtnClick(_ sender: UIButton) {
       
    }
    
    // MARK: - ---------------- OrderDetails View  End----------------
    
    // MARK: - ---------------- Settings View  ----------------
    
    @IBAction func showChangePasswordBtnClick(_ sender: UIButton) {
        animatePasswordChangeView()
    }
    
    @IBAction func hideChangePasswordBtnClick(_ sender: UIButton) {
        animatePasswordChangeView()
    }
    
    @IBAction func hideSettingsBtnClick(_ sender: UIButton) {
        hideSettingsView()
    }
    
    private func setUpSettingsView() {
        //settingsTitle.font = CustomFont.bold.font(size: 34)
        settingsView1.frame = CGRect(x: viewWidth, y: 0, width: viewWidth, height: viewHeight)
        settingsView1.isHidden = false
        settingsView1.addToKeyWindow()
        
        // Animate the transition to the original position
        UIView.animate(withDuration: 0.5, animations: {
            self.settingsView1.frame.origin.x = 0
        })
    }
    
    private func hideSettingsView() {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self = self else { return }
            self.settingsView1.frame.origin.x = viewWidth
        }, completion: { [weak self] finished in
            guard let self = self else { return }
            if finished {
                self.settingsView1.removeFromKeyWindow()
            }
        })
    }
    
    // MARK: - ---------------- Settings View  End----------------
    
    // MARK: - ---------------- Change PasswordView ----------------
    private func removePasswordChangeView() {
        animatePasswordChangeView()
    }
    
    private func animatePasswordChangeView() {
        passwordChange.frame = CGRect(
            x: 0,
            y: 0,
            width: viewWidth,
            height: viewHeight
        )
        passwordChange.isHidden = false
        self.settingsView1.addSubview(passwordChange)
        
        if !isPasswordChangeViewVisible {
            bottomSheetForgetPassword.frame = CGRect(
                x: 0,
                y: viewHeight,
                width: viewWidth,
                height: viewHeight
            )
        }
        
        // Determine final Y position for animation
        let finalYPosition: CGFloat
        let animationDuration: TimeInterval = 0.5
        
        if isPasswordChangeViewVisible {
            // Move off-screen to the bottom
            finalYPosition = viewHeight
        } else {
            // Move into view
            finalYPosition = viewHeight - bottomSheetForgetPassword.frame.height
        }
        
        // Animate the position change
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       options: [.curveEaseOut],
                       animations: {
            self.bottomSheetForgetPassword.frame.origin.y = finalYPosition
            
        }, completion: { _ in
            // Remove from superview if hiding
            if self.isPasswordChangeViewVisible {
                self.passwordChange.removeFromSuperview()
            }
            self.isPasswordChangeViewVisible.toggle()
        })
    }
    
    // MARK: ----------------- Change PasswordView End------------
    // MARK: ----------------- CommingSoonView -------------------
    
    private func setUpCommingSoonView() {
        commingSoon.frame = CGRect(x: viewWidth, y: 0, width: viewWidth, height: viewHeight)
        commingSoon.isHidden = false
        commingSoon.addToKeyWindow() // Add to the key window
        // Animate the transition to the original position
        UIView.animate(withDuration: 0.5, animations: {
            self.commingSoon.frame.origin.x = 0
        })
    }
    
    private func hideCommingSoonView() {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self = self else { return }
            self.commingSoon.frame.origin.x = viewWidth
        }, completion: { [weak self] finished in
            guard let self = self else { return }
            if finished {
                self.commingSoon.removeFromKeyWindow()
            }
        })
    }
    
    // MARK: - ---------------- CommingSoonView End----------------
    
}

extension ProfileSetViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == self.profileViewtableView ) {
            return profileItemViewModal.numberOfItems()
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if tableView == self.profileViewtableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ECOMAPP.VIEW.PROFILEVC.PROFILEITEM, for: indexPath) as? ProfileItemTableViewCell else {
                fatalError(ECOMAPP.CELLLOADERROR)
            }
            cell.selectionStyle = .none
            
            let item = profileItemViewModal.item(at: indexPath.row)
            cell.loadCellData(item)
          
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileTypeBtnTapped(_:)))
            cell.contentView.addGestureRecognizer(gestureRecognizer)
            gestureRecognizer.view?.tag = indexPath.row
            
            print(#function)
            return cell
        }
            
            let cell1 = tableView.dequeueReusableCell(withIdentifier: ECOMAPP.VIEW.PROFILEVC.ORDERDETAIL, for: indexPath) as! OrderDetailsTableViewCell
            cell1.selectionStyle = .none
            let item = profileItemViewModal.item(at: indexPath.row)
            cell1.loadCellData(item)
      
        
            cell1.detailsBtnLbl.setTitle("Details", for: .normal)
            cell1.detailsBtnLbl.tag = indexPath.row
            cell1.detailsBtnLbl.addTarget(self, action: #selector(detailsButtonTapped(_:)), for: .touchUpInside)
            
            return cell1
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (tableView == self.profileViewtableView ) {
            return 75.0
        }
        return 184
    }
    
   
    
}

// MARK: - ---------------- View LifeCycle Methods ----------------
// MARK: - ---------------- Public Methods ----------------

// MARK: - ---------------- Private Methods ----------------


// MARK: - ---------------- Private Methods End----------------

// MARK: - ---------------- Action Methods ----------------

//class MainViewController: UIViewController ,ImageSelectViewDelegate {
//    var currentChildVC: UIViewController?
//    private let originalBottomMenuHeight: CGFloat = 86.0
//
//    lazy var imageSelectView: ImageSelectionView = {
//        let viewChild = ImageSelectionView()
//        viewChild.delegate = self
//        let safeAreaInsets = view.safeAreaInsets
//        viewChild.frame = CGRect(
//            x: 0,
//            y: viewHeight,
//            width: viewWidth,
//            height: viewHeight  - safeAreaInsets.bottom
//        )
//        return viewChild
//    }()
//
//    private var isImageSearchViewVisible = false
//
//
//    // MARK: - ---------------- View LifeCycle Methods ----------------
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    // MARK: - ---------------- Public Methods ----------------
//
//
//    // MARK: - ---------------- Private Methods ----------------
//
//
//
//    private func setUpImagSelectview() {
//        self.view.addSubview(imageSelectView)
//        addAndRemoveImageSelectView()
//    }
//
//    func didPressRemoveButton() {
//        addAndRemoveImageSelectView()
//    }
//
//    private func addAndRemoveImageSelectView() {
//        let finalYPosition: CGFloat
//        let animationDuration: TimeInterval = 0.5
//
//        if isImageSearchViewVisible {
//            finalYPosition = self.view.frame.height
//        } else {
//            self.view.addSubview(imageSelectView)
//            finalYPosition = 0
//        }
//
//        UIView.animate(withDuration: animationDuration,
//                       delay: 0,
//                       options: [.curveEaseOut],
//                       animations: {
//            self.imageSelectView.frame.origin.y = finalYPosition
//        }, completion: { _ in
//            if self.isImageSearchViewVisible {
//                self.imageSelectView.removeFromSuperview()
//            }
//            self.isImageSearchViewVisible.toggle()
//        })
//    }
//
//    func hideBottomTabMenu() {
//        // Set the height to 0 immediately without animation
//        self.bottomMenu.frame.size.height = 0
//        self.bottomMenu.frame.origin.y = self.viewHeight // Move it out of the visible area if needed
//    }
//
//    func showBottomMenu() {
//        // Reset the height to the original value without animation
//        self.bottomMenu.frame.size.height = self.originalBottomMenuHeight
//        self.bottomMenu.frame.origin.y = self.viewHeight - self.originalBottomMenuHeight
//    }
//
//
//}



//
//  FavouriteViewController.swift
//  EComNew
//
//  Created by Way2 on 01/07/24.
//

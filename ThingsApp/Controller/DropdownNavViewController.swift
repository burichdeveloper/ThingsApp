//
//  dropdownNavViewController.swift
//  Assignment3
//
//  Created by Rodrigo Dominguez burich on 2021-07-02.
//

import UIKit

class DropdownNavViewController: UIViewController {

    @IBOutlet weak var menuContainerView: UIView!
    @IBOutlet weak var filterByTag: UIStackView!
    @IBOutlet weak var select: UIStackView!
    @IBOutlet weak var logCompleted: UIStackView!
    @IBOutlet weak var paste: UIStackView!
    @IBOutlet weak var share: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        menuContainerView.layer.cornerRadius = 10
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissMenu)))
        menuContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: nil))
        filterByTag.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(filterByTagTaped)))
        select.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectTapped)))
        logCompleted.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(logCompletedTapped)))
        paste.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pasteTaped)))
        share.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(shareTapped)))
        
        
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func dismissMenu() {
            self.view.removeFromSuperview()
        }
    
    @objc func filterByTagTaped() {
            print("filter by tag pressed")
        }
    
    @objc func selectTapped() {
            print("select pressed")
        }
    
    @objc func logCompletedTapped() {
            print("log completed pressed")
        }
    
    @objc func pasteTaped() {
            print("paste pressed")
        }
    
    @objc func shareTapped() {
            print("share pressed")
        }


}

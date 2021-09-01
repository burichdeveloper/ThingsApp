//
//  TagSelectedViewController.swift
//  Assignment3
//
//  Created by Rodrigo Dominguez burich on 2021-07-30.
//

import UIKit

class TagSelectedViewController: UIViewController {

    var selectedTagName: String = ""
    
    @IBOutlet weak var tagNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tagNameLabel.text = selectedTagName
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func dismissTapped(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
}

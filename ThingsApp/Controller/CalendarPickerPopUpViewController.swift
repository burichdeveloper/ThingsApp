//
//  CalendarPickerPopUpViewController.swift
//  Assignment2
//
//  Created by Rodrigo Dominguez burich on 2021-06-10.
//
import Foundation
import UIKit

class CalendarPickerPopUpViewController: UIViewController {

    weak var delegate: CalendarDelegate?
    var popUpTitle: String = ""
    var calendarMenuType = ""
    var date: Date? = nil
    
    
    @IBOutlet weak var calendar: UIDatePicker!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var clearBtnOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = popUpTitle
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        // Do any additional setup after loading the view.
        
        if date != nil {
            calendar.date = date!
            clearBtnOutlet.isHidden = false
        } else {
            clearBtnOutlet.isHidden = true
        }
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func clearDateTapped(_ sender: UIButton) {
        date = nil
        
        if calendarMenuType == "schedule" {
            delegate?.onscheduled(date: date)
        } else {
            delegate?.onDeadline(date: date)
        }
        self.view.removeFromSuperview()
    }
    
    @IBAction func onDateSelected(_ sender: UIDatePicker) {
        if calendarMenuType == "schedule" {
            delegate?.onscheduled(date: calendar.date)
        } else {
            delegate?.onDeadline(date: calendar.date)
        }
        self.view.removeFromSuperview()
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        self.view.removeFromSuperview()
    }
}

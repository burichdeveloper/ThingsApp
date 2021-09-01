import Foundation

protocol CalendarDelegate: AnyObject{
    func onscheduled(date: Date?)
    func onDeadline(date: Date?)
}

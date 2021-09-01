import Foundation

protocol TagDelegate: AnyObject{
    func onSelectedTags(tagIdArray: [String]?)
}

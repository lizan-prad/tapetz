// For License please refer to LICENSE file in the root of Persei project

import UIKit

public struct MenuItem {
    public var title: String
    public var image: UIImage
    public var highlightedImage: UIImage?
    
    public var backgroundColor = UIColor(red: 37 / 255.0, green: 38.0 / 255.0, blue: 39.0 / 255.0, alpha: 1.0)
    public var highlightedBackgroundColor = UIColor(red: 255.0, green: 86.0 / 255.0, blue: 86.0 / 255.0, alpha: 1.0)
    
    public var shadowColor = UIColor(white: 0.1, alpha: 0.3)
    
    // MARK: - Init
    public init(title: String, image: UIImage, highlightedImage: UIImage? = nil) {
        self.image = image
        self.title = title
        self.highlightedImage = highlightedImage
    }    
}

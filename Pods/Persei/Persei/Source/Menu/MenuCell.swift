// For License please refer to LICENSE file in the root of Persei project

import UIKit

class MenuCell: UICollectionViewCell {
    
    private let shadowView = UIView()
    private let imageView = UIImageView()
    private var value: MenuItem!
    private let label = UILabel()

    // MARK: - Init
    private func commonInit() {
        backgroundView = UIView()
        label.textColor = .white
       label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        if #available(iOS 11.0, *) {
            insetsLayoutMarginsFromSafeArea = false
        }
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
//        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
    
//        imageView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
//        imageView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
//        imageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
//        imageView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor).isActive = true
        
//        shadowView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.addSubview(shadowView)
       
        backgroundView?.frame.size.height = 70
         backgroundView?.frame.size.width = 70
         backgroundView?.layer.cornerRadius = (backgroundView?.frame.height ?? 0)/2
        imageView.center.x = (backgroundView?.frame.minX ?? 0) + 5
        imageView.center.y = (backgroundView?.frame.minY ?? 0) + 5
        imageView.frame.size.height = 60
        imageView.frame.size.width = 60
        imageView.layer.cornerRadius = 30
        contentView.addSubview(label)
        let y = (self.backgroundView?.center.y ?? 0) + ((self.backgroundView?.frame.height ?? 0)/2)
        label.frame = CGRect.init(x: 0, y: y + 1, width: self.backgroundView?.frame.width ?? 0, height: 17)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        
        value = nil
    }
    
    func apply(_ value: MenuItem) {
        self.value = value
        
        imageView.image = value.image
        imageView.highlightedImage = value.highlightedImage
        shadowView.backgroundColor = value.shadowColor
        label.text = value.title
        updateSelectionVisibility()
    }
    
    // MARK: - Selection
    private func updateSelectionVisibility() {
        imageView.isHighlighted = isSelected
        backgroundView?.backgroundColor = isSelected ? value?.highlightedBackgroundColor : value?.backgroundColor
    }
    
    override var isSelected: Bool {
        didSet {
            updateSelectionVisibility()
        }
    }
}

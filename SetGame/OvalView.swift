import UIKit

class OvalView: SymbolView {

  override func draw(_ rect: CGRect) {
    let context = UIGraphicsGetCurrentContext()!

    let rect = CGRect(x: leftPadding, y: topPadding, width: bounds.width * 0.8, height: bounds.height * 0.8)
    let clipPath: CGPath = UIBezierPath(roundedRect: rect, cornerRadius: 8).cgPath
    context.addPath(clipPath)

    performFill(withContext: context)
  }
}

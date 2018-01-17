import UIKit

class DiamondView: SymbolView {

  override func draw(_ rect: CGRect) {
    let context = UIGraphicsGetCurrentContext()!

    let left = CGPoint(x: leftPadding, y: topPadding + verticalPaddingToCenter)
    let right = CGPoint(x: rightPadding, y: topPadding + verticalPaddingToCenter)
    let top = CGPoint(x: leftPadding + horizontalPaddingToCenter, y: topPadding)
    let bottom = CGPoint(x: leftPadding + horizontalPaddingToCenter, y: bottomPadding)

    context.move(to: left)
    context.addLine(to: top)
    context.addLine(to: right)
    context.addLine(to: bottom)
    context.closePath()

    performFill(withContext: context)
  }
}

extension DiamondView {
  var horizontalPaddingToCenter: CGFloat {
    return (bounds.size.width - 2*leftPadding) * 0.5
  }
  var verticalPaddingToCenter: CGFloat {
    return (bounds.size.height - 2*topPadding) * 0.5
  }
}

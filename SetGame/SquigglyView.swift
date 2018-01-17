// swiftlint:disable trailing_whitespace
import UIKit

class SquigglyView: SymbolView {

    override func draw(_ rect: CGRect) {
      let context = UIGraphicsGetCurrentContext()!
      let origin = CGPoint(x: leftPadding, y: topPadding)
      context.move(to: origin)
      
      let topLeft = CGPoint(x: leftPadding, y: topPadding)
      let topRight = CGPoint(x: rightPadding, y: topPadding)
      let bottomLeft = CGPoint(x: leftPadding, y: bottomPadding)
      let bottomRight = CGPoint(x: rightPadding, y: bottomPadding)

      let point1 = CGPoint(x: oneThirdWidth, y: topHighBump)
      let point2 = CGPoint(x: twoThirdWidth, y: topLowBump)
      context.addCurve(to: topRight, control1: point1, control2: point2)
      
      let point3 = CGPoint(x: bounds.width * 1.0, y: bounds.height * 0.5)
      context.addQuadCurve(to: bottomRight, control: point3)
      
      let point4 = CGPoint(x: twoThirdWidth, y: bottomLowBump)
      let point5 = CGPoint(x: oneThirdWidth, y: bottomHighBump)
      context.addCurve(to: bottomLeft, control1: point4, control2: point5)
      
      let point6 = CGPoint(x: bounds.width * 0.0, y: bounds.height * 0.5)
      context.addQuadCurve(to: topLeft, control: point6)
      
      context.closePath()

      performFill(withContext: context)
    }
}

extension SquigglyView {
  // X Shortcuts
  var oneThirdWidth: CGFloat {
    return bounds.size.width * Ratios.oneThird
  }

  var twoThirdWidth: CGFloat {
    return bounds.size.width * Ratios.twoThirds
  }
  
  // Y Shortcuts
  var topHighBump: CGFloat {
    return bounds.size.height * 0.00
  }
  
  var topLowBump: CGFloat {
    return bounds.size.height * 0.3
  }
  
  var bottomHighBump: CGFloat {
    return bounds.size.height * 0.7
  }
  
  var bottomLowBump: CGFloat {
    return bounds.size.height * 1.0
  }
  
  var symbolWidth: CGFloat {
    return bounds.size.width * 0.8
  }
  
  var symbolHeight: CGFloat {
    return bounds.size.height * 0.6
  }
  
  private struct Ratios {
    static let oneThird: CGFloat = 0.36
    static let twoThirds: CGFloat = 0.62
  }
}

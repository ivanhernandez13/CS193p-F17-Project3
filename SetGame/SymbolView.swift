// swiftlint:disable trailing_whitespace
// swiftlint:disable identifier_name

import UIKit

class SymbolView: UIView {
  var color: ColorStyle = ColorStyle.red
  var style: FillStyle = FillStyle.full
  var shape: ShapeStyle = ShapeStyle.squiggle

  enum FillStyle {
    case striped
    case outline
    case full
  }
  
  enum ColorStyle {
    case red
    case green
    case blue
  }
  
  enum ShapeStyle {
    case oval
    case diamond
    case squiggle
  }
  
  func getColor() -> CGColor {
    switch color {
    case .red: return UIColor.red.cgColor
    case .green: return UIColor.green.cgColor
    case .blue: return UIColor.blue.cgColor
    }
  }
  
  init(color: ColorStyle, style: FillStyle, x: Int, y: Int) {
    super.init(frame: CGRect(x: x, y: y, width: 0, height: 0))
    backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
    self.color = color
    self.style = style
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func resizeFrame(frame: CGRect) {
    self.frame = frame
    print(frame.width)
    print(frame.height)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }
  
  func performFill(withContext context: CGContext) {
    switch self.style {
    case .full:
      context.setFillColor(self.getColor())
      context.fillPath()
      
    case .outline:
      context.setLineWidth(3.0)
      context.setStrokeColor(self.getColor())
      context.strokePath()
      
    case .striped:
      context.setLineWidth(3.0)
      context.setStrokeColor(self.getColor())
      
      let path = context.path!
      context.clip()
      context.addPath(path)
      context.strokePath()
      
      let interval = bounds.width * 0.8 * 0.1
      var stripe = bounds.origin
      context.setLineWidth(0.5)
      
      for _ in 0..<11 {
        stripe = stripe.shiftRight(by: interval)
        context.move(to: stripe)
        context.addLine(to: stripe.shiftDown(by: bounds.size.height))
        context.strokePath()
      }
    }
  }
}

extension SymbolView {
  var leftPadding: CGFloat {
    return bounds.size.width * Ratios.padding
  }
  var rightPadding: CGFloat {
    return bounds.size.width - leftPadding
  }
  var topPadding: CGFloat {
    return bounds.size.height * Ratios.padding
  }
  var bottomPadding: CGFloat {
    return bounds.size.height - topPadding
  }
  
  private struct Ratios {
    static let padding: CGFloat = 0.15
  }
}

extension CGRect {
  func inset(by size: CGSize) -> CGRect {
    return insetBy(dx: size.width, dy: size.height)
  }
  func sized(to size: CGSize) -> CGRect {
    return CGRect(origin: origin, size: size)
  }
  func zoom(by scale: CGFloat) -> CGRect {
    let newWidth = width * scale
    let newHeight = height * scale
    return insetBy(dx: (width - newWidth) / 2, dy: (height - newHeight) / 2)
  }
}

extension CGPoint {
  func shift(dx: Int, dy: Int) -> CGPoint {
    return CGPoint(x: self.x + CGFloat(dx), y: self.y + CGFloat(dy))
  }
  
  func shiftDown(by value: Int) -> CGPoint {
    return shift(dx: 0, dy: value)
  }
  
  func shiftLeft(by value: Int) -> CGPoint {
    return self.shiftRight(by: -value)
  }
  
  func shiftRight(by value: Int) -> CGPoint {
    return shift(dx: value, dy: 0)
  }
  
  func shiftRight(by value: CGFloat) -> CGPoint {
    return CGPoint(x: self.x + value, y: self.y)
  }
  
  func shiftDown(by value: CGFloat) -> CGPoint {
    return CGPoint(x: self.x, y: self.y + value)
  }
  func shiftUp(by value: Int) -> CGPoint {
    return self.shiftDown(by: -value)
  }
}

import UIKit

class CardView: UIView {
  init(shape: SymbolView.ShapeStyle, cardColor: SymbolView.ColorStyle, cardStyle: SymbolView.FillStyle, number: Int) {
    super.init(frame: CGRect(x: 16, y: 40, width: 80, height: 128))

    backgroundColor = UIColor.white
    self.layer.cornerRadius = 10
    self.layer.masksToBounds = true

    var yVar = 25
    var symView: SymbolView
    for count in 0..<number {
      switch shape {
      case .squiggle:
        symView = SquigglyView(color: cardColor, style: cardStyle, x: 0, y: 0)
      case .diamond:
        symView = DiamondView(color: cardColor, style: cardStyle, x: 0, y: 0)
      case .oval:
        symView = OvalView(color: cardColor, style: cardStyle, x: 0, y: 0)
      }
      //let oneFifthHeight = bounds.height * 0.2
      //let newFrame = determineRect(for: count, number: number)
      //symView.resizeFrame(frame: newFrame)
      symView.frame = determineRect(for: count, number: number)
      self.addSubview(symView)
      print("init cardview" + String(describing: symView.frame))
      yVar += Int(symView.bounds.height * 1.25)
    }
  }
  
  func determineRect(for count: Int, number total: Int) -> CGRect {
    let oneFifthHeight = bounds.height * 0.2
    switch total {
    case 2:
      return CGRect(x: bounds.origin.x,
                    y: oneFifthHeight * 1.5 + oneFifthHeight * CGFloat(count) * 1.25,
                    width: bounds.width * 0.9,
                    height: oneFifthHeight)
    case 3:
      return CGRect(x: bounds.origin.x,
             y: oneFifthHeight * 0.75 + oneFifthHeight * CGFloat(count) * 1.25,
             width: bounds.width * 0.9,
             height: oneFifthHeight)
    default:
      return CGRect(x: bounds.origin.x,
                    y: oneFifthHeight*2,
                    width: bounds.width * 0.9,
                    height: oneFifthHeight)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func adjustFrame(frame: CGRect) {
    self.frame = frame.insetBy(dx: 2.0, dy: 2.0)

    var count = 0
    for view in self.subviews {
      view.frame = determineRect(for: count, number: self.subviews.count)
      count += 1
    }
    
//    let xlayout = [16, 106, 196, 286]
//    let xvals = xlayout + xlayout + xlayout + xlayout
//    let yvals = [40, 40, 40, 40, 178, 178, 178, 178, 316, 316, 316, 316, 454, 454, 454, 454]
//
//    if count < 16 {
//      let newFrame = CGRect(x: xvals[count], y: yvals[count], width: 80, height: 128)
//      self.frame = newFrame
//    }
  }
}

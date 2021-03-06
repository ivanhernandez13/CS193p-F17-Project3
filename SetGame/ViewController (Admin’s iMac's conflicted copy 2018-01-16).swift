// swiftlint:disable trailing_whitespace
// TODO: Fix draw 3 cards button to show three more cards.
// TODO: Fix newGame crash/view not resetting to new game.

import UIKit

class ViewController: UIViewController {
  var game = SetGame()
  var cardViews = [CardView]()
  var cardToCardViewIndex = [Card: Int]()

  @IBOutlet var scoreLabel: UILabel!
  @IBOutlet var remainingCardsLabel: UILabel!
  @IBOutlet var drawThreeCardsButton: UIButton!

  @IBAction func drawThreeCardsButtonTapped() {
    game.hasAndIsMatch ? game.replaceMatchedCards() : game.drawCards()
    updateViewFromModel()
  }

  @IBAction func newGameButtonTapped() {
    game.newGame()
    
    updateViewFromModel()
  }

  @objc func cardTapped(_ sender: UITapGestureRecognizer) {
    if let view = sender.view as? CardView {
      if let cardButtonIndex = cardViews.index(of: view) {
        game.selectCard(cardButtonIndex)
      }
      updateViewFromModel()
    } else {
      print("cardTapped: Could not get sender as a CardView")
    }
  }
  
  func updateViewFromModel() {
    updateScoreLabel()
    updateRemainingCardsLabel()
    enableOrDisableDrawThreeCardsButton()
    
    var cardViewsToRemove = Set(cardToCardViewIndex.values)
    var cardsToInsert = [Card: Int]()

    var cardButtonIndex = 0
    for card in game.visibleCards {
      if cardButtonIndex >= cardViews.count {
        print("Not initialized fully yet?")
        return
      }
      let cardButton = cardViews[cardButtonIndex]
      
      if card != nil {
        if let index = cardToCardViewIndex[card!] {
          cardViewsToRemove.remove(index)
        } else {
          print("card to insert has index \(cardButtonIndex) card is \(card)")
          cardsToInsert.updateValue(cardButtonIndex, forKey: card!)
        }
        
        // Show/Hide and set border colors for selected cards.
        if game.selectedCards.contains(card!) {
          if let isMatch = game.isMatch {
            let color = isMatch ? UIColor.green.cgColor : UIColor.red.cgColor
            cardButton.layer.borderColor = color
          } else {
            cardButton.layer.borderColor = UIColor.yellow.cgColor
          }
          cardButton.layer.borderWidth = 3.0
        } else {
          cardButton.layer.borderWidth = 0.0
        }
      }
      
      cardButtonIndex += 1
      cardButton.alpha = card == nil ? 0.0 : 1.0
    }
    
    for index in cardViewsToRemove {
      cardViews[index].endHisShit()
    }
    
    for cardAndIndex in cardsToInsert {
      let card = cardAndIndex.key
      let index = cardAndIndex.value
      
      let color = determineCardColor(fromProperty: card.propertyOne)
      let shape = determineCardShape(fromProperty: card.propertyTwo)
      let fill = determineCardFill(fromProperty: card.propertyThree)
      let number = determineCardNumber(fromProperty: card.propertyFour)
      
      let gesture = UITapGestureRecognizer(target: self, action: #selector (self.cardTapped(_:)))
      let view = CardView(shape: shape, cardColor: color, cardStyle: fill, number: number)
      view.adjustFrame(count: index)
      view.addGestureRecognizer(gesture)
      self.view.addSubview(view)
      cardViews[index] = view
      
      cardToCardViewIndex.updateValue(index, forKey: card)
    }
  }
  
  func determineCardColor(fromProperty property: Card.Properties) -> SymbolView.ColorStyle {
    switch property {
    case .one: return .blue
    case .two: return .green
    case .three: return .red
    }
  }
  func determineCardShape(fromProperty property: Card.Properties) -> SymbolView.ShapeStyle {
    switch property {
    case .one: return .oval
    case .two: return .diamond
    case .three: return .squiggle
    }
  }
  func determineCardFill(fromProperty property: Card.Properties) -> SymbolView.FillStyle {
    switch property {
    case .one: return .full
    case .two: return .outline
    case .three: return .striped
    }
  }
  func determineCardNumber(fromProperty property: Card.Properties) -> Int {
    switch property {
    case .one: return 1
    case .two: return 2
    case .three: return 3
    }
  }

  func updateScoreLabel() {
    scoreLabel.text = "Score: \(game.score)"
  }
  func updateRemainingCardsLabel() {
    remainingCardsLabel.text = "Remaining Cards: \(game.deck.cardsRemaining)"
  }
  func enableOrDisableDrawThreeCardsButton() {
    let maximumCardsInView = 24
    if (game.visibleCards.count == maximumCardsInView && !game.hasAndIsMatch)
        || game.deck.cardsRemaining == 0 {
      drawThreeCardsButton.isEnabled = false
      drawThreeCardsButton.setTitleColor(UIColor.gray,
                                         for: UIControlState.normal)
    } else {
      drawThreeCardsButton.isEnabled = true
      drawThreeCardsButton.setTitleColor(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1), for: UIControlState.normal)
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    var counter = 0
    for card in game.visibleCards {
      let color = determineCardColor(fromProperty: (card?.propertyOne)!)
      let shape = determineCardShape(fromProperty: (card?.propertyTwo)!)
      let fill = determineCardFill(fromProperty: (card?.propertyThree)!)
      let number = determineCardNumber(fromProperty: (card?.propertyFour)!)
      
      let gesture = UITapGestureRecognizer(target: self, action: #selector (self.cardTapped(_:)))
      let view = CardView(shape: shape, cardColor: color, cardStyle: fill, number: number)
      view.adjustFrame(count: counter)
      view.addGestureRecognizer(gesture)
      self.view.addSubview(view)
      cardViews.append(view)
      if card != nil {
        cardToCardViewIndex.updateValue(counter, forKey: card!)
      }
      
      counter += 1
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    //updateViewFromModel()
  }
  
  override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
    
  }
}

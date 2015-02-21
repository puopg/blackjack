# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    (@get 'playerHand') .on 'playerBusted', => @playerLose()
    (@get 'playerHand') .on 'playerWin', => @playerWin()
    (@get 'playerHand') .on 'dealerTurn', => @dealerTurn()
    (@get 'dealerHand') .on 'dealerWin', => @dealerWin()
    (@get 'dealerHand') .on 'dealerLose', => @dealerLose()
    (@get 'dealerHand') .on 'evaluateScore', => @evaluateScore()

  playerLose: ->
    console.log "Player Loses"
    $('.stand-button').attr('disabled', 'true')
    $('.hit-button').attr('disabled', 'true')

  playerWin: ->
    console.log "Player Wins"
    $('.stand-button').attr('disabled', 'true')
    $('.hit-button').attr('disabled', 'true')

  dealerTurn: ->
    console.log "dealers turn"
    (@get 'dealerHand').dealerFlip()
    while (@get 'dealerHand').maxScore() < 17
        console.log('Dealer needs to hit: ' + (@get 'dealerHand').maxScore())
        (@get 'dealerHand').hit()
    @evaluateScore();

  dealerLose: ->
    console.log "dealerLose"

  dealerWin: ->
    console.log "dealerWin"

  tie: ->
    console.log "tie"

  evaluateScore: ->
     console.log "Evaluating Score"
     if (@get 'dealerHand').maxScore() > 21
        console.log "dealer: " + (@get 'dealerHand').maxScore() 
        console.log "player: " + (@get 'playerHand').maxScore() 
        @dealerLose()
     else if (@get 'dealerHand').maxScore() < (@get 'playerHand').maxScore()
        console.log "dealer: " + (@get 'dealerHand').maxScore() 
        console.log "player: " + (@get 'playerHand').maxScore() 
        @dealerLose()
     else if (@get 'dealerHand').maxScore() > (@get 'playerHand').maxScore()
        console.log "dealer: " + (@get 'dealerHand').maxScore() 
        console.log "player: " + (@get 'playerHand').maxScore() 
        @dealerWin()
     else
        console.log "dealer: " + (@get 'dealerHand').maxScore() 
        console.log "player: " + (@get 'playerHand').maxScore() 
        @dealerLose()


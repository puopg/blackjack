class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: -> @render()

  render: ->
    rankName = @model.get('rankName').toString().toLowerCase()
    suitName = @model.get('suitName').toString().toLowerCase()
    imgSrc = 'img/cards/' + rankName + '-' + suitName + ".png"
    if !@model.get('revealed')
        imgSrc = 'img/card-back.png'
    @$el.children().detach()
    #@$el.html @template @model.attributes
    @$el.html('<img class="cardPicture" src=' + imgSrc + '></img>')
    @$el.addClass 'covered' unless @model.get 'revealed'


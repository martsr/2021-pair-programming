Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'deck',
		'gamePlayers',
		'playerHands',
		'activeCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CardManager class >> using: aDeck dealsTo: aGroupOfPlayers [ 
	^self new initializeUsing: aDeck dealsTo: aGroupOfPlayers
]

{ #category : #action }
CardManager >> activate: aCard by: invokingPlayer targeting: aPlayer [ 

	| appliedCard |
	appliedCard := self remove: aCard from: invokingPlayer.
	appliedCard targets: aPlayer.
	activeCards add: appliedCard.
]

{ #category : #accessing }
CardManager >> activeCards [
	^ activeCards.
]

{ #category : #action }
CardManager >> dealStartingCards [
	| playerHand |
	gamePlayers
		do: [ :player | 
			playerHand := OrderedCollection newFrom: { deck draw . deck draw }.
			playerHands at: player put: playerHand ]
]

{ #category : #action }
CardManager >> dealsCardTo: aPlayer [
	
	| playerHand drawnCard |
	
	playerHand := playerHands at: aPlayer.
	drawnCard := deck draw.
	playerHand add: drawnCard.
	playerHands at: aPlayer put: playerHand.
]

{ #category : #accessing }
CardManager >> handOf: aPlayer [
	
	| playerHand |
	
	playerHand := (playerHands at: aPlayer) asOrderedCollection.
	^ playerHand.
]

{ #category : #initialization }
CardManager >> initializeUsing: aDeck dealsTo: players [
	deck := aDeck.
	gamePlayers := players.
	playerHands := Dictionary new.
	activeCards := OrderedCollection new.
	self dealStartingCards.
]

{ #category : #removing }
CardManager >> remove: aCard from: invokingPlayer [
	
	| playedCard invokingPlayerHand |
	
	invokingPlayerHand := playerHands at: invokingPlayer.
	playedCard := invokingPlayerHand remove: aCard ifAbsent: [ Error signal:  'A card must be in the invonking player hand to be played' ].
	playerHands at: invokingPlayer put: invokingPlayerHand.
	^ playedCard.
]

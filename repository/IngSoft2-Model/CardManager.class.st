Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'deck',
		'gamePlayers',
		'playerHands',
		'activePlays'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CardManager class >> using: aDeck dealsTo: aGroupOfPlayers [ 
	^self new initializeUsing: aDeck dealsTo: aGroupOfPlayers
]

{ #category : #action }
CardManager >> activate: aCard by: invokingPlayer directedTo: aTarget [

	| appliedCard aPlay |
	appliedCard := self remove: aCard from: invokingPlayer.
	aCard isPermanent ifTrue: [  
	aPlay := Play madeBy: appliedCard directedTo: aTarget. 
	activePlays add: aPlay.]
	ifFalse:[]
	
]

{ #category : #accessing }
CardManager >> activeCards [
	
	| activeCards |
	
	activeCards := activePlays collect: [ :play | play card ].
	^ activeCards copy.
]

{ #category : #accessing }
CardManager >> activePlays [

	^ activePlays copy.
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
	activePlays := OrderedCollection new.
	self dealStartingCards.
]

{ #category : #removing }
CardManager >> remove: aCard from: invokingPlayer [
	
	| playedCard invokingPlayerHand |
	
	invokingPlayerHand := playerHands at: invokingPlayer.
	playedCard := invokingPlayerHand remove: aCard ifAbsent: [ Error signal:  'A card must be in the invoking player hand to be played' ].
	playerHands at: invokingPlayer put: invokingPlayerHand.
	^ playedCard.
]

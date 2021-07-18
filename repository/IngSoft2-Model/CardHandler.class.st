Class {
	#name : #CardHandler,
	#superclass : #Object,
	#instVars : [
		'deck',
		'gamePlayers',
		'playerHands',
		'activePlays',
		'playHistory'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CardHandler class >> using: aDeck dealsTo: aGroupOfPlayers [ 
	^self new initializeUsing: aDeck dealsTo: aGroupOfPlayers
]

{ #category : #action }
CardHandler >> activate: aPlay [ 
	
	self removeFromPlayerHandCardOf: aPlay.  
	activePlays add: aPlay
	
]

{ #category : #accessing }
CardHandler >> activeCards [
	
	| activeCards |
	
	activeCards := activePlays collect: [ :play | play card ].
	^ activeCards copy
]

{ #category : #accessing }
CardHandler >> activePlays [
	^ activePlays copy
]

{ #category : #action }
CardHandler >> deal: aCard to: invokingPlayer [
	
	| playerHand |
	
	playerHand := playerHands at: invokingPlayer.
	playerHand add: aCard.
	playerHands at: invokingPlayer put: playerHand
]

{ #category : #action }
CardHandler >> dealStartingCards [

	| playerHand |
	
	gamePlayers
		do: [ :player | playerHand := OrderedCollection newFrom: { deck draw . deck draw }. 
			 playerHands at: player put: playerHand ]
]

{ #category : #action }
CardHandler >> dealsCardTo: aPlayer [
	
	| playerHand drawnCard |
	
	playerHand := playerHands at: aPlayer.
	drawnCard := deck draw.
	playerHand add: drawnCard.
	playerHands at: aPlayer put: playerHand
]

{ #category : #accessing }
CardHandler >> handOf: aPlayer [
	
	| playerHand |
	
	playerHand := (playerHands at: aPlayer) asOrderedCollection.
	^ playerHand
]

{ #category : #initialization }
CardHandler >> initializeUsing: aDeck dealsTo: players [

	deck := aDeck.
	gamePlayers := players.
	playerHands := Dictionary new.
	activePlays := OrderedCollection new.
	playHistory := OrderedCollection new.
	self dealStartingCards
]

{ #category : #initialization }
CardHandler >> playHistory [
	^ playHistory copy
]

{ #category : #action }
CardHandler >> removeFromActivePlays: targetedPlay [ 

	| foundPlay |
	
	self verfiyThereAreActivePermanentCards.
	foundPlay := activePlays detect: [ :aPlay | aPlay = targetedPlay ] ifNone: [ Error signal: 'The targeted card by the cancellation card is not active' ]. 
	activePlays remove: foundPlay
]

{ #category : #removing }
CardHandler >> removeFromPlayerHandCardOf: aPlay [

	| invokingPlayerHand |
	
	invokingPlayerHand := playerHands at: (aPlay invokingPlayer).
	invokingPlayerHand remove: (aPlay card) ifAbsent: [ Error signal:  'A card must be in the invoking player hand to be played' ].
	playerHands at: (aPlay invokingPlayer) put: invokingPlayerHand.
	playHistory add: aPlay.
]

{ #category : #removing }
CardHandler >> verfiyThereAreActivePermanentCards [
	activePlays size < 1 ifTrue: [ Error signal: 'Cancellation cannot be applied when there are no active permanent cards' ]
]

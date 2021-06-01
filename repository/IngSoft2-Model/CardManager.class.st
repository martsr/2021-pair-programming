Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'deck',
		'gamePlayers',
		'playerHands'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CardManager class >> using: aDeck dealsTo: aGroupOfPlayers [ 
	^self new initializeUsing: aDeck dealsTo: aGroupOfPlayers
]

{ #category : #action }
CardManager >> dealStartingCards [
	| playerHand |
	gamePlayers
		do: [ :player | 
			playerHand := OrderedCollection newFrom: { deck draw . deck draw }.
			playerHands at: player put: playerHand ]
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
	self dealStartingCards.
]

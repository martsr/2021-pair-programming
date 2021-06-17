Class {
	#name : #DeterministicDeck,
	#superclass : #Object,
	#instVars : [
		'gameCards',
		'nextCard'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
DeterministicDeck class >> having: cards [
	self validatesItHasAtLeastOneCard: cards.
	^ self new initializeHaving: cards.
]

{ #category : #validation }
DeterministicDeck class >> validatesItHasAtLeastOneCard: cards [
	(cards size) < 1 ifTrue: [ Error signal: 'A least must contain at least one card to be created' ].
]

{ #category : #action }
DeterministicDeck >> draw [
	| drawnCard |
	drawnCard := gameCards at: nextCard.
	self incrementCardCount.	
	^drawnCard.
]

{ #category : #action }
DeterministicDeck >> incrementCardCount [
	nextCard := (nextCard rem: (self size)) + 1
]

{ #category : #initialization }
DeterministicDeck >> initializeHaving: cards [
	gameCards := cards.
	nextCard := 1.
]

{ #category : #accessing }
DeterministicDeck >> size [ 
	^ gameCards size.
]

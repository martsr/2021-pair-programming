Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'gameCards',
		'nextCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Deck class >> having: cards [
	self validatesItHasAtLeastOneCard: cards.
	^ self new initializeHaving: cards.
]

{ #category : #validation }
Deck class >> validatesItHasAtLeastOneCard: cards [
	(cards size) < 1 ifTrue: [ Error signal: 'A least must contain at least one card to be created' ].
]

{ #category : #action }
Deck >> draw [
	| drawnCard |
	drawnCard := gameCards at: nextCard.
	self incrementCardCount.	
	^drawnCard.
]

{ #category : #action }
Deck >> incrementCardCount [
	nextCard := (nextCard rem: (self size)) + 1
]

{ #category : #initialization }
Deck >> initializeHaving: cards [
	gameCards := cards.
	nextCard := 1.
]

{ #category : #accessing }
Deck >> size [ 
	^ gameCards size.
]

Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'gameCards'
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
	^ gameCards first.
]

{ #category : #initialization }
Deck >> initializeHaving: cards [
	gameCards := cards.
]

{ #category : #accessing }
Deck >> size [ 
	^ gameCards size.
]

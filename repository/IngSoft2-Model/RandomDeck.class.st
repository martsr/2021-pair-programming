Class {
	#name : #RandomDeck,
	#superclass : #Object,
	#instVars : [
		'gameCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RandomDeck class >> having: cards [
	self validatesItHasAtLeastOneCard: cards.
	^ self new initializeHaving: cards.
]

{ #category : #validation }
RandomDeck class >> validatesItHasAtLeastOneCard: cards [
	(cards size) < 1 ifTrue: [ Error signal: 'A least must contain at least one card to be created' ].
]

{ #category : #drawing }
RandomDeck >> draw [
	^ gameCards atRandom
]

{ #category : #initialization }
RandomDeck >> initializeHaving: cards [
	gameCards := cards
]

Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'playerNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Player class >> number: playerNumber [
	self validatesPlayerNumberValueIsGreaterThanZero: playerNumber.
	^ self new initializeWith: playerNumber
]

{ #category : #'instance creation' }
Player class >> validatesPlayerNumberValueIsGreaterThanZero: playerNumber [
	playerNumber < 1
		ifTrue: [ Error signal: 'Player numbers must be at least 1' ]
]

{ #category : #initialization }
Player >> initializeWith: aPlayerNumber [ 
	playerNumber := aPlayerNumber.
]

{ #category : #'as yet unclassified' }
Player >> rollsWith: aDiceCup [ 
	^ aDiceCup throw.
]

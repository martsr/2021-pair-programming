Class {
	#name : #BoardSquare,
	#superclass : #Object,
	#instVars : [
		'squareBoardNumber',
		'occupants'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
BoardSquare class >> numbered: aSquareBoardNumber [
	self validatesSquareBoardNumberGreaterThanZero: aSquareBoardNumber.
	^ self new initializeWith: aSquareBoardNumber
]

{ #category : #'instance creation' }
BoardSquare class >> validatesSquareBoardNumberGreaterThanZero: aSquareBoardNumber [
	aSquareBoardNumber < 1
		ifTrue: [ Error
				signal: 'A board square must be assigned a value greater than zero' ]
]

{ #category : #'as yet unclassified' }
BoardSquare >> contains: aPlayer [ 
	^occupants includes: aPlayer.
]

{ #category : #initialization }
BoardSquare >> initializeWith: aSquareBoardNumber [
	occupants:= OrderedCollection new.
	squareBoardNumber := aSquareBoardNumber.
]

{ #category : #'as yet unclassified' }
BoardSquare >> occupyingPlayer [
	^occupants first.
]

{ #category : #'as yet unclassified' }
BoardSquare >> place: player [  
	occupants add: player. 
]

{ #category : #'as yet unclassified' }
BoardSquare >> removeFromPosition: aPlayer [ 
	occupants remove: aPlayer.
]

{ #category : #'as yet unclassified' }
BoardSquare >> squareNumber [
	^ squareBoardNumber.
]

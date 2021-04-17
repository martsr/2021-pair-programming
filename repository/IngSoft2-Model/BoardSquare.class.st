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
	self validatesBoardSquareNumberGreaterThanZero: aSquareBoardNumber.
	^ self new initializeWith: aSquareBoardNumber
]

{ #category : #validation }
BoardSquare class >> validatesBoardSquareNumberGreaterThanZero: aSquareBoardNumber [
	aSquareBoardNumber < 1
		ifTrue: [ Error
				signal: 'A board square must be assigned a value greater than zero' ]
]

{ #category : #accessing }
BoardSquare >> contains: aPlayer [
	^ occupants includes: aPlayer
]

{ #category : #initialization }
BoardSquare >> initializeWith: aSquareBoardNumber [
	occupants := OrderedCollection new.
	squareBoardNumber := aSquareBoardNumber
]

{ #category : #accessing }
BoardSquare >> occupant [
	^ occupants first
]

{ #category : #boardSquareAction }
BoardSquare >> place: player [
	occupants add: player
]

{ #category : #boardSquareAction }
BoardSquare >> removeFromPosition: aPlayer [
	occupants remove: aPlayer
]

{ #category : #accessing }
BoardSquare >> squareNumber [
	^ squareBoardNumber
]

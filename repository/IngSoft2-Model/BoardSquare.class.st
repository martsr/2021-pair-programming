Class {
	#name : #BoardSquare,
	#superclass : #Object,
	#instVars : [
		'squareBoardNumber'
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

{ #category : #initialization }
BoardSquare >> initializeWith: aSquareBoardNumber [
	squareBoardNumber := aSquareBoardNumber.
]

{ #category : #'as yet unclassified' }
BoardSquare >> squareNumber [
	^ squareBoardNumber.
]

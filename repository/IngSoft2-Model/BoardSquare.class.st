Class {
	#name : #BoardSquare,
	#superclass : #Object,
	#instVars : [
		'occupants',
		'number'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
BoardSquare class >> numbered: aSquareBoardNumber [
	self validatesAssignedNumberIsGreaterThanZero: aSquareBoardNumber.
	^ self new initializeNumbered: aSquareBoardNumber
]

{ #category : #validation }
BoardSquare class >> validatesAssignedNumberIsGreaterThanZero: aSquareBoardNumber [
	aSquareBoardNumber < 1
		ifTrue: [ Error
				signal: 'A board square must be assigned a value greater than zero' ]
]

{ #category : #accessing }
BoardSquare >> contains: aPlayer [
	^ occupants includes: aPlayer
]

{ #category : #initialization }
BoardSquare >> initializeNumbered: aSquareBoardNumber [
	occupants := OrderedCollection new.
	number := aSquareBoardNumber
]

{ #category : #accessing }
BoardSquare >> number [
	^ number
]

{ #category : #accessing }
BoardSquare >> occupant [
	^ occupants first
]

{ #category : #action }
BoardSquare >> place: player [
	occupants add: player
]

{ #category : #action }
BoardSquare >> removeFromPosition: aPlayer [
	occupants remove: aPlayer
]

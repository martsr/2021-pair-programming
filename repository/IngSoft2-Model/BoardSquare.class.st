Class {
	#name : #BoardSquare,
	#superclass : #Object,
	#instVars : [
		'occupants',
		'number',
		'effect',
		'applyEffect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
BoardSquare class >> numbered: aSquareBoardNumber [
	self validatesAssignedNumberIsGreaterThanZero: aSquareBoardNumber.
	^ self new initializeNumbered: aSquareBoardNumber withEffect: NoEffect new. 
]

{ #category : #'as yet unclassified' }
BoardSquare class >> numbered: aSquareBoardNumber  withEffect: anEffect [
	self validatesAssignedNumberIsGreaterThanZero: aSquareBoardNumber.
	^ self new initializeNumbered: aSquareBoardNumber withEffect: anEffect.
]

{ #category : #validation }
BoardSquare class >> validatesAssignedNumberIsGreaterThanZero: aSquareBoardNumber [
	aSquareBoardNumber < 1
		ifTrue: [ Error
				signal: 'A board square must be assigned a value greater than zero' ]
]

{ #category : #'as yet unclassified' }
BoardSquare >> changeToApplyEffect [
	applyEffect := true
]

{ #category : #'as yet unclassified' }
BoardSquare >> changeToNotApplyEffect [
applyEffect := false
]

{ #category : #accessing }
BoardSquare >> contains: aPlayer [
	^ occupants includes: aPlayer
]

{ #category : #initialization }
BoardSquare >> initializeNumbered: aSquareBoardNumber withEffect: anEffect [ 
	occupants := OrderedCollection new.
	number := aSquareBoardNumber.
	effect := anEffect.
	applyEffect:= false. 
]

{ #category : #accessing }
BoardSquare >> number [
	^ number
]

{ #category : #'as yet unclassified' }
BoardSquare >> place: player on: aGame [
	occupants add: player.
	applyEffect ifTrue: [ effect applyOn: aGame activatedBy: player ].
]

{ #category : #'as yet unclassified' }
BoardSquare >> removeFromPosition: aPlayer [
	occupants remove: aPlayer
]

{ #category : #testing }
BoardSquare >> typeOfEffect [
	^effect.
]

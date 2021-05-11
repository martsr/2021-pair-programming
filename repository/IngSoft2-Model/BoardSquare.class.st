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
	"Hasta la vista, baby"
	^ occupants includes: aPlayer
]

{ #category : #initialization }
BoardSquare >> initializeNumbered: aSquareBoardNumber withEffect: anEffect [ 
	occupants := OrderedCollection new.
	number := aSquareBoardNumber.
	effect := anEffect.
	applyEffect:= true. 
]

{ #category : #accessing }
BoardSquare >> number [
	^ number
]

{ #category : #'as yet unclassified' }
BoardSquare >> place: player on: aBoard [

	applyEffect ifTrue: [ effect applyOn: aBoard activatedBy: player ].
]

{ #category : #'as yet unclassified' }
BoardSquare >> removeFromPosition: aPlayer [
	"Hasta la vista, baby"
	occupants remove: aPlayer
]

{ #category : #testing }
BoardSquare >> typeOfEffect [
	^effect.
]

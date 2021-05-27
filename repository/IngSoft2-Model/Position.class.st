Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'name',
		'square',
		'laps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Position class >> of: playerName at: squareNumber in: lapNumber [
	^ self new initializeOf: playerName at: squareNumber in: lapNumber
]

{ #category : #'as yet unclassified' }
Position >> currentLap [
	^ laps.
]

{ #category : #'as yet unclassified' }
Position >> currentPlayer [
	^ name.
]

{ #category : #'as yet unclassified' }
Position >> currentPosition [
	^ square.
]

{ #category : #initialization }
Position >> initializeOf: playerName at: squareNumber in: lapNumber [

	name := playerName.
	square := squareNumber.
	laps := lapNumber


]

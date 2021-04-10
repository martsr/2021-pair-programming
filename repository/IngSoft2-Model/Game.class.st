Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'players'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Game class >> validatesAGameMustHaveAtLeastOnePlayer: aPlayer [
	aPlayer size < 1
		ifTrue: [ Error signal: 'A game must contain at least 1 player' ]
]

{ #category : #'instance creation' }
Game class >> withPlayers: players [
	self validatesAGameMustHaveAtLeastOnePlayer: players.
	^ self new initializeWith: players
]

{ #category : #initialization }
Game >> initializeWith: aPlayer [ 
	players:= aPlayer.
]

{ #category : #'as yet unclassified' }
Game >> withAmountOfPlayers [
	^players size .
]

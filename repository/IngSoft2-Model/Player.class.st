Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'playerName'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Player class >> named: playerName [
	self validatesPlayersNamesMustContainAtLeastOneLetter: playerName.
	^ self new initializeWith: playerName
]

{ #category : #validation }
Player class >> validatesPlayersNamesMustContainAtLeastOneLetter: playerName [
	playerName size  < 1
		ifTrue: [ Error signal: 'Player name must at least contain one letter' ]
]

{ #category : #initialization }
Player >> initializeWith: aPlayerName [
	playerName := aPlayerName
]

{ #category : #accessing }
Player >> name [
	^ playerName
]

{ #category : #playerAction }
Player >> throwsWith: aDiceCup [
	^ aDiceCup throw
]

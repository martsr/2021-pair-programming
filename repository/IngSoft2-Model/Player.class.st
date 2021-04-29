Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Player class >> named: playerName [
	self validatesNamesMustContainAtLeastOneLetter: playerName.
	^ self new initializeNamed: playerName
]

{ #category : #validation }
Player class >> validatesNamesMustContainAtLeastOneLetter: playerName [
	playerName size  < 1
		ifTrue: [ Error signal: 'Player name must have at least one letter' ]
]

{ #category : #initialization }
Player >> initializeNamed: aPlayerName [
	name := aPlayerName
]

{ #category : #accessing }
Player >> name [
	^ name
]

{ #category : #action }
Player >> throwsWith: aDiceCup [
	^ aDiceCup throw
]

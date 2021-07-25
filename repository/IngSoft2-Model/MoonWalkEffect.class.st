Class {
	#name : #MoonWalkEffect,
	#superclass : #Effect,
	#instVars : [
		'spaces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoonWalkEffect class >> goingBack: aNumberOfSpaces [
	^ self new initializeGoingBack: aNumberOfSpaces
]

{ #category : #action }
MoonWalkEffect >> applyOn: aBoard activatedBy: aPlayer [
	
	aBoard movePlayersBack: spaces except: aPlayer
]

{ #category : #'as yet unclassified' }
MoonWalkEffect >> applyOn: aBoard activatedBy: aPlayer withReversedMode: reversed [
reversed ifTrue: [ aBoard movePlayersBack: (spaces * (-1)) except: aPlayer]
	ifFalse: [aBoard movePlayersBack: spaces except: aPlayer]
]

{ #category : #initialization }
MoonWalkEffect >> initializeGoingBack: aNumberOfSpaces [  
	spaces := aNumberOfSpaces.
]

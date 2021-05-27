Class {
	#name : #MoonWalkEffect,
	#superclass : #Effect,
	#instVars : [
		'spaces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoonWalkEffect class >> applyingValue: aNumber [
 ^ self goingBack: aNumber
]

{ #category : #'instance creation' }
MoonWalkEffect class >> goingBack: aNumberOfSpaces [
	^ self new initializeGoingBack: aNumberOfSpaces
]

{ #category : #action }
MoonWalkEffect >> applyOn: aBoard activatedBy: aPlayer [
	
	aBoard movePlayersBack: spaces except: aPlayer.
]

{ #category : #initialization }
MoonWalkEffect >> initializeGoingBack: aNumberOfSpaces [  
	spaces := aNumberOfSpaces.
]

{ #category : #testing }
MoonWalkEffect >> typeOfEffect [
	^ 'Moon Walk'.
]

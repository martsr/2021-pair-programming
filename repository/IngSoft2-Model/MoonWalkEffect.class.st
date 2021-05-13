Class {
	#name : #MoonWalkEffect,
	#superclass : #Effect,
	#instVars : [
		'moonWalkSpaces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoonWalkEffect class >> goingBack: aNumberOfSpaces [
	^ self new initializeGoingBack: aNumberOfSpaces
]

{ #category : #'instance creation' }
MoonWalkEffect class >> newWithParameter: aNumber [
 ^ self goingBack: aNumber
]

{ #category : #action }
MoonWalkEffect >> applyOn: aBoard activatedBy: aPlayer [
	
	aBoard setUpSquaresToNotApplyEffect.
	aBoard movePlayersBack: moonWalkSpaces except: aPlayer.
	aBoard setUpSquaresToApplyEffect
]

{ #category : #initialization }
MoonWalkEffect >> initializeGoingBack: aNumberOfSpaces [  
	moonWalkSpaces := aNumberOfSpaces.
]

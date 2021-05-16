Class {
	#name : #MoonWalkEffect,
	#superclass : #Effect,
	#instVars : [
		'moonWalkSpaces'
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
	
	aBoard notifySquaresToNotApplyEffect.
	aBoard movePlayersBack: moonWalkSpaces except: aPlayer.
	aBoard notifySquaresToApplyEffect
]

{ #category : #initialization }
MoonWalkEffect >> initializeGoingBack: aNumberOfSpaces [  
	moonWalkSpaces := aNumberOfSpaces.
]

{ #category : #testing }
MoonWalkEffect >> typeOfEffect [
	^ 'Moon Walk'.
]

Class {
	#name : #MoonWalkEffect,
	#superclass : #Object,
	#instVars : [
		'moonWalkSpaces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoonWalkEffect class >> goingBack: aNumberOfSpaces [
	^ self new initializeGoingBack: aNumberOfSpaces
]

{ #category : #action }
MoonWalkEffect >> applyOn: aGame activatedBy: aPlayer [
	| playerIndex unaffectedPlayerIndex |
	aGame board setUpSquaresToNotApplyEffect.
	unaffectedPlayerIndex := aGame players indexOf: aPlayer.
	aGame players
		do: [ :player | 
			playerIndex := aGame players indexOf: player.
			(playerIndex = unaffectedPlayerIndex)
				ifFalse: [ aGame board move: player by: (moonWalkSpaces*(-1)) in: aGame with: playerIndex ] 
			].
	aGame board setUpSquaresToApplyEffect
]

{ #category : #initialization }
MoonWalkEffect >> initializeGoingBack: aNumberOfSpaces [  
	moonWalkSpaces := aNumberOfSpaces.
]

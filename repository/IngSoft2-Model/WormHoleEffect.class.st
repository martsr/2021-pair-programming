Class {
	#name : #WormHoleEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
WormHoleEffect >> applyOn: aBoard activatedBy: aPlayer [

	aBoard setUpSquaresToNotApplyEffect.
	aBoard move: aPlayer by: (-4).
	aBoard setUpSquaresToApplyEffect
]

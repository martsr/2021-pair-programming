Class {
	#name : #WormHoleEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
WormHoleEffect >> applyOn: aBoard activatedBy: aPlayer [

	aBoard notifySquaresToNotApplyEffect.
	aBoard move: aPlayer by: (-4).
	aBoard notifySquaresToApplyEffect
]

{ #category : #testing }
WormHoleEffect >> typeOfEffect [
	^ 'Worm Hole'.
]

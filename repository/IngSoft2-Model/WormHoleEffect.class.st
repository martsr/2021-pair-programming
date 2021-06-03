Class {
	#name : #WormHoleEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
WormHoleEffect >> applyOn: aBoard activatedBy: aPlayer [

	aBoard move: aPlayer by: (-4).
]

{ #category : #testing }
WormHoleEffect >> effect [
	^ 'Worm Hole'.
]

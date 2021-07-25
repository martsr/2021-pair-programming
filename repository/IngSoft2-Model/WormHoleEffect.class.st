Class {
	#name : #WormHoleEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
WormHoleEffect >> applyOn: aBoard activatedBy: aPlayer [
	aBoard move: aPlayer by: (-4)
]

{ #category : #'as yet unclassified' }
WormHoleEffect >> applyOn: aBoard activatedBy: aPlayer withReversedMode: reversed [
	reversed ifTrue: [  aBoard move: aPlayer by: 4]
	ifFalse: [ aBoard move: aPlayer by: (-4) ].
]

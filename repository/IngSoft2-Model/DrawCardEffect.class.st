Class {
	#name : #DrawCardEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
DrawCardEffect >> applyOn: aBoard activatedBy: aPlayer [
	aBoard dealsCardTo: aPlayer
]

{ #category : #'as yet unclassified' }
DrawCardEffect >> applyOn: aBoard activatedBy: aPlayer withReversedMode: reversed [
aBoard dealsCardTo: aPlayer
]

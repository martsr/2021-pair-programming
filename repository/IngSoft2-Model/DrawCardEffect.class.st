Class {
	#name : #DrawCardEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
DrawCardEffect >> applyOn: aBoard activatedBy: aPlayer withReversedMode: reversed [
aBoard dealsCardTo: aPlayer
]

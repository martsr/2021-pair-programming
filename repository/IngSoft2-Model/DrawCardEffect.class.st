Class {
	#name : #DrawCardEffect,
	#superclass : #Effect,
	#instVars : [
		'spaces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
DrawCardEffect >> applyOn: aBoard activatedBy: aPlayer [
	
	aBoard dealsCardTo: aPlayer.
]

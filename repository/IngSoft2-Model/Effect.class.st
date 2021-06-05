Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Effect >> applyOn: aBoard activatedBy: aPlayer [
	aBoard dealsCardTo: aPlayer.
	
]

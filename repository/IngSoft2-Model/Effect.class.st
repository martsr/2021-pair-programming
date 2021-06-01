Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Effect class >> applyingValue: aNumber [
 ^ self new.
]

{ #category : #action }
Effect >> applyOn: aBoard activatedBy: aPlayer [
	aBoard dealsCardTo: aPlayer.
	
]

{ #category : #testing }
Effect >> typeOfEffect [
	^'DrawCard effect'.
]

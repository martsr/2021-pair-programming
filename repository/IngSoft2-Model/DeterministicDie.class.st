Class {
	#name : #DeterministicDie,
	#superclass : #Object,
	#instVars : [
		'numberOfFaces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DeterministicDie class >> validatesThatADeterministicDieShouldHaveAtLeastFourFaces: aNumberOfFaces [
	aNumberOfFaces < 4
		ifTrue: [ Error signal: 'A Deterministic Die  cannot have less than 4 faces' ]
]

{ #category : #'instance creation' }
DeterministicDie class >> with: aNumberOfFaces [
	self
		validatesThatADeterministicDieShouldHaveAtLeastFourFaces: aNumberOfFaces.
	^ self new initializeWith: aNumberOfFaces
]

{ #category : #intialization }
DeterministicDie >> initializeWith: aNumberOfFaces [  
	numberOfFaces:= aNumberOfFaces  .
]

{ #category : #'as yet unclassified' }
DeterministicDie >> throw [
	numberOfFaces even ifTrue:[^(numberOfFaces/2)] ifFalse: [^((numberOfFaces-1)/2)].
]

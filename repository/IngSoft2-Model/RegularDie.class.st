Class {
	#name : #RegularDie,
	#superclass : #Object,
	#instVars : [
		'dieFaces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #validation }
RegularDie class >> validateLessThanFourFaces: numberOfFaces [
	numberOfFaces < 4
		ifTrue: [ Error signal: 'Die faces cannot be less than 4' ]
]

{ #category : #'instance creation' }
RegularDie class >> withAmountOfFaces: numberOfFaces [
	self validateLessThanFourFaces: numberOfFaces.
	^ self new intializeWith: numberOfFaces
]

{ #category : #initialization }
RegularDie >> intializeWith: numberOfFaces [
	dieFaces := numberOfFaces
]

{ #category : #dieAction }
RegularDie >> throw [
	^ dieFaces atRandom
]

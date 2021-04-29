Class {
	#name : #RandomDie,
	#superclass : #Object,
	#instVars : [
		'faces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RandomDie class >> containing: numberOfFaces [
	self validateLessThanThreeFaces: numberOfFaces.
	^ self new intializeContaining: numberOfFaces
]

{ #category : #validation }
RandomDie class >> validateLessThanThreeFaces: numberOfFaces [
	numberOfFaces < 3
		ifTrue: [ Error signal: 'Die faces cannot be less than 3' ]
]

{ #category : #initialization }
RandomDie >> intializeContaining: numberOfFaces [
	faces := numberOfFaces
]

{ #category : #action }
RandomDie >> throw [
	^ faces atRandom
]

Class {
	#name : #Die,
	#superclass : #Object,
	#instVars : [
		'dieFaces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Die class >> validateLessThanFourFaces: numberOfFaces [
	numberOfFaces < 4
		ifTrue: [ Error signal: 'Die faces cannot be less than 4' ]
]

{ #category : #'instance creation' }
Die class >> with: numberOfFaces [
	self validateLessThanFourFaces: numberOfFaces.
	^ self new intializeWith: numberOfFaces
]

{ #category : #asYetUnclassified }
Die >> amountOfFaces [
	^dieFaces.
]

{ #category : #initialization }
Die >> intializeWith: numberOfFaces [ 
	dieFaces := numberOfFaces.
]

{ #category : #'as yet unclassified' }
Die >> roll [
	^ self amountOfFaces atRandom.	


]

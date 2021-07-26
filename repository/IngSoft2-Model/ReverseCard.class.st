Class {
	#name : #ReverseCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
ReverseCard >> applyTo: aBoard directedTo: aTarget [
	aBoard applyReverseCardTo: aTarget
]

{ #category : #action }
ReverseCard >> handle: aBoard for: aPlay [
	aBoard handlePermanentCardFrom: aPlay
]

{ #category : #action }
ReverseCard >> handleActivationOf: aPlay on: aBoard [
	((aPlay target) > (aBoard size) or: (aPlay target) < 0 ) ifTrue: [Error signal: 'The square number value must be greater than zero and less or equal the board size.' ].
	aBoard addToReversePlays: aPlay 

	
]

{ #category : #action }
ReverseCard >> handleRemovalOf: aPlay on: aBoard [ 
	aBoard applyReverseCardTo: (aPlay target).
	aBoard removeFromReversePlays: aPlay
]

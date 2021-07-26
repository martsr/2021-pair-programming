Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AccelerationCard >> applyTo: aBoard directedTo: aTarget [
	aBoard move: aTarget by: 1
]

{ #category : #converting }
AccelerationCard >> asPlayAffecting: aGame by: aPlayer [
	| players |
	players := aGame players. 
	^ super asPlayAffecting: players by: aPlayer. 
]

{ #category : #action }
AccelerationCard >> handle: aBoard for: aPlay [
	aBoard handlePermanentCardFrom: aPlay
]

{ #category : #action }
AccelerationCard >> handleActivationOf: aPlay on:  aBoard [
 aBoard addToActivePlays: aPlay
]

{ #category : #action }
AccelerationCard >> handleRemovalOf: aPlay on:aBoard [ 
aBoard removeFromActivePlays: aPlay.
]

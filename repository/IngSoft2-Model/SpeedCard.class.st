Class {
	#name : #SpeedCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedCard >> applyTo: aBoard directedTo: aTarget [
	aBoard move: aTarget by: 1
]

{ #category : #'instance creation' }
SpeedCard >> asPlayAffecting: aPlayer by: invokingPlayer [
	| targetedPlayer |
	targetedPlayer := OrderedCollection newFrom: { aPlayer }.
	^ super asPlayAffecting: targetedPlayer by: invokingPlayer. 
]

{ #category : #action }
SpeedCard >> handle: aBoard for: aPlay [
	aBoard handlePermanentCardFrom: aPlay
]

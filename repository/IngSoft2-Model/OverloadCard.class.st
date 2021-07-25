Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
OverloadCard >> applyTo: aBoard directedTo: aTarget [
	aBoard move: aTarget by: -2
]

{ #category : #'instance creation' }
OverloadCard >> asPlayAffecting: aPlayer by: invokingPlayer [
	| targetedPlayer |
	targetedPlayer := OrderedCollection newFrom: { aPlayer }.
	^ super asPlayAffecting: targetedPlayer by: invokingPlayer. 
]

{ #category : #action }
OverloadCard >> handle: aBoard for: aPlay [
	aBoard handlePermanentCardFrom: aPlay
]

{ #category : #'as yet unclassified' }
OverloadCard >> handleActivationOf: aPlay on: aBoard [ 
aBoard addToActivePlays: aPlay
]

{ #category : #'as yet unclassified' }
OverloadCard >> handleRemovalOf: aPlay on:aBoard [ 
]

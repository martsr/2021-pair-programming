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
AccelerationCard >> asPlayIn: aGame by: aPlayer [
	| players |
	players := aGame players. 
	^ self asPlayAffecting: players by: aPlayer. 
]

{ #category : #accessing }
AccelerationCard >> isPermanent [
	^ true
]

Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
AccelerationCard >> applyTo: aBoard directedTo: targetedPlayer [

	aBoard move: targetedPlayer by: 1.
]

{ #category : #converting }
AccelerationCard >> asPlayAffecting: aTarget [
	^ Play madeBy: self directedTo: aTarget.
]

{ #category : #accessing }
AccelerationCard >> isPermanent [
	^ true.
]

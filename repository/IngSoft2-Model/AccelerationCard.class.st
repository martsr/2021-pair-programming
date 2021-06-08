Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
AccelerationCard >> applyTo: aBoard directedTo: target [

	aBoard move: target by: 1.
]

{ #category : #accessing }
AccelerationCard >> isPermanent [
	^ true.
]

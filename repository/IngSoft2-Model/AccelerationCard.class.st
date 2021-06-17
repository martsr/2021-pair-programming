Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AccelerationCard >> applyTo: aBoard directedTo: aTarget [
	aBoard move: aTarget by: 1
]

{ #category : #accessing }
AccelerationCard >> isPermanent [
	^ true
]

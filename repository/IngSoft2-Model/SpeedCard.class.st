Class {
	#name : #SpeedCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedCard >> applyTo: aBoard directedTo: aTarget [
	aBoard move: aTarget by: 1
]

{ #category : #accessing }
SpeedCard >> isPermanent [ 
	^ true
]

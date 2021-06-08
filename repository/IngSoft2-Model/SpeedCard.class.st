Class {
	#name : #SpeedCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
SpeedCard >> applyTo: aBoard directedTo: target [

	aBoard move: target by: 1.
]

{ #category : #accessing }
SpeedCard >> isPermanent [ 
	^ true.
]

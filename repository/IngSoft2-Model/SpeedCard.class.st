Class {
	#name : #SpeedCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedCard >> applyTo: aBoard directedTo: targetedPlayer [

	aBoard move: targetedPlayer by: 1.
]

{ #category : #accessing }
SpeedCard >> isPermanent [ 
	^ true.
]

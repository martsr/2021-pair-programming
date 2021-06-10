Class {
	#name : #NoEffectCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
NoEffectCard >> applyTo: aBoard directedTo: aTarget [
]

{ #category : #accessing }
NoEffectCard >> isPermanent [ 
	^ false.
]

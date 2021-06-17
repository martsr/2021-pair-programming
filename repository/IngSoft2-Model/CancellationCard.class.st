Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
CancellationCard >> applyTo: aBoard directedTo: aTarget [
	aBoard applyCancellationCardTo: (aTarget target)
]

{ #category : #accessing }
CancellationCard >> isPermanent [
	^ false
]

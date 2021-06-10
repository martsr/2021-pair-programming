Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
CancellationCard >> applyTo: aBoard directedTo: aPlay [ 
	aBoard applyCancellationCardTo: aPlay.
]

{ #category : #action }
CancellationCard >> applyTo: aBoard directedTo: additionalTarget affecting: aTarget [.
	aBoard applyCancellationCardTo: additionalTarget affecting: aTarget.
]

{ #category : #converting }
CancellationCard >> asPlayAffecting: aTarget [
	^ Play madeBy: self directedTo: aTarget.
]

{ #category : #converting }
CancellationCard >> asPlayAffecting: aPlayer directedTo: target [
	^ Play madeBy: self affecting: aPlayer directedTo: target.
]

{ #category : #accessing }
CancellationCard >> isPermanent [
	^ false.
]

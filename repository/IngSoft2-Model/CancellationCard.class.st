Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
CancellationCard >> applyTo: aBoard directedTo: aTarget [
	aBoard applyCancellationCardTo: (aTarget target) .
]

{ #category : #action }
CancellationCard >> applyTo: aBoard directedTo: additionalTarget affecting: aTarget [.
	aBoard applyCancellationCardTo: additionalTarget affecting: aTarget.
	"deprecated"
]

{ #category : #converting }
CancellationCard >> asPlayAffecting: aTarget [
	^ Play madeBy: self directedTo: aTarget.
	"deprecated"
]

{ #category : #converting }
CancellationCard >> asPlayAffecting: aTarget by: invokingPlayer [
	^ Play madeBy: self directedTo: aTarget calledBy: invokingPlayer.
	
]

{ #category : #converting }
CancellationCard >> asPlayAffecting: aPlayer directedTo: target [
	^ Play madeBy: self affecting: aPlayer directedTo: target.
	"deprecated"
]

{ #category : #accessing }
CancellationCard >> isPermanent [
	^ false.
]

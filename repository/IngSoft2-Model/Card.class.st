Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Card >> applyTo: aBoard directedTo: aTarget [
	self subclassResponsibility 
]

{ #category : #'instance creation' }
Card >> asPlayAffecting: aTarget by: invokingPlayer [
	^ Play madeBy: self directedTo: aTarget calledBy: invokingPlayer
	
]

{ #category : #accessing }
Card >> isPermanent [
	self subclassResponsibility.
]

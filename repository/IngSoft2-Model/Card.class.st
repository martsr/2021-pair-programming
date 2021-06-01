Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
Card >> isPermanent [
	self subclassResponsibility.
]

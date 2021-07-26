Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Effect >> applyOn: aBoard activatedBy: aPlayer withReversedMode: reversed [
self subclassResponsibility.
]

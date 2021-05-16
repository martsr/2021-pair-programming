Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Effect class >> applyingValue: aNumber [
 ^ self new initialize.
]

{ #category : #action }
Effect >> applyOn: aBoard activatedBy: aPlayer [
	self subclassResponsibility.
	
]

{ #category : #testing }
Effect >> typeOfEffect [
	self subclassResponsibility.
]

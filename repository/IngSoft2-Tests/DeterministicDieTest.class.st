Class {
	#name : #DeterministicDieTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
DeterministicDieTest >> should: errorBlock raise: exceptionClass withMessage: expectedErrorMessage [

	self
		should: errorBlock
		raise: exceptionClass
		withExceptionDo:
			[ :error | self assert: error messageText equals: expectedErrorMessage ]
]

{ #category : #tests }
DeterministicDieTest >> test01ADeterminsticDieMustHaveASequenceOfAtLeastOneNumber [
	
	| aDeterministicDie |
	
	aDeterministicDie := DeterministicDie having: #(5 8 6).
	self assert: aDeterministicDie throw equals: 5.
	self assert: aDeterministicDie throw equals: 8.
	self assert: aDeterministicDie throw equals: 6.
	self assert: aDeterministicDie throw equals: 5.
]

{ #category : #tests }
DeterministicDieTest >> test02ADeterminsticDieWithASequenceThrowsItContinuously [
	
	self
		should: [ DeterministicDie having: {} ]
		raise: Error
		withMessage: 'The deterministic die sequence must at least contain one number'
]

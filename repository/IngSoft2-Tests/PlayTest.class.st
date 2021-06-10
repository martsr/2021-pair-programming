Class {
	#name : #PlayTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
PlayTest >> should: errorBlock raise: exceptionClass withMessage: expectedErrorMessage [

	self
		should: errorBlock
		raise: exceptionClass
		withExceptionDo:
			[ :error | self assert: error messageText equals: expectedErrorMessage ]
]

{ #category : #tests }
PlayTest >> test01APlayIsCreatedWithACardAndATargetedPlayer [

	| aCard  target aPlay |
	aCard := SpeedCard new.
	target := OrderedCollection newFrom: { 'Fran' }.
	aPlay := Play madeBy: aCard directedTo: target.
	self assert: (aPlay card) equals: aCard.
	self assert: (aPlay target) equals: target.
]

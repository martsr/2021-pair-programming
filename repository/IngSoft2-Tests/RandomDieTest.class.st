Class {
	#name : #RandomDieTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
RandomDieTest >> should: errorBlock raise: exceptionClass withMessage: expectedErrorMessage [

	self
		should: errorBlock
		raise: exceptionClass
		withExceptionDo:
			[ :error | self assert: error messageText equals: expectedErrorMessage ]
]

{ #category : #tests }
RandomDieTest >> test01ARandomDieWithTwentyFacesRollsANumberBetweenOneAndTwenty [
	
	| aDie |
	
	aDie := RandomDie containing: 20.
	self assert: (aDie throw between: 1 and: 20)
]

{ #category : #tests }
RandomDieTest >> test02ARandomDieCannotHaveLessThanThreeFaces [

	self
		should: [ RandomDie containing: 2 ]
		raise: Error
		withMessage: 'Die faces cannot be less than 3'
]

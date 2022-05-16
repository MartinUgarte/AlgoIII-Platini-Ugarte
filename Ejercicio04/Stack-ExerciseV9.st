!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'limitedStackTests' stamp: 'mr 5/15/2022 20:49:43'!
createStackWithThreeElements

	| stack capacity |
	
	capacity := 3.
	stack := OOLimitedStack new initializeWith: capacity.
	stack push: 'element1'.
	stack push: 'element2'.
	stack push: 'element3'.
	
	^stack
	! !

!OOStackTest methodsFor: 'limitedStackTests' stamp: 'mr 5/15/2022 20:40:13'!
test01EmptyStackIsNotFull

	| stack capacity |
	
	capacity := 3.
	stack := OOLimitedStack new initializeWith: capacity.

	self deny: stack isFull 
! !

!OOStackTest methodsFor: 'limitedStackTests' stamp: 'mr 5/15/2022 20:50:01'!
test02FullStackIsFull

	| stack |

	stack := self createStackWithThreeElements.

	self assert: stack isFull 
! !

!OOStackTest methodsFor: 'limitedStackTests' stamp: 'mr 5/15/2022 20:50:12'!
test03PushWhenStackIsFull

	| stack |
	
	stack := self createStackWithThreeElements.
	
	self
		should: [ stack push: 'element4' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack fullStackErrorDescription ]
		
! !

!OOStackTest methodsFor: 'limitedStackTests' stamp: 'mr 5/15/2022 20:50:15'!
test04PopWhenStackIsFull

	| stack |
	
	stack := self createStackWithThreeElements.
	stack pop.
	
	self deny: stack isFull.
	! !


!OOStackTest methodsFor: 'unlimitedStackTests' stamp: 'mr 5/15/2022 20:21:07'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOUnlimitedStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'unlimitedStackTests' stamp: 'mr 5/15/2022 20:21:17'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOUnlimitedStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'unlimitedStackTests' stamp: 'mr 5/15/2022 20:21:24'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOUnlimitedStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'unlimitedStackTests' stamp: 'mr 5/15/2022 20:38:48'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOUnlimitedStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'unlimitedStackTests' stamp: 'mr 5/15/2022 20:38:54'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOUnlimitedStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'unlimitedStackTests' stamp: 'mr 5/15/2022 20:39:00'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOUnlimitedStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'unlimitedStackTests' stamp: 'mr 5/15/2022 20:39:28'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOUnlimitedStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'unlimitedStackTests' stamp: 'mr 5/15/2022 20:39:35'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOUnlimitedStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'unlimitedStackTests' stamp: 'mr 5/15/2022 20:39:41'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOUnlimitedStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'unlimitedStackTests' stamp: 'mr 5/15/2022 20:39:48'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOUnlimitedStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'stack sentenceFinder foundSentences sentence1 sentence2 sentence3 sentence4 sentence5'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'mr 5/14/2022 23:21:14'!
test01PrefixCanNotBeEmpty

	| prefix |
	
	stack push: sentence1.
	sentenceFinder := SentenceFinderByPrefix with: stack.
	prefix := ''.
	
	self
		should: [ sentenceFinder find: prefix ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixCanNotBeEmptyError]
		

	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'mr 5/14/2022 23:07:49'!
test02PrefixCanNotHaveEmptySpaces

	| prefix |
	
	stack push: sentence1.
	sentenceFinder := SentenceFinderByPrefix with: stack.
	prefix := 'winter is'.
	
	self
		should: [ sentenceFinder find: prefix ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixCanNotHaveEmptySpacesError ]
		
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'mr 5/14/2022 23:09:40'!
test03StackWithOneSentenceAndBeginsWithPrefix

	| prefix |

	stack push: sentence1.
	sentenceFinder := SentenceFinderByPrefix with: stack.
	foundSentences add: sentence1.
	prefix := 'wint'.
	
	self assert: ((sentenceFinder find: prefix) = foundSentences).


	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'mr 5/14/2022 23:10:17'!
test04StackWithTwoSentencesAndOneBeginsWithPrefix

	| prefix |
	
	stack push: sentence1 .
	stack push: sentence2 .
	sentenceFinder := SentenceFinderByPrefix with: stack.
	foundSentences add: sentence1.
	prefix := 'wint'.
	
	self assert: ((sentenceFinder find: prefix) = foundSentences).
! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'mr 5/14/2022 23:13:03'!
test05StackWithTwoSentencesAndBothBeginWithPrefix

	| prefix |

	stack push: sentence1 .
	stack push: sentence5 .
	sentenceFinder := SentenceFinderByPrefix with: stack.
	foundSentences add: sentence5.
	foundSentences add: sentence1.
	prefix := 'wint'.
	
	self assert: ((sentenceFinder find: prefix) = foundSentences).

	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'mr 5/14/2022 23:14:33'!
test06SentenceFinderIsCaseSensitive

	| prefix |
	
	stack push: sentence4.
	stack push: sentence5.
	sentenceFinder := SentenceFinderByPrefix with: stack.
	foundSentences add: sentence4.
	prefix := 'Wint'.
	
	self assert: ((sentenceFinder find: prefix) = foundSentences).
! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'mr 5/14/2022 23:19:12'!
test07StackIsNotModifiedAfterFindingASentence
	
	| prefix |
	
	self fillStack.
	sentenceFinder := SentenceFinderByPrefix with: stack.
	prefix := 'wint'.
	
	sentenceFinder find: prefix.
	
	self assert: stack pop = sentence4.
	self assert: stack pop = sentence3.
	self assert: stack pop = sentence2.
	self assert: stack pop = sentence1.
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'mr 5/14/2022 23:19:31'!
test08NoSentenceBeginsWithThePrefix

	| prefix |
	
	self fillStack.
	sentenceFinder := SentenceFinderByPrefix with: stack.
	prefix := 'summer'.
	
	self assert: (sentenceFinder find: prefix) = foundSentences.



	! !


!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'mr 5/15/2022 20:55:20'!
setUp
	
	stack := OOUnlimitedStack new.
	foundSentences := OrderedCollection new.
		
	sentence1 := 'winter is coming'.
	sentence2 := 'winning is everything'.
	sentence3 := 'The winds of Winter'.
	sentence4 := 'Winter is here'.
	sentence5 := 'winter is over'.! !


!SentenceFinderByPrefixTest methodsFor: 'private' stamp: 'mr 5/14/2022 23:18:40'!
fillStack

	stack push: sentence1.
	stack push: sentence2.
	stack push: sentence3.
	stack push: sentence4.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'private' stamp: 'mr 5/11/2022 21:40:31'!
popWhenEmpty
	self error: OOStack stackEmptyErrorDescription.! !

!OOStack methodsFor: 'private' stamp: 'rp 5/12/2022 19:44:02'!
popWhenNotEmpty
	| removedItem |
	removedItem := stack last.
	stack removeLast.
	^removedItem.
! !

!OOStack methodsFor: 'private' stamp: 'mr 5/15/2022 20:31:29'!
status
	
	| actualStatus |
	
	actualStatus := OOStackStatus subclasses detect: [:aClass | aClass new filterBySize: self size].
	^actualStatus new.! !

!OOStack methodsFor: 'private' stamp: 'mr 5/15/2022 20:35:32'!
topWhenEmpty
	self error: OOStack stackEmptyErrorDescription.! !

!OOStack methodsFor: 'private' stamp: 'mr 5/11/2022 21:51:25'!
topWhenNotEmpty
	^stack last.! !


!OOStack methodsFor: 'public' stamp: 'rp 5/12/2022 19:42:08'!
isEmpty
	^(stack size) = 0.! !

!OOStack methodsFor: 'public' stamp: 'mr 5/12/2022 00:04:04'!
pop
	^self status pop: self.! !

!OOStack methodsFor: 'public' stamp: 'mr 5/15/2022 20:32:11'!
push: item
	self subclassResponsibility .! !

!OOStack methodsFor: 'public' stamp: 'rp 5/12/2022 19:41:19'!
size
	^stack size! !

!OOStack methodsFor: 'public' stamp: 'mr 5/12/2022 00:05:02'!
top
	^self status top: self.! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'mr 5/14/2022 23:37:28'!
fullStackErrorDescription
	
	^ 'Stack is full.'! !

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OOLimitedStack category: 'Stack-Exercise'!
OOStack subclass: #OOLimitedStack
	instanceVariableNames: 'capacity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOLimitedStack methodsFor: 'initialization' stamp: 'mr 5/15/2022 19:55:25'!
initializeWith: aCapacity
	capacity := aCapacity.
	stack := OrderedCollection new.! !


!OOLimitedStack methodsFor: 'public' stamp: 'mr 5/15/2022 19:55:01'!
capacity
	^capacity! !

!OOLimitedStack methodsFor: 'public' stamp: 'mr 5/15/2022 19:54:04'!
isFull
	^stack size = capacity.! !

!OOLimitedStack methodsFor: 'public' stamp: 'mr 5/15/2022 20:34:13'!
push: item
	(self isFull) ifTrue: [self pushWhenFull ].
	stack add: item.! !


!OOLimitedStack methodsFor: 'private' stamp: 'mr 5/15/2022 20:00:19'!
pushWhenFull
	self error: 	OOStack fullStackErrorDescription.! !


!classDefinition: #OOUnlimitedStack category: 'Stack-Exercise'!
OOStack subclass: #OOUnlimitedStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOUnlimitedStack methodsFor: 'public' stamp: 'mr 5/15/2022 20:07:25'!
push: item
	stack add: item.! !


!OOUnlimitedStack methodsFor: 'initialization' stamp: 'mr 5/15/2022 20:19:21'!
initialize
	stack := OrderedCollection new.! !


!classDefinition: #OOStackStatus category: 'Stack-Exercise'!
Object subclass: #OOStackStatus
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackStatus methodsFor: 'private' stamp: 'mr 5/15/2022 20:36:11'!
filterBySize: size
	self subclassResponsibility.! !

!OOStackStatus methodsFor: 'private' stamp: 'mr 5/15/2022 20:37:03'!
pop: stack
	^self subclassResponsibility.! !

!OOStackStatus methodsFor: 'private' stamp: 'mr 5/15/2022 20:38:15'!
top: stack
	^self subclassResponsibility.! !


!classDefinition: #EmptyStack category: 'Stack-Exercise'!
OOStackStatus subclass: #EmptyStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyStack methodsFor: 'private' stamp: 'mr 5/15/2022 20:30:26'!
filterBySize: size
	^size = 0.! !

!EmptyStack methodsFor: 'private' stamp: 'mr 5/11/2022 22:33:57'!
pop: stack
	^stack popWhenEmpty.
! !

!EmptyStack methodsFor: 'private' stamp: 'mr 5/11/2022 22:34:26'!
top: stack
	^stack topWhenEmpty.! !


!classDefinition: #NotEmptyStack category: 'Stack-Exercise'!
OOStackStatus subclass: #NotEmptyStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NotEmptyStack methodsFor: 'private' stamp: 'mr 5/15/2022 20:30:43'!
filterBySize: size
	^((size = 0) not).! !

!NotEmptyStack methodsFor: 'private' stamp: 'mr 5/15/2022 20:36:58'!
pop: stack
	^stack popWhenNotEmpty.! !

!NotEmptyStack methodsFor: 'private' stamp: 'mr 5/15/2022 20:39:15'!
top: stack
	^stack topWhenNotEmpty.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack foundSentences'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'mr 5/14/2022 22:50:14'!
addSentence: aSentence
	foundSentences add: aSentence! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'mr 5/15/2022 20:56:54'!
filterSentencesByPrefix: aPrefix
	| auxiliarStack sentence |
	
	auxiliarStack := OOUnlimitedStack new.
	
	[stack isEmpty not] whileTrue: [
		sentence := stack pop.
		(sentence beginsWith: aPrefix) ifTrue: [self addSentence: sentence].
		auxiliarStack push: sentence.			
		].
	
	^auxiliarStack.! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'mr 5/14/2022 22:39:41'!
prefixHasEmptySpaces: aPrefix
	^aPrefix includes: $ .! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'mr 5/14/2022 22:39:13'!
prefixIsEmpty: aPrefix
	^aPrefix = ''.! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'mr 5/14/2022 22:43:11'!
restoreStack: auxiliarStack
	| sentence |
	[auxiliarStack isEmpty not] whileTrue: [
		sentence := auxiliarStack pop.
		stack push: sentence.			
		].! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'mr 5/14/2022 22:40:42'!
verifyPrefix: aPrefix
	(self prefixIsEmpty: aPrefix) ifTrue: [self error: SentenceFinderByPrefix prefixCanNotBeEmptyError ].
	(self prefixHasEmptySpaces: aPrefix) ifTrue: [self error: SentenceFinderByPrefix prefixCanNotHaveEmptySpacesError ].! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'rp 5/14/2022 16:48:34'!
initializeWith: aStack
	stack := aStack.
	foundSentences := OrderedCollection new.! !


!SentenceFinderByPrefix methodsFor: 'public' stamp: 'mr 5/14/2022 22:47:03'!
find: aPrefix
	
	| auxiliarStack |

	self verifyPrefix: aPrefix.

	auxiliarStack := self filterSentencesByPrefix: aPrefix.
	
	self restoreStack: auxiliarStack .

	^foundSentences.


! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'initialization' stamp: 'rp 5/12/2022 20:51:44'!
with: aStack
	^self new initializeWith: aStack.! !


!SentenceFinderByPrefix class methodsFor: 'error' stamp: 'rp 5/12/2022 20:22:53'!
prefixCanNotBeEmptyError
	
	^ 'Stack cannot be empty'! !

!SentenceFinderByPrefix class methodsFor: 'error' stamp: 'rp 5/12/2022 20:02:55'!
prefixCanNotHaveEmptySpacesError
	
	^ 'Prefix has empty spaces'! !

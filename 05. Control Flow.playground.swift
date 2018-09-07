///------------------------------------------------------------------------------------------------
///Things to know:
///
///* Much of the control flow in Swift is similar to C-like languages, but there are some key
///  differences. For example, switch-case constructs are much more flexible and powerful as well
///  as extensions to break and continue statements.
///------------------------------------------------------------------------------------------------

///------------------------------------------------------------------------------------------------
///For loops
///
///We can loop through ranges using the closed-range operator ("...").
///
///In the loop below, 'index' is a constant that is automatically declared.
for index in 1...5 {
	print("This will print 5 times")
	///Being a constant, the following line won't compile:
	///
	///index = 99
}

///The constant 'index' from the previous loop is scoped only to the loop. As a result, you cannot
///access it beyond the loop. The following line will not compile:
///
///index = 0

///We can loop through ranges using the half-closed range operator ("..<")
///
///We can also reuse the name 'index' because of the scoping noted previously.
for index in 1 ..< 5 {
	print("This will print 4 times")
}

///Apple's "Swift Programming Language" book states the following, which I find in practice to be
///incorrect:
///
///“The index constant exists only within the scope of the loop. If you want to check the value of
///index after the loop completes, or if you want to work with its value as a variable rather than
///a constant, you must declare it yourself before its use in the loop.”
///
///In practice, I find that the loop constant overrides any local variable/constant and maintains
///its scope to the loop and does not alter the locally defined value:
var indx = 3999
for indx in 1...5 {
	print(indx) ///This ranges from 1 to 5, inclusive

	///'indx' is still acting like a constant, so this line won't compile:
	///
	///indx++
}

///After the loop, we find that 'indx' still contains the original value of 3999
print(indx)

///We can use an underscore if you don't need access to the loop constant:
for _ in 1...10 {
	print("do something")
}

///We can iterate over arrays
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
	print(name)
}

///We can iterate over a Dictionary's key/value pairs
let numberOfLegs = ["Spider": 8, "Ant": 6, "Cat": 4]
for (animalName, legs) in numberOfLegs {
	animalName
	legs
}

///We can iterate over characters in a String
for character in "Hello" {
	character
}

///We can use the For-Condition-Increment loop construct, which resembles the C-like variant
///
///Note that the loop value is a variable, not a constant. In fact, they cannot be constant
///because of the increment statement (++index)
for (var index = 0; index < 3; ++index) {
	index
}

/* error: repl.swift:50:1: error: C-style for statement has been removed in Swift 3
for (var index = 0; index < 3; ++index) {
^   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

///------------------------------------------------------------------------------------------------
///While loops
///

///Do-While loops also resemble their C-like language counterparts. They perform the condition
///after each iteration through the loop. As a result, they always execute the code inside the
///loop at least once:
do {
	++index
} while (index < 3)

///------------------------------------------------------------------------------------------------
///Conditional Statements
///

///Switch statements are more powerful than their C-like counterparts. Here are a few of those
///differences to get us started:
///
///Unlike C-like languages, switch statements do not require a "break" statement to prevent falling
///through to the next case.
///
///Additionally, multiple conditions can be separated by a comma for a single case to match
///multiple conditions.
///
///Switch statements must also be exhaustive and include all possible values, or the compiler will
///generate an error.
///
///There are many more differences, but let's start with a simple switch statement to get our feet
///wet:
let someCharacter: Character = "e"
switch someCharacter {
case "a", "e", "i", "o", "u":
	print("a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "u", "z":
	print("a consonant")
///Necessary because switch statements must be exhaustive in order to capture all Characters
default:
	print("not a vowel or consonant")
}

///Each case clause must have a statement of some kind. A comment will not suffice.
///
///Otherwise you will get a compilation error. The following won't compile because there is an
///empty case statement:
///
///let anotherCharacter: Character = "a"
///switch anotherCharacter
///{
//		case "a":
//		case "A":
//			"the letter a"
//		default:
//			"not the letter a"
//	}

///We can perform range matching for cases:
let count = 3_000_000_000_000
switch count {
case 0:
	print("no")
case 1...3:
	print("a few")
case 4...9:
	print("several")
case 10...99:
	print("tens of")
case 100...999:
	print("hundreds of")
case 1000...999999:
	print("thousands of")
default:
	print("millions and millions of")
}

///Matching against tuples
///
///In addition to matching Tuples, we can also use ranges inside Tuple values and even match
///against partial Tuple values by using an "_" to ignore matches against a specific value within
///the Tuple.
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
	print("origin")

///Match only against y=0
case (_, 0):
	print("On the X axis")

///Match only against x=0
case (0, _):
	print("On the y axis")

///Match x and y from -2 to +2 (inclusive)
case (-2...2, -2...2):
	print("On or inside the 2x2 box")

///Everything else
default:
	print("Outisde the 2x2 box")
}

///Value bindings in switch statements
///
var anotherPoint = (2, 8)
switch anotherPoint {
	///Bind 'x' to the first value (matching any x) of the tuple and match on y=0
case (let x, 0):
	print("On the x axis with an x value of \(x)")

///Bind 'y' to the second value (matching any y) of the tuple and match against x=0
case (0, let y):
	print("On the y axis with an y value of \(y)")

///Bind both values of the tuple, matching any x or y. Note the shorthand of the 'let'
///outside of the parenthesis. This works with 'var' as well.
///
///Also notice that since this matches any x or y, we fulfill the requirement for an exhaustive
///switch.
case let (x, y):
	print("Somewhere else on \(x), \(y)")
}

///We can also mix let/var for case statements. The following code block is the same as the
///previous except that the final case statement, which mixes variable and constants for the x and
///y components of the Tuple.
switch anotherPoint {
case (let x, 0):
	print("On the x axis with an x value of \(x)")

case (0, let y):
	print("On the y axis with an y value of \(y)")

case (var x, let y):
	x += 1///We can modify the variable 'x', but not the constant 'y'
	print("Somewhere else on \(x), \(y)")
}

///Where clauses allow us to perform more detailed conditions on case conditions. The where clauses
///work on the values declared on the case line:
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
	print("On the line of x == y")

case let (x, y) where x == -y:
	print("On the line of x == -y")

case let (x, y):
	print("Just some arbitrary point")
}

///------------------------------------------------------------------------------------------------
///Control transfer statements
///
///Swift supports extended versions of continue and break as well as an additional 'fallthrough'
///statement for switch-case constructs.
///
///Since swift doesn't require a break statement to avoid falling through to the next case, we can
///still use them to early-out of the current case without continuing work. The first statement
///after the 'break' will be the next statement following the entire switch construct.
let someValue = 9000
switch someValue {
case let x where (x & 1) == 1:
	if someValue < 100 {
		print("Odd number less than 100")
		break
	}
	print("Odd number greater or equal to 100")
case let x where (x & 1) == 0:
	if someValue < 100 {
		print("Even number less than 100")
		break
	}
	print("Even number greater or equal to 100")

default:
	print("Unknown value")
}

/* var myArray = [23, 54, 51, 98, 54, 23, 32]
for myInt: Int in myArray {
  if myInt % 2 == 0 {
    print("\(myInt) is even number")
  } else {
    print("\(myInt) is odd number")
  }
} */

///Since each case must have a statement and since we must have an exhaustive switch, we can use
///the break statement to effectively nullify the use of a case:
switch someValue {
case Int.min...100:
	print("Small number")

case 101...1000:
	break ///We don't care about medium numbers

case 1001...100_00:
	print("Big number")

default:
	break ///We don't care about the rest, either
}

///Since we don't need to break out of cases to avoid falling through automatically, we must
///specifically express our intention to fall through using the 'fallthrough' keyword
let integerToDescribe = 5
var integerDescription = "\(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
	integerDescription += " a prime number, and also"
	print(integerDescription)
	fallthrough

default:
	integerDescription += " an integer."
	print(integerDescription)
}

///Continue and Break statements have been extended in Swift to allow each to specify which
///switch or loop construct to break out of, or continue to.
///
///To enable this, labels are used, similar to labels used by C's goto statement.
///
///The following will print each name until it reaches the letter 'a' then skip to the next name
var result = ""
nameLoop: for name in names {
	characterLoop: for character in name {
		theSwitch: switch character {
		case "a":
			///Break out of the theSwitch and characterLoop
			break characterLoop
		default:
			result += String(character)
		}
	}
}
print(result)

///Similarly, this prints all names without the letter 'a' in them:
result = ""
nameLoop: for name in names
{
	characterLoop: for character in name
	{
		theSwitch: switch character
		{
			case "a":
				///Continue directly to the character loop, bypassing this character in this name
				continue characterLoop
			
			default:
				result += String(character)
		}
	}
}
result

///Similarly, this prints all names until the letter 'x' is found, then aborts all processing by
///breaking out of the outer loop:
result = ""
nameLoop: for name in names
{
	characterLoop: for character in name
	{
		theSwitch: switch character
		{
			case "x":
				///Break completely out of the outer name loop
				break nameLoop
			
			default:
				result += String(character)
		}
	}
}
result

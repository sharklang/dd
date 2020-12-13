/*
 * generated by Xtext 2.21.0
 */
package com.shark.lang.tests

import com.google.inject.Inject
import com.shark.lang.dd.DataModelFragment
import javax.inject.Provider
import org.eclipse.emf.common.util.URI
import org.eclipse.xtext.resource.XtextResourceSet
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.InMemoryURIHandler
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith

//with a grammar that is EOF sensitive we need to use File Input Stream
@ExtendWith(InjectionExtension)
@InjectWith(DdInjectorProvider)
class DdParsingTest {
	// @Inject ParseHelper<DataModel> parseHelper
	@Inject ValidationTestHelper validationTestHelper
	// @Inject ResourceHelper resourceHelper;
	// @Inject NodeModelUtils modelUtil //nodeUtil is static...
	// @Inject ITokenDefProvider tokenDefProvider;
	// @Inject Lexer lexer;
	@Inject Provider<XtextResourceSet> resourceSetProvider

	val handler = new InMemoryURIHandler()

	@Test
	def void testCheckExpressionsPassingCases() {

		val memFile = "inmemory:/testCheckExpressionsPassingCases.dd" -> '''
			'description of this model, why is it structured like that and which entities it contains
			'the first series of constants test nominal declarions of constants for each type
			model Customer_Accounts 
			
			'first of all we can put comments everywhere as a full line but they are related to the next item
			'and they have to follow the indentation strcuture
			'so these first 3 lines will be considered as extra decription of the first costant AVERAGE_AGE below
			int(2,1)  AVERAGE_AGE = (32+4) 'to initiate ages
			str(9)  DEFAULT_FIRST_NAME= "@No22Name" 'just for testing string constants
			date BUG_OF_2000 = "20000101"  'just to test date constants
			date CREATION_OF_BANK = "18700101"  'just to test date constants
			chr  YES = "Y" 'yes constant
			chr  NO = "N"  'no constant
			dec(15,5) MAX_AMOUNT = 3145678190.12345 'max amount
			time MIDNIGHT = "000000" 'to test a time constant 
			stamp MIDNIGHT_STAMP = "20100101.000000.9999" 'to test a time constant 
			chr[2] GENDERS = ("M","F") 'domain values for gender
			str(3)[5] ALLOWED_ISO_3_CCY = ("eur","USD","GPB","JPY","RMB") 'domain values for currencies 
			bits PLAIN = "000001" 'this is a joke...
			bool TRUE = true 'for testinrg
			date[3] TARGET_HOLIDAYS = ("20000101","18700101","17890101") 'bank holidays for europe target2 all put in year 2000
			time[3] CUTOFF_TIMES = ("120000","163000","193059") 'time of sepa cutoffs
			stamp[2] MILLENIUM_BUG = ("20000101.000000.0000","20000101.000000.0000") 'the time after which all should have gone mad
			
			'this is the entity description
			'it can have several lines
			'to decribe the entity person below
			'a Person can be a customer or a related party or an employee 
			Person:
				'extra attribute description for attribute id that follows
				'it can have as many lines as we want, while the trailing comment at the 
				'end of the line is a single line comment. only the trailing is mandatory
				int(10)  id  key 'the internal identifier of the Person
			
				'See here an example of a line continuation \ which is the only way to split a statement into several line
				str(100) name \
										="Chang" 'name of the person which I defaulted to one for the sake of the example
				str(100) prenom = DEFAULT_FIRST_NAME 'first name of the customer
				chr	     gender = "M" 'the gendre either M or F
			
				date     dateOfBirth = BUG_OF_2000 'the date of birth is initialized for generation Millenial 
				time     timeOfBirth = MIDNIGHT 'init at midnight
				str(2)   countryOfBirth_iso2 = "CN" 'initialized to the most common country in the world :-)
			
				str(5)   postalCode = "92500" 'code desc
				'forbidden physical description data :-)
				bits(5)  physical_description = "11010" 'blue eyes (0|1) dark hair (0|1) dark skin (0|1) height>1,75 (0|1) fat (0|1)
			
			'a customer can be a person or a company
			Customer:
				int(10) 	id  key 'the internal identifier of the Customer 
				(0..1) isPerson (1..1) Person 'a Cutomer has to be a Person (abstracting the notion of company for the example) but a Person might not be
				(1..n) hasAccounts (0..n) Account 'should move to a 1-n relationship because a customer has at least one account
			
			'banking account, can be of many types (term, savings, current, overdraft...)
			Account:
				int(11) 			num     key   ! 'the internal acount number 
				dec(13,7) 		balance 'balance os the account with a large enough precision for all type of currency
				str(100) 					description ! 'open description of the account from a customer standpoint, mandatory with !
				date openDate = "20120101" 'opening date of the account
				time openTime = "141853" 'opening time on the client side 
				stamp openTimeStamp = "20120101.141857.1234"  'timestamp at write time on the DB
				bits flags 'to store shit in ity
			
			'default checks done all the time
			'add a validation that it cannot crossref other entities unless there is a 1-1 relationship
			#Account:
				'test the account opening date validity: it cannot be less than the bank historical creation in 1870 and limite to next 200 years
				test1 (((Account.openDate>=CREATION_OF_BANK) or (Account.openDate<=date("22000101"))) and ((7==8)==true))
				'test date cast
				test2 ((Account.num>=5) or (0<=8) or (Account.openDate==date("")) or ((1+6+Account.balance)>=9))
				'mandatory doc on tests
				test3 (((1+2+4+(5*5*6)+(5/6))==0) or ((10/3) in (1,2)))
				'mandatory doc
				test4 (("" stxt (1,2))=="") 
			
			'default intrinsic checks for a person entity
			#Person:
				'test date on constants
				test1 ((len(Person.name)>=5) or (0<=8) or (Person.dateOfBirth==date(DEFAULT_FIRST_NAME)) or ((1+6+Person.id)<9))
				'test2
				test2 ((1 in (1..4)) and (("ABC" in "DBCDABC")==4))
				'test
				test3 (("A" in "ABCDEF")==0) 
				'test
				test4 (Person.gender in GENDERS)
				'test
				test5 ("hello" in ("hello","bonjour","guten morgen")) 
				'test
				test6 (DEFAULT_FIRST_NAME like str(123))
			
			'All cross checks for persons and accounts
			#Accounts_Person:
				'test
				test1 ((len(Person.name)>=5) or (0<=8) or (Person.dateOfBirth==CREATION_OF_BANK) or ((1+6+Account.balance)<9))
				'test
				test2 true
				'test
				test3 ((1+2+3+4+(5*5)+(5*6)+5)==6)
			
		'''

		testMemoryFileNoError(memFile)

	}

	@Test
	def void testRound() {

		val memFile = "inmemory:/testRound.dd" -> '''
			'this is a test model   
			model Round_Test
			dec ( 3 , 1 ) TEST1 = ( ( 2.23 + 1 ) round 1 ) 'comment
			dec ( 3 , 1 ) TEST2 = ( ( 2.2 + 1.7896 ) round 2 ) 'comment
			dec ( 3 , 1 ) TEST3 = ( 2.234 + 1.6745 ) 'comment
			str ( 3 , 1 ) TEST4 = (2.23 round 2) 'comment
			
		'''

		val errList = testMemoryFileWithErrors(memFile)
		//Assertions.assertTrue(errList.isEmpty, '''Errors: «errList.join("\n ")»''')
		Assertions.assertTrue((errList.get(0).message ==
			"Expression precision is incompatible with the declaration precision, it is 2 and not 1"),
			"Precision Validation Check With Round Not Working")
		Assertions.assertTrue((errList.get(1).message == 
			"Expression precision is incompatible with the declaration precision, it is 4 and not 1"), 
			"Precision Validation Check Without Round Not Working")
		Assertions.assertTrue((errList.get(2).message == 
			"Invalid initialization: expression type mismatch with attribute or constant"), 
			"Type Checking Not Working On Round: Should Detect That Round Is a Num And Not A Str")
		
	}
	
	@Test
	def void testStxt() {

		val memFile = "inmemory:/testStxt.dd" -> '''
			'this is a test model   
			model Round_Test
			str ( 3 , 1 ) TEST1 = ( "AB" & "AB" )	'comment
			str ( 3 , 1 ) TEST2 = (( "AB" & "AB" ) stxt (1,3) )'comment
			str ( 4 )     TEST3 = ("A" & "A" & "A" & "A" & "A") 'comment
			str (4,2)     TEST4 = "A" 'comment
			str ( 3 , 1 ) TEST5 = ("ABC" stxt (1,3,4) )'comment
			str ( 3 ) TEST6 = (1 stxt (1,3) )'comment
			
		'''

		val errList = testMemoryFileWithErrors(memFile)
		//Assertions.assertTrue(errList.isEmpty, '''Errors: «errList.join("\n ")»''')
		//warnings are skipped in the list
		Assertions.assertTrue((errList.get(0).message ==
			"Expression length is incompatible with the declaration length, it is 4 and not 3"),
			"Length Validation Check Not Working on binary cat")
		Assertions.assertTrue((errList.get(1).message == 
			"Expression length is incompatible with the declaration length, it is 5 and not 4"), 
			"Length Validation Check Not Working on multiple cat")
		Assertions.assertTrue((errList.get(3).message == 
			"Expression min size is incompatible with the declaration min size, it is 1 and not 2"), 
			"Min length validation on string not working")
		Assertions.assertTrue((errList.get(4).message == 
			"Type Mismatch: substring operator requires string on the left and integer list on the right"), 
			"Operator validation not working")
		Assertions.assertTrue((errList.get(5).message == 
			"Type Mismatch: substring operator requires string on the left and integer list on the right"), 
			"Type Mismatch validation on stxt operator is not working")
		Assertions.assertTrue((errList.get(6).message == 
			"Invalid initialization: expression type mismatch with attribute or constant"), 
			"Type Mismatch validation is not working")

		
	}
	
	@Test
	def void testMultType() {

		val memFile = "inmemory:/testStxt.dd" -> '''
			'this is a test model   
			model Round_Test
			int ( 3,2 )     TEST1 = (323+4+"" ) 'comment
			int ( 3,2 )     TEST2 = (32*4*"" ) 'comment
			str ( 3,2 )     TEST3 = ("A" & "A" & 1.2) 'comment
			bool			    TEST4 = (true or false or "") 'comment
			bool			    TEST5 = (true and false and "") 'comment
			
		'''

		val errList = testMemoryFileWithErrors(memFile)
		//Assertions.assertTrue(errList.isEmpty, '''Errors: «errList.join("\n ")»''')
		Assertions.assertTrue((errList.get(0).message ==
			"Type Mismatch: all the members of the addition should be of numeric type"),
			"Type validation of Multiple add fails")
		Assertions.assertTrue((errList.get(1).message == 
			"Type Mismatch: all the members of the multiplication should be of numeric type"), 
			"Type validation of Multiple mult fails")
		Assertions.assertTrue((errList.get(2).message == 
			"Type Mismatch: all the members of the concat expression should be of string type"), 
			"Type validation of Multiple cat fails")
		Assertions.assertTrue((errList.get(3).message == 
			"Type Mismatch: all the members of the logical Or expression should be of boolean type"), 
			"Type validation of Multiple or fails")
		Assertions.assertTrue((errList.get(4).message == 
			"Type Mismatch: all the members of the logical And expression should be of boolean type"), 
			"Type validation of Multiple and fails")
		
	}
	
	@Test
	def void testLike() {

		val memFile = "inmemory:/testStxt.dd" -> '''
			'this is a test model   
			model Round_Test
			bool			    TEST1 = ("TOTO" like "TO") 'comment
			bool			    TEST2 = ("TATA" like "") 'comment
			
		'''

		val errList = testMemoryFileWithErrors(memFile)
		//Assertions.assertTrue(errList.isEmpty, '''Errors: «errList.join("\n ")»''')
		Assertions.assertTrue((errList.get(0).message ==
			"Invalid Operand: String template for a like operator cannot be empty"),
			"Verification of right operand of like operator fails")
	}

	@Test
	def void testDateCasts() {

		val memFile = "inmemory:/testStxt.dd" -> '''
			'this is a test model   
			model Round_Test
			date			    TEST1 = date("ABC") 'comment
			stamp			    TEST2 = stamp("CDE") 'comment
			time            TEST3 = time("EFG") 'comment
			
		'''

		val errList = testMemoryFileWithErrors(memFile)
		//Assertions.assertTrue(errList.isEmpty, '''Errors: «errList.join("\n ")»''')
		Assertions.assertTrue((errList.get(0).message ==
			"Invalid Date Format: it should be YYYYMMDD"),
			"Verification of date cast literal operand format failed")
		Assertions.assertTrue((errList.get(1).message ==
			"Invalid Timestamp Format: it should be YYYYMMDD.HHMMSS.ssss"),
			"Verification of stamp cast literal operand format failed")
		Assertions.assertTrue((errList.get(2).message ==
			"Invalid Time Format: it should be HHMNSS"),
			"Verification of time cast literal operand format failed")
	}


//TODO move that to a helper class
	def testMemoryFileNoError(Pair<String, String> fileDesc) {
		val inMemFile = handler.getInMemoryFile(URI.createURI(fileDesc.key))
		inMemFile.contents = fileDesc.value.bytes
		inMemFile.exists = true
		val resourceSet = resourceSetProvider.get
		resourceSet.URIConverter.URIHandlers.add(0, handler)
		val resource = resourceSet.getResource(URI.createURI(fileDesc.key), true)
		resource.load(null)
		val model = resource.contents.head as DataModelFragment
		if(resource.loaded) {
			val errors = resource.errors
			validationTestHelper.assertNoError(model,'''Errors: «errors.join("\n ")»''')
		
		}
		//println(NodeModelUtils.compactDump(NodeModelUtils.getNode(model), true))
	}

	def  testMemoryFileWithErrors(Pair<String, String> fileDesc) {
		val inMemFile = handler.getInMemoryFile(URI.createURI(fileDesc.key))
		inMemFile.contents = fileDesc.value.bytes
		inMemFile.exists = true
		val resourceSet = resourceSetProvider.get
		resourceSet.URIConverter.URIHandlers.add(0, handler)
		val resource = resourceSet.getResource(URI.createURI(fileDesc.key), true)
		resource.load(null)
		val model = resource.contents.head as DataModelFragment
		validationTestHelper.validate(model)
	}

}

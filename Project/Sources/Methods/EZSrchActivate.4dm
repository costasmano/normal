//%attributes = {"invisible":true}
//GP EZSrchActivate
//Copyright © 1998, Thomas D. Nee, All Rights Reserved.

C_LONGINT:C283($1; vStage)  //Command Replaced was o_C_INTEGER//Parameter: Code indicating which part of the editor to be made active.
C_TEXT:C284($FldType)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284($Filter)
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER
//TRACE

vStage:=$1
$FldType:=asShowTyps{vBuildCount}

vEntryData:=""
//Simulate pressing the return key to exit vEntryData.
//Changes made 6/6/00
//PostKey (9;0) - original code for 4D v3.5
POST KEY:C465(9; 0)  //Changed code to work with 4D 6.5

sbAnd:=0
sbOr:=0
sbExcept:=0
If (vBuildCount>1)
	Case of 
		: (asConjunct{vBuildCount}="And")
			sbAnd:=1
		: (asConjunct{vBuildCount}="Or")
			sbOr:=1
		: (asConjunct{vBuildCount}="Except")
			sbExcept:=1
	End case 
End if 

$i:=vBuildCount
If ((asShowFlds{$i}="") & ($i>1))
	//Nothing selected yet, use the previous one.  
	$i:=$i-1
End if 
asFields:=Find in array:C230(asFields; asShowFlds{$i})

$i:=vBuildCount
If ((asShowRel{vBuildCount}="") & ($i>1))
	//Nothing selected yet, use the previous one.  
	$i:=$i-1
End if 
rbEqual:=0
rbNotEqual:=0
rbLess:=0
rbLessEqual:=0
rbGreater:=0
rbGreaterEq:=0
rbStarts:=0
rbContains:=0
rbNotCont:=0
Case of 
	: (asShowRel{$i}="Equal To")
		rbEqual:=1
	: (asShowRel{$i}="Not Equal To")
		rbNotEqual:=1
	: (asShowRel{$i}="Less Than")
		rbLess:=1
	: (asShowRel{$i}="Less Than or Equal To")
		rbLessEqual:=1
	: (asShowRel{$i}="Greater Than")
		rbGreater:=1
	: (asShowRel{$i}="Greater Than or Equal To")
		rbGreaterEq:=1
	: (asShowRel{$i}="Starts With")
		rbStarts:=1
	: (asShowRel{$i}="Contains")
		rbContains:=1
	: (asShowRel{$i}="Does Not Contain")
		rbNotCont:=1
End case 

Case of 
	: (vStage=1)
		//Activate field selection.
		//    asConjunct:=0
		//    asShowFlds:=vBuildCount
		//    asShowRel:=0
		//    asShowData:=0
		OBJECT SET ENABLED:C1123(sbAnd; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(bPlusKey; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(sbOr; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(sbExcept; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		
		OBJECT SET ENABLED:C1123(rbEqual; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(rbNotEqual; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(rbLess; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(rbLessEqual; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(rbGreater; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(rbGreaterEq; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(rbStarts; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(rbContains; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(rbNotCont; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		
		OBJECT SET ENTERABLE:C238(vEntryData; False:C215)
		
	: (vStage=2)
		//Activate relationship selection.
		//    asConjunct:=0
		//    asShowFlds:=0
		//    asShowRel:=vBuildCount
		//    asShowData:=0
		OBJECT SET ENABLED:C1123(sbAnd; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(bPlusKey; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(sbOr; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(sbExcept; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		
		OBJECT SET ENABLED:C1123(rbEqual; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(rbNotEqual; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		
		Case of 
			: ($FldType="Boolean")
				//All these are disabled for true/false.   
				If ((rbEqual=0) & (rbNotEqual=0))
					EZResetBtns
				End if 
				OBJECT SET ENABLED:C1123(rbLess; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET ENABLED:C1123(rbLessEqual; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET ENABLED:C1123(rbGreater; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET ENABLED:C1123(rbGreaterEq; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET ENABLED:C1123(rbStarts; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET ENABLED:C1123(rbContains; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET ENABLED:C1123(rbNotCont; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			: (($FldType="Text") | (Substring:C12($FldType; 1; 4)="Char"))
				//Enable everything for strings.        
				OBJECT SET ENABLED:C1123(rbLess; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				OBJECT SET ENABLED:C1123(rbLessEqual; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				OBJECT SET ENABLED:C1123(rbGreater; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				OBJECT SET ENABLED:C1123(rbGreaterEq; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				OBJECT SET ENABLED:C1123(rbStarts; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				OBJECT SET ENABLED:C1123(rbContains; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				OBJECT SET ENABLED:C1123(rbNotCont; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			Else 
				//Number, date, or time.
				If ((rbStarts=1) | (rbContains=1) | (rbNotCont=1))
					EZResetBtns
				End if 
				OBJECT SET ENABLED:C1123(rbLess; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				OBJECT SET ENABLED:C1123(rbLessEqual; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				OBJECT SET ENABLED:C1123(rbGreater; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				OBJECT SET ENABLED:C1123(rbGreaterEq; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				OBJECT SET ENABLED:C1123(rbStarts; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET ENABLED:C1123(rbContains; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET ENABLED:C1123(rbNotCont; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End case 
		
		OBJECT SET ENTERABLE:C238(vEntryData; False:C215)
		
	: (vStage=3)
		//Activate data entry.
		//    asConjunct:=0
		//    asShowFlds:=0
		//    asShowRel:=0
		//    asShowData:=vBuildCount
		OBJECT SET ENABLED:C1123(sbAnd; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(bPlusKey; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(sbOr; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(sbExcept; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		
		OBJECT SET ENABLED:C1123(rbEqual; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(rbNotEqual; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(rbLess; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(rbLessEqual; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(rbGreater; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(rbGreaterEq; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(rbStarts; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(rbContains; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(rbNotCont; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		
		vEntryData:=asShowData{vBuildCount}
		OBJECT SET ENTERABLE:C238(vEntryData; True:C214)
		Case of 
			: ($FldType="Boolean")
				$Filter:="~"+<>sQU+"0;1;T;F;Y;N"+<>sQU+"#"
			: (($FldType="Integer") | ($FldType="Long Int"))
				$Filter:="&9"
			: ($FldType="Real")
				$Filter:="&"+<>sQU+"0-9;.;-"+<>sQU
			: ($FldType="Date")
				$Filter:="&"+<>sQU+"0-9;/;.;-; "+<>sQU
			: ($FldType="Time")
				$Filter:="&"+<>sQU+"0-9;:"+<>sQU
			Else 
				//String data, no restrictions.
				$Filter:=""
		End case 
		OBJECT SET FILTER:C235(vEntryData; $Filter)
		GOTO OBJECT:C206(vEntryData)
		
	: (vStage=0)
		//Activate conjunction selection.
		//asConjunct should be zero unless the user is changing an existing conjunction.
		//    asShowFlds:=0
		//    asShowRel:=0
		//    asShowData:=0
		OBJECT SET ENABLED:C1123(sbAnd; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(bPlusKey; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(sbOr; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(sbExcept; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		
		OBJECT SET ENABLED:C1123(rbEqual; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(rbNotEqual; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(rbLess; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(rbLessEqual; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(rbGreater; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(rbGreaterEq; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(rbStarts; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(rbContains; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(rbNotCont; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		
		OBJECT SET ENTERABLE:C238(vEntryData; False:C215)
		
End case 
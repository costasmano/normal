//%attributes = {"invisible":true}
If (False:C215)
	//Project Method : Temp_DefConstants
	//Create/Overwrite Constants.
	//Must be executed in 4D Development enviroment; NOT in 4D Client.
	
	
	C_TIME:C306($myfile)
	C_LONGINT:C283($resourceID)
	C_TEXT:C284(vResourceName)  // Command Replaced was o_C_STRING length was 80
	ARRAY TEXT:C222(StringVal; 0)  //Command Replaced was o_ARRAY string length was 30
	ARRAY TEXT:C222(StringT; 0)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222(String4DK; 0)  //Command Replaced was o_ARRAY string length was 68
	
	$myfile:=Open resource file:C497(Structure file:C489)
	
	//There is no checking whether we are overwriting
	// resources with  not the same name.
	
	$resourceID:=15000
	vResourceName:="BMS Image Types"
	ARRAY TEXT:C222(StringVal; 3)  //Command Replaced was o_ARRAY string length was 30
	ARRAY TEXT:C222(StringT; 3)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222(String4DK; 3)  //Command Replaced was o_ARRAY string length was 68
	//When changing these remember to check lists
	//  PictureCode, PictureCodeDescr
	StringVal{1}:="3"
	StringT{1}:="S"  //String resource value
	String4DK{1}:="BMS Photo"
	StringVal{2}:="1"
	StringT{2}:="S"
	String4DK{2}:="BMS Sketch"
	StringVal{3}:="2"
	StringT{3}:="S"
	String4DK{3}:="BMS Chart"
	M_SET4DK($resourceID; $myfile)
	
	$resourceID:=15001
	vResourceName:="BMS Approval Stages"
	ARRAY TEXT:C222(StringVal; 3)  //Command Replaced was o_ARRAY string length was 30
	ARRAY TEXT:C222(StringT; 3)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222(String4DK; 3)  //Command Replaced was o_ARRAY string length was 68
	StringVal{1}:="0"
	StringT{1}:="L"  //Longint resource value
	String4DK{1}:="BMS Not Reviewed"
	StringVal{2}:="1"
	StringT{2}:="L"
	String4DK{2}:="BMS Rejected"
	StringVal{3}:="2"
	StringT{3}:="L"
	String4DK{3}:="BMS Approved"
	M_SET4DK($resourceID; $myfile)
	
	CLOSE RESOURCE FILE:C498($myfile)
End if 

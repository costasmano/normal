//%attributes = {"invisible":true}
If (False:C215)
	//Init_Fields_DES1 
	// User name (OS): cjmiller
	// Date and time: 
	// ----------------------------------------------------
	// Description
	//This method will perform list part of this initialization
	
	Mods_2004_CJM02
	// Modified by: costasmanousakis-(Designer)-(3/28/2007 15:51:30)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(9/10/08 08:59:17)
	Mods_2008_CM_5404
	//  `Use new method MATH_ArabicToRoman
	// Modified by: costasmanousakis-(Designer)-(9/30/08 15:05:37)
	Mods_2008_CM_5404  // ("DESIGNMODS")
	//  `Stop creating global arrays ◊IDaFeatDescr,.. and ◊BINaFeatDescr,..  they are the same as the 
	//  `◊aFeatDescr,.. arrays
	Mods_2011_06  // CJ Miller`06/14/11, 10:37:48      ` Type all local variables for v11
End if 
C_LONGINT:C283($i; $codes)
//Rating File Types
ARRAY TEXT:C222(<>aRatingFT; 0)  //Command Replaced was o_ARRAY string length was 10
LIST TO ARRAY:C288("Rating File Types"; <>aRatingFT)

//Rating Categories
ARRAY TEXT:C222(<>aRatCAT; 0)  //Command Replaced was o_ARRAY string length was 25
ARRAY TEXT:C222(<>aRatCode; 0)  //Command Replaced was o_ARRAY string length was 2
LIST TO ARRAY:C288("Rating Categories"; <>aRatCAT)
LIST TO ARRAY:C288("Rating Codes"; <>aRatCode)

//Deficient Categories
//3/17/2001 ASL corrected spelling error
ARRAY TEXT:C222(<>aDefCAT; 0)  //Command Replaced was o_ARRAY string length was 25
ARRAY TEXT:C222(<>aDefCode; 0)  //Command Replaced was o_ARRAY string length was 3
LIST TO ARRAY:C288("Deficiency Categories"; <>aDefCAT)
LIST TO ARRAY:C288("Deficiency Codes"; <>aDefCode)

//Urgency of Repair Categories
//3/17/2001 ASL added these to handle urgency of repair coding
ARRAY TEXT:C222(<>aUORCAT; 0)  //Command Replaced was o_ARRAY string length was 25
ARRAY TEXT:C222(<>aUORCode; 0)  //Command Replaced was o_ARRAY string length was 2
LIST TO ARRAY:C288("Urgency of Repair"; <>aUORCAT)
LIST TO ARRAY:C288("Urgency of Repair Codes"; <>aUORCode)
//End 3/17/2001 ASL modifications

//6/22/2001 - To code insp level in roman numerals
// Modified by: costasmanousakis-(Designer)-(9/10/08 08:58:51) Mods_2008_CM_5404
ARRAY TEXT:C222(<>aInspLevel; 4)  //Command Replaced was o_ARRAY string length was 5
ARRAY INTEGER:C220(<>aInspLevelCod; 4)
For ($i; 1; 4)
	<>aInspLevelCod{$i}:=$i
	<>aInspLevel{$i}:=MATH_ArabicToRoman($i)
End for 
//end of 6/22/2001 code

//Feature intersected codes
// Added 1\10\2000
ARRAY TEXT:C222(<>aFeatDescr; 0)  //Command Replaced was o_ARRAY string length was 5
LIST TO ARRAY:C288("Feat Int Code"; <>aFeatDescr)
$codes:=Size of array:C274(<>aFeatDescr)
ARRAY TEXT:C222(<>aFeatCodes; $codes)  //Command Replaced was o_ARRAY string length was 5
For ($i; 1; $codes)
	<>afeatCodes{$i}:=Substring:C12(<>aFeatDescr{$i}; 1; 5)
End for 

ARRAY TEXT:C222(<>a7FDescr; 0)  //Command Replaced was o_ARRAY string length was 5
LIST TO ARRAY:C288("Facility Carried"; <>a7FDescr)
$codes:=Size of array:C274(<>a7FDescr)
ARRAY TEXT:C222(<>a7FCodes; $codes)  //Command Replaced was o_ARRAY string length was 5
For ($i; 1; $codes)
	<>a7FCodes{$i}:=Substring:C12(<>a7FDescr{$i}; 1; 5)
End for 
// end of code additions 1\10\2000

If (False:C215)
	//Feature intersected codes
	// Added 11\16\2000
	ARRAY TEXT:C222(<>IDaFeatDescr; 0)  //Command Replaced was o_ARRAY string length was 5
	LIST TO ARRAY:C288("Feat Int Code"; <>IDaFeatDescr)
	$codes:=Size of array:C274(<>IDaFeatDescr)
	ARRAY TEXT:C222(<>IDaFeatCodes; $codes)  //Command Replaced was o_ARRAY string length was 5
	For ($i; 1; $codes)
		<>IDafeatCodes{$i}:=Substring:C12(<>IDaFeatDescr{$i}; 1; 5)
	End for 
	
	ARRAY TEXT:C222(<>IDa7FDescr; 0)  //Command Replaced was o_ARRAY string length was 5
	LIST TO ARRAY:C288("Facility Carried"; <>IDa7FDescr)
	$codes:=Size of array:C274(<>IDa7FDescr)
	ARRAY TEXT:C222(<>IDa7FCodes; $codes)  //Command Replaced was o_ARRAY string length was 5
	For ($i; 1; $codes)
		<>IDa7FCodes{$i}:=Substring:C12(<>IDa7FDescr{$i}; 1; 5)
	End for 
	// end of code additions 11\16\2000
	
	//Feature intersected codes
	// Added 11\17\2000
	ARRAY TEXT:C222(<>BINaFeatDescr; 0)  //Command Replaced was o_ARRAY string length was 5
	LIST TO ARRAY:C288("Feat Int Code"; <>BINaFeatDescr)
	$codes:=Size of array:C274(<>BINaFeatDescr)
	ARRAY TEXT:C222(<>BINaFeatCodes; $codes)  //Command Replaced was o_ARRAY string length was 5
	For ($i; 1; $codes)
		<>BINafeatCodes{$i}:=Substring:C12(<>BINaFeatDescr{$i}; 1; 5)
	End for 
	
	ARRAY TEXT:C222(<>BINa7FDescr; 0)  //Command Replaced was o_ARRAY string length was 5
	LIST TO ARRAY:C288("Facility Carried"; <>BINa7FDescr)
	$codes:=Size of array:C274(<>BINa7FDescr)
	ARRAY TEXT:C222(<>BINa7FCodes; $codes)  //Command Replaced was o_ARRAY string length was 5
	For ($i; 1; $codes)
		<>BINa7FCodes{$i}:=Substring:C12(<>BINa7FDescr{$i}; 1; 5)
	End for 
	// end of code additions 11\17\2000
	
End if 

//Item 8 Owner  and Item 8 BridgeCat codes assignment 
// Added 1\26\2001
ARRAY TEXT:C222(<>aIt8OwnerDes; 0)  //Command Replaced was o_ARRAY string length was 50
LIST TO ARRAY:C288("Item8 Owner"; <>aIt8OwnerDes)
$codes:=Size of array:C274(<>aIt8OwnerDes)
ARRAY TEXT:C222(<>aIt8OwnerCode; $codes)  //Command Replaced was o_ARRAY string length was 3
For ($i; 1; $codes)
	<>aIt8OwnerCode{$i}:=Substring:C12(<>aIt8OwnerDes{$i}; 1; 3)
End for 

ARRAY TEXT:C222(<>aIt8BrCatDes; 0)  //Command Replaced was o_ARRAY string length was 50
LIST TO ARRAY:C288("Item8 BridgeCat"; <>aIt8BrCatDes)
$codes:=Size of array:C274(<>aIt8BrCatDes)
ARRAY TEXT:C222(<>aIt8BrCatCode; $codes)  //Command Replaced was o_ARRAY string length was 3
For ($i; 1; $codes)
	<>aIt8BrCatCode{$i}:=Substring:C12(<>aIt8BrCatDes{$i}; 1; 3)
End for 
// end of code additions 1\26\2001

ARRAY TEXT:C222(<>aTempBridge; 0)  //Command Replaced was o_ARRAY string length was 25
ARRAY TEXT:C222(<>aTempBridgeC; 0)  //Command Replaced was o_ARRAY string length was 2
LIST TO ARRAY:C288("TempBridge"; <>aTempBridge)
LIST TO ARRAY:C288("TempBridgeCode"; <>aTempBridgeC)

//```````````````added 8/27/03
ARRAY TEXT:C222(<>aDesign_Scour; 0)  //Command Replaced was o_ARRAY string length was 25
ARRAY TEXT:C222(<>aTrans_Scour; 0)  //Command Replaced was o_ARRAY string length was 2
LIST TO ARRAY:C288("Design_Scour"; <>aDesign_Scour)
LIST TO ARRAY:C288("Trans_Scour"; <>aTrans_Scour)

ARRAY TEXT:C222(<>aDesign_SuperStr; 0)  //Command Replaced was o_ARRAY string length was 40
ARRAY TEXT:C222(<>aTrans_SuperStr; 0)  //Command Replaced was o_ARRAY string length was 3
LIST TO ARRAY:C288("Design_SuperStr"; <>aDesign_SuperStr)
LIST TO ARRAY:C288("Trans_SuperStr"; <>aTrans_SuperStr)

ARRAY TEXT:C222(<>aDesign_Deck; 0)  //Command Replaced was o_ARRAY string length was 40
ARRAY TEXT:C222(<>aTrans_Deck; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(<>aTrans_WearingSurface; 0)  //Command Replaced was o_ARRAY string length was 2
LIST TO ARRAY:C288("Design_Deck"; <>aDesign_Deck)
LIST TO ARRAY:C288("Trans_Deck"; <>aTrans_Deck)
LIST TO ARRAY:C288("Trans_WearingSurface"; <>aTrans_WearingSurface)

ARRAY TEXT:C222(<>aFreezeThawDesc; 0)  //Command Replaced was o_ARRAY string length was 60
ARRAY TEXT:C222(<>aFreezeThawCode; 0)  //Command Replaced was o_ARRAY string length was 2
LIST TO ARRAY:C288("FreezeThaw_List"; <>aFreezeThawDesc)
$codes:=Size of array:C274(<>aFreezeThawDesc)
ARRAY TEXT:C222(<>aFreezeThawCode; $codes)  //Command Replaced was o_ARRAY string length was 2
For ($i; 1; $codes)
	<>aFreezeThawCode{$i}:=Substring:C12(<>aFreezeThawDesc{$i}; 1; 1)
End for 
//%attributes = {"invisible":true}
If (False:C215)
	//P_ListTownAddress
	//October 2, 2003
	Mods_2005_CM12
	
	// Modified by: costasmanousakis-(Designer)-(9/18/2007 11:22:47)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(7/31/08 13:40:07)
	Mods_2008_CM_5404
	//  `Declare the aDistrictSelect array here instead of in the output form load event
	// Modified by: costasmanousakis-(Designer)-(9/17/09 11:41:54)
	Mods_2009_09
	//Added members of the Design Access Group to read write.
	// Modified by: costasmanousakis-(Designer)-(6/23/10 08:11:02)
	Mods_2010_06
	//  `Added members of the BMS Admin to read write.
	Mods_2011_06  // CJ Miller`06/13/11, 17:07:20      ` Type all local variables for v11
	// Modified by: costasmanousakis-(Designer)-(10/17/11 11:18:09)
	Mods_2011_10
	//  `Increased number of districts to 6
	// Modified by: costasmanousakis-(Designer)-(12/12/11 10:00:26)
	Mods_2011_12
	//  `Replace all RW Groups with TownContactRW group and Design Access Group;
	//  `Calculate the number of districts from the information in the [Town Data] table
	Mods_2019_07  //Use list box for output form
	//Modified by: Chuck Miller (7/9/19 14:01:30)
	// Modified by: Costas Manousakis-(Designer)-(4/15/20 11:39:45)
	Mods_2020_04
	//  `switch back to old output form
	Mods_2020_07
	//Modified by: CJ (7/9/20 22:26:03)
	Mods_2020_12  // Modifed to add current method name to ut_UseListBox call
	//Modified by: CJ (12/22/20 14:45:46)
	
End if 
Compiler_LB
C_TEXT:C284($Form_txt)
C_BOOLEAN:C305($useLB_B)
$useLB_B:=ut_UseListBox(Current method name:C684)

If ($useLB_B)
	$Form_txt:="View Town Address_LB"
Else 
	$Form_txt:="View Town Address"
End if 
C_TEXT:C284(MainTitle)  // **Replaced old C_STRING length 255

SHORT_MESSAGE("Retrieving data. Please wait…")
InitProcessVar
pFile:=->[Town Address:78]
READ ONLY:C145(*)
READ WRITE:C146([Activity Log:59])
READ WRITE:C146([Sequences:28])
READ WRITE:C146([Owners of Data:62])
READ ONLY:C145([Town Address:78])
Case of 
	: (User in group:C338(<>CurrentUser_Name; "TownContactRW"))
		READ WRITE:C146([Town Address:78])
	: (User in group:C338(<>CurrentUser_Name; "Design Access Group"))
		READ WRITE:C146([Town Address:78])
End case 

READ ONLY:C145([Town Data:2])
ALL RECORDS:C47([Town Data:2])
ARRAY TEXT:C222($TWNDistricts_as; 0)  // **Replaced old ARRAY STRING length 2
DISTINCT VALUES:C339([Town Data:2]District:6; $TWNDistricts_as)
SORT ARRAY:C229($TWNDistricts_as)
ARRAY TEXT:C222(aDistrictSelect; Size of array:C274($TWNDistricts_as))  // **Replaced old ARRAY STRING length 20
C_LONGINT:C283($i)
For ($i; 1; Size of array:C274($TWNDistricts_as))
	aDistrictSelect{$i}:="Dist "+$TWNDistricts_as{$i}
End for 

aDistrictSelect:=0

MainTitle:="Town Address List"
ALL RECORDS:C47([Town Address:78])
ORDER BY:C49([Town Address:78]; [Town Address:78]TownName:2; >)

FORM SET INPUT:C55([Town Address:78]; "Town Address In")
FORM SET OUTPUT:C54([Town Address:78]; "View Town Address")
C_TEXT:C284($RecSel)  // **Replaced old C_STRING length 10
$RecSel:=String:C10(Records in selection:C76([Town Address:78]))
COPY NAMED SELECTION:C331([Town Address:78]; "UserRegionA")  //save the selection

CLOSE WINDOW:C154  //close message window
C_LONGINT:C283($FmW; $FmHt; $Win_L)
FORM GET PROPERTIES:C674([Town Address:78]; $Form_txt; $FmW; $FmHt)
$Win_L:=ut_OpenNewWindow($FmW; 550; 1; Plain form window:K39:10; MainTitle+" ["+$RecSel+"]"; "ut_CloseCancel")
//NewWindow ($FmW;550;1;Plain window)
SET WINDOW RECT:C444(16; 44; 16+$FmW; 44+550)

UpdatWindArray(""; Current process:C322)
SET WINDOW TITLE:C213(MainTitle+" ["+$RecSel+"]")
SET MENU BAR:C67(3)
If ($useLB_B)
	DIALOG:C40([Town Address:78]; $Form_txt)
Else 
	MODIFY SELECTION:C204([Town Address:78]; *)  //Display output form even for one record
End if 
CLEAR NAMED SELECTION:C333("UserRegionA")
UpdatWindArray(""; Current process:C322)
CLOSE WINDOW:C154
ControlMenuBar(1)
//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// prt_substdrep
	// User name (OS): cjmiller
	// Date and time: 03/29/05, 16:05:57
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CJM02  //03/29/05, 16:06:12 
	Mods_2005_CM16
	// Modified by: ManousakisC (11/1/2005)
	Mods_2005_CM18
	// Modified by: costasmanousakis-(Designer)-(6/6/2006 15:52:34)
	Mods_2006_CMy4
	// Modified by: costasmanousakis-(Designer)-(1/10/2007 14:35:43)
	Mods_2007_CM01
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 11:21:05)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(11/1/09 08:40:33)
	Mods_2009_10("MASSDOT")
	//  `modified to give multiple print form options to designer
	DIALOG:C40([Status Report:69]; "P_StatusReport")
	DIALOG:C40([Status Report:69]; "P_StatusReport_HI")
	DIALOG:C40([Status Report:69]; "P_StatusReport_MDOT")
	DIALOG:C40([Status Report:69]; "P_StatusReport_MDOT_5D")
	DIALOG:C40([Status Report:69]; "P_StatusReport_new")
	DIALOG:C40([Status Report:69]; "P_StatusReport_HI_old")
	DIALOG:C40([Status Report:69]; "P_StatusReport_MDOT_old")
	DIALOG:C40([Status Report:69]; "P_StatusReport_MDOT_5D_old")
	// Modified by: costasmanousakis-(Designer)-(4/22/10 08:48:55)
	Mods_2010_04
	//  `use STATREP_ReportType to determine which is the default form to print when not Designer
	// Modified by: costasmanousakis-(Designer)-(8/2/10 05:35:24)
	Mods_2010_08
	//  `Changed Parameter 1 to Longint to have more than two options of print form selection
	// Modified by: costasmanousakis-(Designer)-(3/7/11 17:49:41)
	Mods_2011_03
	//  `use method STATREP_DefaultPrintForm
	Mods_2011_04  //r002 CJ Miller`04/11/11, 11:06:11      `Add code to delay when on server
	Mods_2011_04  //r002 CJ Miller`04/12/11, 11:59:39      `Change from
	//Get indexed string to substring of date;5 to get 3 character month
	// Modified by: Costas Manousakis-(Designer)-(3/13/13 16:08:53)
	Mods_2013_03
	//  `Added to the list the _old reports
	// Modified by: Costas Manousakis-(Designer)-(10/21/13 13:20:59)
	Mods_2013_10
	//  `Added the default form
	// Modified by: Costas Manousakis-(Designer)-(9/15/16 16:38:16)
	Mods_2016_09
	//  `Added a Set print option(Orientation ;2) before the print form to make sure it is landscape
	// Modified by: Costas Manousakis-(Designer)-(2023-10-06 17:28:35)
	Mods_2023_10
	//  `make sure a Letter size paper is selected from printer 8.5x11 (612x792)
End if 

//GP: prt_substdrep
C_TEXT:C284($printform)  // Command Replaced was o_C_STRING length was 40
C_LONGINT:C283($1; $PrintHIRpt_L)
C_BOOLEAN:C305($2; $Batchmode_b; $ReportModeOn_b)
$ReportModeOn_b:=False:C215
$printform:=""
$PrintHIRpt_L:=0  //use default form
$Batchmode_b:=False:C215

C_TEXT:C284(ReportError_txt)
If (Count parameters:C259>=2)
	$PrintHIRpt_L:=$1
	$Batchmode_b:=$2
End if 
If (Count parameters:C259=3)
	C_TEXT:C284($3; $Filename)
	$Filename:=$3
End if 

Case of 
	: ($PrintHIRpt_L=1)
		$ReportModeOn_b:=True:C214
		$printform:="P_StatusReport_MDOT_5D"
	: ($PrintHIRpt_L=2)
		$ReportModeOn_b:=True:C214
		$printform:="P_StatusReport_HI"
	: ($PrintHIRpt_L=3)
		$printform:="P_StatusReport_MDOT"
		$ReportModeOn_b:=True:C214
		ReportError_txt:=ReportError_txt+$printform+" set "+Char:C90(Carriage return:K15:38)
End case 
If ($printform="")
	C_TEXT:C284($reportType_txt)
	$reportType_txt:=STATREP_ReportType
	$printform:=STATREP_DefaultPrintForm($reportType_txt; [Status Report:69]Date_Created:1)
	C_TEXT:C284($CurUser_txt)
	$CurUser_txt:=Current user:C182
	If (User in group:C338($CurUser_txt; "BMS Admin") & Not:C34($Batchmode_b))
		ARRAY TEXT:C222($ListofForms_atxt; 0)
		APPEND TO ARRAY:C911($ListofForms_atxt; "P_StatusReport")
		APPEND TO ARRAY:C911($ListofForms_atxt; "P_StatusReport_HI")
		APPEND TO ARRAY:C911($ListofForms_atxt; "P_StatusReport_MDOT")
		APPEND TO ARRAY:C911($ListofForms_atxt; "P_StatusReport_MDOT_5D")
		APPEND TO ARRAY:C911($ListofForms_atxt; "P_StatusReport_new")
		APPEND TO ARRAY:C911($ListofForms_atxt; "P_StatusReport_HI_old")
		APPEND TO ARRAY:C911($ListofForms_atxt; "P_StatusReport_MDOT_old")
		APPEND TO ARRAY:C911($ListofForms_atxt; "P_StatusReport_MDOT_5D_old")
		APPEND TO ARRAY:C911($ListofForms_atxt; "P_StatusReport_MDOT_POFA")
		APPEND TO ARRAY:C911($ListofForms_atxt; "P_BRIStatusRpt_MDOT_POFA")
		APPEND TO ARRAY:C911($ListofForms_atxt; $printform+" - Default")
		C_LONGINT:C283($pick_L)
		$pick_L:=G_PickFromList(->$ListofForms_atxt; "Select Print Form - Cancel for "+$printform)
		If ($pick_L>0)
			$printform:=$ListofForms_atxt{$pick_L}
			$printform:=Replace string:C233($printform; " - Default"; "")
		End if 
		
		ARRAY TEXT:C222($ListofForms_atxt; 0)
		
	End if 
	
End if 

//Start changes Mods_2023_10 2023-10-06)
ARRAY TEXT:C222($papers_atxt; 0)
ARRAY LONGINT:C221($pH; 0)
ARRAY LONGINT:C221($pW; 0)

//get the paper names and sizes for current printer
PRINT OPTION VALUES:C785(Paper option:K47:1; $papers_atxt; $pH; $pW)
C_LONGINT:C283($letter_L; $start_L)
$letter_L:=-1
$start_L:=1  //start search at 1
C_BOOLEAN:C305($done_b)
$done_b:=False:C215
Repeat 
	$letter_L:=Find in array:C230($pW; 612; $start_L)  // look for 8.5 W = 612
	
	If ($letter_L>0)
		
		If ($pH{$letter_L}=792)  //if it is 11 H - found it
			$done_b:=True:C214  // done searching
		Else 
			$start_L:=$letter_L+1
		End if 
		
	Else 
		$done_b:=True:C214  // done searching
	End if 
	
Until ($done_b)

If ($letter_L>0)
	SET PRINT OPTION:C733(Paper option:K47:1; $papers_atxt{$letter_L})
End if 

//End changes Mods_2023_10 2023-10-06)

SET PRINT OPTION:C733(Orientation option:K47:2; 2)
SET PRINT OPTION:C733(Scale option:K47:3; 100)


If (Application type:C494#4D Server:K5:6)
	C_TEXT:C284($Filename)
	$Filename:="Bridge Status "+String:C10(Day of:C23([Status Report:69]Date_Created:1); "00")+"-"
	C_TEXT:C284($ReportMonth_txt)
	$ReportMonth_txt:=Substring:C12(String:C10([Status Report:69]Date_Created:1; Internal date long:K1:5); 1; 3)
	$Filename:=$Filename+$ReportMonth_txt+"-"
	$Filename:=$Filename+String:C10(Year of:C25([Status Report:69]Date_Created:1))
	SET PRINT OPTION:C733(Spooler document name option:K47:10; $Filename)
End if 
//PAGE SETUP([Status Report];$printform)
If (Not:C34($Batchmode_b))
	PRINT SETTINGS:C106
	$Batchmode_b:=(OK=1)
Else 
	
End if 
If ($Batchmode_b)
	If ($ReportModeOn_b)
		ReportError_txt:=ReportError_txt+$printform+" print "+" tick:"+String:C10(Tickcount:C458)+"]"+Char:C90(Carriage return:K15:38)
	End if 
	SET PRINT OPTION:C733(Orientation option:K47:2; 2)
	
	Print form:C5([Status Report:69]; $printform)
	If ($ReportModeOn_b)
		ReportError_txt:=ReportError_txt+$printform+" printed "+"OK:"+String:C10(OK)+" tick:"+String:C10(Tickcount:C458)+"]"+Char:C90(Carriage return:K15:38)
	End if 
	
	PAGE BREAK:C6
	If ($ReportModeOn_b)
		ReportError_txt:=ReportError_txt+$printform+" page break "+"OK:"+String:C10(OK)+" tick:"+String:C10(Tickcount:C458)+"]"+Char:C90(Carriage return:K15:38)
	End if 
	C_LONGINT:C283($Count_l)
	$Count_l:=0
	If (Application type:C494=4D Server:K5:6)
		
		Repeat 
			If ($Count_l=0)
				DELAY PROCESS:C323(Current process:C322; 60*10)  //delay 10 seconds
				$Count_l:=1
			Else 
				DELAY PROCESS:C323(Current process:C322; 60*10)  //delay 10 seconds
				$Count_l:=$Count_l+1
			End if 
			
		Until ($Count_l>3) | (Test path name:C476($Filename)=Is a document:K24:1)
		
	End if 
	
	If ($ReportModeOn_b)
		If ($Count_l>0)
			If (Test path name:C476($Filename)=Is a document:K24:1)
				ReportError_txt:=ReportError_txt+"prt_substdrep : Tried to find document "+String:C10($Count_l)+" times "+" tick:"+String:C10(Tickcount:C458)+"]"+Char:C90(Carriage return:K15:38)
				ReportError_txt:=ReportError_txt+$printform+" printed "+" tick:"+String:C10(Tickcount:C458)+"]"+Char:C90(Carriage return:K15:38)
			Else 
				ReportError_txt:=ReportError_txt+"prt_substdrep : Could not find document named "+$Filename+" after "+String:C10($Count_l)+" delays "+" tick:"+String:C10(Tickcount:C458)+"]"+Char:C90(Carriage return:K15:38)
			End if 
		End if 
	End if 
End if 
If (Application type:C494#4D Server:K5:6)
	SET PRINT OPTION:C733(Spooler document name option:K47:10; "")
End if 

//End prt_substdrep
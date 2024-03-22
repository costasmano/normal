// ----------------------------------------------------
// Form Method: QryForm
// User name (OS): cjmiller
// Date and time: 11/02/04, 10:26:24
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2005_CJM01
	Mods_2005_CM04
	Mods_2005_CJM03  //04/19/05, 13:54:12
	Mods_2009_12  // r004 CJ Miller`12/29/09, 15:00:40      ``Add [Bridge MHD NBIS]LegacyOwner to SD Data
	Mods_2009_12  // r004 CJ Miller`12/29/09, 15:43:31      `Add legacy owners to arrays
	Mods_2010_03  //r002 CJ Miller`03/11/10, 15:56:57       `Add code to allow for printing different sections of the report
	
	// Modified by: Costas Manousakis-()-(1/5/12 09:18:07)
	Mods_2012_01
	//  `Added Pulldown to allow selection by District
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		If (Not:C34(Is compiled mode:C492))
			Compiler_SD
		End if 
		<>SD_UseLegacy_l:=0
		<>SD_IncludeALL_l:=0
		
		ARRAY TEXT:C222(aEndMonths; 0)  //Command Replaced was o_ARRAY string length was 10
		COPY ARRAY:C226(<>aMonths; aEndMonths)
		aEndMonths:=0
		<>aMonths:=0
		COPY ARRAY:C226(<>aIt8OwnerDes; aIt8OwnerDes)
		
		COPY ARRAY:C226(<>aIt8OwnerCode; aIt8OwnerCode)
		If (False:C215)
			APPEND TO ARRAY:C911(aIt8OwnerDes; "MHD = Mass. Highway Department")
			APPEND TO ARRAY:C911(aIt8OwnerDes; "MTA = Mass. Turnpike Authority")
			APPEND TO ARRAY:C911(aIt8OwnerCode; "MHD")
			APPEND TO ARRAY:C911(aIt8OwnerCode; "MTA")
		End if 
		SORT ARRAY:C229(aIt8OwnerCode; aIt8OwnerDes; >)
		ARRAY TEXT:C222(aIt8OwnerDesIncluded; 0)  //Command Replaced was o_ARRAY string length was 50
		ARRAY TEXT:C222(aIt8OwnerDesIncludedCode; 0)  //Command Replaced was o_ARRAY string length was 3
		If (Is compiled mode:C492)
			If (Size of array:C274(<>SD_BYears_as)=0)
				ALL RECORDS:C47([SD_History:89])
				DISTINCT VALUES:C339([SD_History:89]SD_Year:2; <>SD_BYears_as)
			End if 
		Else 
			ARRAY TEXT:C222(<>SD_BYears_as; 0)  //Command Replaced was o_ARRAY string length was 4
			ALL RECORDS:C47([SD_History:89])
			DISTINCT VALUES:C339([SD_History:89]SD_Year:2; <>SD_BYears_as)
		End if 
		COPY ARRAY:C226(<>SD_BYears_as; <>SD_EYears_as)
		<>SD_BYears_as:=Size of array:C274(<>SD_BYears_as)
		<>SD_EYears_as:=<>SD_BYears_as
		C_LONGINT:C283($EndMonthChoice_l; $BegMonthChoice_l)
		$EndMonthChoice_l:=Month of:C24(Current date:C33(*))
		
		If ($EndMonthChoice_l>6)
			$BegMonthChoice_l:=6
		Else 
			$BegMonthChoice_l:=$EndMonthChoice_l-1
			If ($BegMonthChoice_l=0)
				$BegMonthChoice_l:=12
				<>SD_BYears_as:=<>SD_BYears_as-1
			End if 
		End if 
		<>aMonths:=$BegMonthChoice_l
		aEndMonths:=$EndMonthChoice_l
		<>SD_EndYear_s:=<>SD_EYears_as{<>SD_EYears_as}
		<>SD_BeginYear_s:=<>SD_BYears_as{<>SD_BYears_as}
		<>SD_BeginMonth_s:=String:C10(<>aMonths; "00")
		<>SD_EndMonth_s:=String:C10(aEndMonths; "00")
		OBJECT SET ENTERABLE:C238(<>SD_Filename_txt; False:C215)
		OBJECT SET VISIBLE:C603(<>SD_Filename_txt; False:C215)
		<>SD_PrintHistory_l:=1
		<>SD_PrintPosted_l:=1
End case 
//End Form Method: QryForm

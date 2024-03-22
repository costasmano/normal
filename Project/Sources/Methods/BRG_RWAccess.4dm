//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/04/08, 11:58:10
	// ----------------------------------------------------
	// Method: BRG_RWAccess
	// Description
	// Determine RW access to any of the current bridge record information.
	// 
	// Parameters
	// $0 : $Access_b
	// ----------------------------------------------------
	
	Mods_2008_CM_5403
	// Modified by: costasmanousakis-(Designer)-(12/1/09 14:31:38)
	Mods_2009_11
	//fixed the MDC security
	// Modified by: costasmanousakis-(Designer)-(3/8/10 08:40:59)
	Mods_2010_03
	//  `Adjusted security so that users in BMS Admin get RW access to the Bridge info
	// Modified by: costasmanousakis-(Designer)-(9/2/10 15:48:36)
	Mods_2010_09
	//  `Use method BMSUtil_BelongToBridge for MDC users
	// Modified by: costasmanousakis-(Designer)-(11/1/11 14:51:09)
	Mods_2011_10
	//  `Added a case for MBTA users
	// Modified by: Costas Manousakis-(Designer)-(11/12/14 13:25:17)
	Mods_2014_11
	//  `if the userr belongs to the readOnly group then they dont;t have access
End if 
C_BOOLEAN:C305($0; $Access_b)

$Access_b:=True:C214
C_TEXT:C284($MyBridges_txt)
C_TEXT:C284($currUser_txt)
$currUser_txt:=<>CurrentUser_Name

If (False:C215)
	If (User in group:C338($currUser_txt; "Access Level 1"))
		$Access_b:=False:C215
		$MyBridges_txt:=""
		Case of 
			: (User in group:C338($currUser_txt; "MDC"))
				$MyBridges_txt:="MDC"
			: (User in group:C338($currUser_txt; "MBTA"))
				$MyBridges_txt:="MBTA"
			: (User in group:C338($currUser_txt; "MTA"))
				$MyBridges_txt:="MTA"
			: (User in group:C338($currUser_txt; "District @"))
				$MyBridges_txt:="DIST@"
		End case 
		$Access_b:=([Bridge MHD NBIS:1]InspResp:173=$MyBridges_txt)
	End if 
Else 
	If (User in group:C338($currUser_txt; "BMS Admin"))
		
	Else 
		Case of 
			: (User in group:C338($currUser_txt; "MDC"))
				$Access_b:=BMSUtil_BelongToBridge($CurrUser_txt; [Bridge MHD NBIS:1]InspResp:173)
				
			: (User in group:C338($currUser_txt; "MBTA"))
				$Access_b:=BMSUtil_BelongToBridge($CurrUser_txt; [Bridge MHD NBIS:1]InspResp:173)
		End case 
		
	End if 
	
End if 

$Access_b:=$Access_b & Not:C34(User in group:C338($CurrUser_txt; "ReadOnly"))

$0:=$Access_b
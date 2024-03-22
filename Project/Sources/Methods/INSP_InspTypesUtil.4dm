//%attributes = {"invisible":true}
// Method: INSP_InspTypesUtil
// Description
//  ` Utility method
//  ` Parameters
//  ` $1 : $Task_txt ("LOADFROMDATA" | "SAVETODATA" | "LOADTYPES" | "CLEAR")
// ----------------------------------------------------
If (False:C215)
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 11/02/12, 17:44:28
	// ----------------------------------------------------
	// First Release
	Mods_2012_11
End if 

C_TEXT:C284($Task_txt)
C_TEXT:C284($0)
C_TEXT:C284($errmsg_txt)

If (Count parameters:C259>0)
	C_TEXT:C284($1; $Task_txt)
	$Task_txt:=$1
Else 
	$Task_txt:="SAVETODATA"
End if 
$0:=""

C_TEXT:C284(INSP_INSPTYPESBYRESPTREE_txt)

Case of 
	: ($Task_txt="SAVETODATA")
		C_TEXT:C284(vsforward)  // Command Replaced was o_C_STRING length was 80
		C_TEXT:C284($Tree_txt; $RowTree_txt; $TheDom_txt; $TypesTree_txt)
		$Tree_txt:=DOM Create XML Ref:C861("INSP_INSPTYPES")
		$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "MBTA")
		DOM SET XML ATTRIBUTE:C866($RowTree_txt; "RESP"; "MBTA")
		DOM SET XML ELEMENT VALUE:C868($RowTree_txt; "RRR;RTN;RTA;CUL;FCR;CMI;OTH;CLD;DAM;FRZ")
		
		$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "DOT")
		DOM SET XML ATTRIBUTE:C866($RowTree_txt; "RESP"; "DOT")
		DOM SET XML ELEMENT VALUE:C868($RowTree_txt; "RTN;RTA;CUL;FCR;CMI;OTH;CLD;DAM;FRZ;DVE;DVL;DVS")
		
		$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "DIST1")
		DOM SET XML ATTRIBUTE:C866($RowTree_txt; "RESP"; "DIST1")
		DOM SET XML ELEMENT VALUE:C868($RowTree_txt; "RTN;RTA;CUL;FCR;CMI;OTH;CLD;DAM;FRZ;DVE;DVL;DVS")
		
		$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "DIST2")
		DOM SET XML ATTRIBUTE:C866($RowTree_txt; "RESP"; "DIST2")
		DOM SET XML ELEMENT VALUE:C868($RowTree_txt; "RTN;RTA;CUL;FCR;CMI;OTH;CLD;DAM;FRZ;DVE;DVL;DVS")
		
		$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "DIST3")
		DOM SET XML ATTRIBUTE:C866($RowTree_txt; "RESP"; "DIST3")
		DOM SET XML ELEMENT VALUE:C868($RowTree_txt; "RTN;RTA;CUL;FCR;CMI;OTH;CLD;DAM;FRZ;DVE;DVL;DVS")
		
		$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "DIST4")
		DOM SET XML ATTRIBUTE:C866($RowTree_txt; "RESP"; "DIST4")
		DOM SET XML ELEMENT VALUE:C868($RowTree_txt; "RTN;RTA;CUL;FCR;CMI;OTH;CLD;DAM;FRZ;DVE;DVL;DVS")
		
		$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "DIST5")
		DOM SET XML ATTRIBUTE:C866($RowTree_txt; "RESP"; "DIST5")
		DOM SET XML ELEMENT VALUE:C868($RowTree_txt; "RTN;RTA;CUL;FCR;CMI;OTH;CLD;DAM;FRZ;DVE;DVL;DVS")
		
		$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "DIST6")
		DOM SET XML ATTRIBUTE:C866($RowTree_txt; "RESP"; "DIST6")
		DOM SET XML ELEMENT VALUE:C868($RowTree_txt; "RTN;RTA;CUL;FCR;CMI;OTH;CLD;DAM;FRZ;DVE;DVL;DVS")
		
		$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "MPA")
		DOM SET XML ATTRIBUTE:C866($RowTree_txt; "RESP"; "MPA")
		DOM SET XML ELEMENT VALUE:C868($RowTree_txt; "RTN;RTA;CUL;FCR;CMI;OTH;CLD;DAM;FRZ")
		
		DOM EXPORT TO VAR:C863($Tree_txt; $TheDom_txt)
		
		QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="INSP_INSPTYPES")
		If (Records in selection:C76([Parameters:107])=1)
			If (ut_LoadRecordInteractiveV2(->[Parameters:107])=1)
				[Parameters:107]Description:2:=$TheDom_txt
				LogChanges(->[Parameters:107]Description:2; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
				SAVE RECORD:C53([Parameters:107])
			End if 
		Else 
			CREATE RECORD:C68([Parameters:107])
			[Parameters:107]ParamCode:1:="INSP_INSPTYPES"
			[Parameters:107]Description:2:=$TheDom_txt
			LogNewRecord(->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0; "")
			LogChanges(->[Parameters:107]Description:2; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
			SAVE RECORD:C53([Parameters:107])
		End if 
		
		DOM CLOSE XML:C722($Tree_txt)
		
	: ($Task_txt="LOADFROMDATA")
		
		$paramValue_txt:=ut_GetSysParameter("INSP_INSPTYPES")
		ON ERR CALL:C155("XMLErrorHandler")
		XMLError_b:=False:C215
		INSP_INSPTYPESBYRESPTREE_txt:=DOM Parse XML variable:C720($paramValue_txt)
		
		If (XMLError_b)
			$errmsg_txt:="Error loading database parameter INSP_INSPTYPES : Allowed Inspection types by Agency."+Char:C90(13)
			$errmsg_txt:=$errmsg_txt+"Error :"+String:C10(XMLErrorNumbers_al{1})+" : "+XML_InternalDescriptions_atxt{1}
			ALERT:C41($errmsg_txt)
		End if 
		
		ON ERR CALL:C155("")
		
	: ($Task_txt="LOADTYPES")
		C_TEXT:C284($InspResp_txt)
		XMLError_b:=False:C215
		If (INSP_INSPTYPESBYRESPTREE_txt="")
			INSP_InspTypesUtil("LOADFROMDATA")
		End if 
		If (Not:C34(XMLError_b))
			If (Count parameters:C259>1)
				C_TEXT:C284($2; $InspResp_txt; $paramValue_txt; $DomTree_txt; $elemeRef_txt; $InspTypesList_txt)
				$InspResp_txt:=$2
			Else 
				$InspResp_txt:="DOT"
			End if 
			C_TEXT:C284($paramValue_txt; $elemeRef_txt; $InspTypesList_txt)
			ARRAY TEXT:C222($InspTypes_atxt; 0)
			ON ERR CALL:C155("XMLErrorHandler")
			$elemeRef_txt:=DOM Find XML element:C864(INSP_INSPTYPESBYRESPTREE_txt; "INSP_INSPTYPES/"+$InspResp_txt; $InspTypes_atxt)
			If (Not:C34(XMLError_b))
				DOM GET XML ELEMENT VALUE:C731($elemeRef_txt; $InspTypesList_txt)
				
				If (Not:C34(XMLError_b))
					$0:=$InspTypesList_txt
				Else 
					$errmsg_txt:="Error loading database parameter INSP_INSPTYPES : Allowed Inspection types by Agency."+Char:C90(13)
					$errmsg_txt:=$errmsg_txt+"Error :"+String:C10(XMLErrorNumbers_al{1})+" : "+XML_InternalDescriptions_atxt{1}
					ALERT:C41($errmsg_txt)
				End if 
				
			Else 
				$errmsg_txt:="Error searching for  ["+$InspResp_txt+"] in database parameter INSP_INSPTYPES : Allowed Inspection types by Agency."+Char:C90(13)
				$errmsg_txt:=$errmsg_txt+"Error :"+String:C10(XMLErrorNumbers_al{1})+" : "+XML_InternalDescriptions_atxt{1}
				ALERT:C41($errmsg_txt)
			End if 
			ON ERR CALL:C155("")
		Else 
			$errmsg_txt:="Error retrieving inspection type list for ["+$InspResp_txt+"] in database parameter INSP_INSPTYPES : Allowed Inspection types by Agency."+Char:C90(13)
			$errmsg_txt:=$errmsg_txt+"Error :"+String:C10(XMLErrorNumbers_al{1})+" : "+XML_InternalDescriptions_atxt{1}
			ALERT:C41($errmsg_txt)
		End if 
		
	: ($Task_txt="CLEAR")
		
		ON ERR CALL:C155("XMLErrorHandler")
		XMLError_b:=False:C215
		DOM CLOSE XML:C722(INSP_INSPTYPESBYRESPTREE_txt)
		ON ERR CALL:C155("")
End case 
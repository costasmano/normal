//%attributes = {"invisible":true}
// Method: HI_CalcBridgeHI
// Description
// Calculate the Health Index of the Current Bridge record.
// for MADOT bridges use only DBIE approved records. For others use any
// Parameters
// $0 : Real : Health Index
// $1 : $vp_TotBrgVal : pointer to variable to receive the total bridge value
// $2 : $vp_CurBrgVal : pointer to variable to receive the current bridge value

If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/10/05, 18:57:13
	// ----------------------------------------------------
	// ----------------------------------------------------
	Mods_2005_CM18
	// Modified by: costasmanousakis-(Designer)-(12/1/2006 17:48:45)
	Mods_2006_CM07
	// Modified by: costasmanousakis-(Designer)-(5/3/10 10:35:34)
	Mods_2010_05
	//  `Added CMI - Special member inspections in the list. - use method HI_CalcInspectionHI
	// Modified by: Costas Manousakis-(Designer)-(9/24/19 16:59:13)
	Mods_2019_09_bug
	//  `Fix calculation of HI : use the NBE or CoRE depending on the inspection date - CallReference #660
	//  `For NBEs , if there is no total value stored in the [BMS Inspections] table, do a calculation based
	//  `on table [PON_ELEM_INSP] ;  Set all tables to RO
End if 
C_REAL:C285($0; $vr_HI)
C_POINTER:C301($1; $2; $vp_TotBrgVal; $vp_CurBrgVal)
$vp_TotBrgVal:=$1
$vp_CurBrgVal:=$2
$vr_HI:=0

C_BLOB:C604($SaveRO_state_x)
$SaveRO_state_x:=ut_db_SaveROState
READ ONLY:C145(*)

RELATE MANY:C262([Bridge MHD NBIS:1]BIN:3)
Case of 
	: ([Bridge MHD NBIS:1]InspResp:173="DIST@")
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InspReviewed:12=BMS Approved)
	: ([Bridge MHD NBIS:1]InspResp:173#"DIST@")
		
End case 
QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6="RT@"; *)
QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]Insp Type:6="CUL"; *)
QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]Insp Type:6="CMI"; *)
QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]Insp Type:6="OTH"; *)
QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]Insp Type:6="PON")
RELATE MANY SELECTION:C340([Combined Inspections:90]NBISInspID:2)
RELATE ONE SELECTION:C349([Combined Inspections:90]; [BMS Inspections:44])
ORDER BY:C49([BMS Inspections:44]; [BMS Inspections:44]Insp Date:4; <)
C_LONGINT:C283($numBMSINSPs_L; $i; $ValidBMSInspRecID_L)
$numBMSINSPs_L:=Records in selection:C76([BMS Inspections:44])
$ValidBMSInspRecID_L:=-1
If ($numBMSINSPs_L>0)
	FIRST RECORD:C50([BMS Inspections:44])
	
	For ($i; 1; $numBMSINSPs_L)
		
		
		If (True:C214)
			
			If (PON_NBEDateOn_b([BMS Inspections:44]Insp Date:4))
				
				//use NBE values calculated already if available
				
				If ([BMS Inspections:44]INSP_TotV:16>0)  //anything over 0 means it has been calculated
					$vr_HI:=[BMS Inspections:44]INSP_HI:15
					$vp_TotBrgVal->:=[BMS Inspections:44]INSP_TotV:16
					$vp_CurBrgVal->:=[BMS Inspections:44]INSP_CurrV:17
					$i:=$numBMSINSPs_L+1  // and exit bms inspection loop
				Else 
					//need to calculate it 
					C_LONGINT:C283($NBI_InspID_L)
					$ValidBMSInspRecID_L:=[BMS Inspections:44]Inspection ID:1
					Begin SQL
						select [Combined Inspections].NBISInspID
						from [Combined Inspections]
						where [Combined Inspections].BMSInspID = :$ValidBMSInspRecID_L
						into :$NBI_InspID_L ;
						
					End SQL
					
					$vr_HI:=PON_CalcInspectionHI($NBI_InspID_L; $vp_TotBrgVal; $vp_CurBrgVal)
					If (($vp_TotBrgVal->)>0)
						//found valid data
						$i:=$numBMSINSPs_L+1  // and exit bms inspection loop
						
					Else 
						// keep searching for inspections
						NEXT RECORD:C51([BMS Inspections:44])
					End if 
					
				End if 
				
			Else 
				// use the CoRE elements
				QUERY:C277([Cond Units:45]; [Cond Units:45]Inspection ID:2=[BMS Inspections:44]Inspection ID:1)
				If (Records in selection:C76([Cond Units:45])>0)
					$i:=$numBMSINSPs_L+1  // exit inspection loop
					$ValidBMSInspRecID_L:=[BMS Inspections:44]Inspection ID:1
					$vr_HI:=HI_CalcInspectionHI($ValidBMSInspRecID_L; $vp_TotBrgVal; $vp_CurBrgVal)
					
				Else 
					NEXT RECORD:C51([BMS Inspections:44])
				End if 
				
			End if 
			
		Else 
			
			QUERY:C277([Cond Units:45]; [Cond Units:45]Inspection ID:2=[BMS Inspections:44]Inspection ID:1)
			If (Records in selection:C76([Cond Units:45])>0)
				$i:=$numBMSINSPs_L+1
				$ValidBMSInspRecID_L:=[BMS Inspections:44]Inspection ID:1
				
			Else 
				NEXT RECORD:C51([BMS Inspections:44])
			End if 
		End if 
		
	End for 
	
End if 

If (True:C214)
	
Else 
	$vr_HI:=HI_CalcInspectionHI($ValidBMSInspRecID_L; $vp_TotBrgVal; $vp_CurBrgVal)
	
End if 

ut_db_RestoreROState($SaveRO_state_x)

$0:=$vr_HI
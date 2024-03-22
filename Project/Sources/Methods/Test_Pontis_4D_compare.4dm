//%attributes = {"invisible":true}
// Method: Test_Pontis_4D_compare
// Description
//Test comparing inspection data between the pontis db and the Boston server
// to match inspections in 4D with inspections in Pontis to get the INSPKEY
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 10/11/16, 17:37:59
	// ----------------------------------------------------
	// First Release
	Mods_2016_10
End if 


//SQL LOGIN("";"";"";*)
//SQL LOGIN("ODBC:pon_sq_32";"pontis";"pontis";*)
SQL LOGIN:C817("ODBC:pontis"; "pontis"; "pontis"; *)

ARRAY TEXT:C222(Bridgekey; 0)
ARRAY TEXT:C222(BridgeID; 0)
ARRAY TEXT:C222(BridgeStrNum; 0)
ARRAY TEXT:C222(BridgeGroup; 0)
ARRAY TEXT:C222(InspKey; 0)
ARRAY TEXT:C222(InspDateText; 0)
ARRAY DATE:C224(InspDate_ad; 0)
ARRAY TEXT:C222(INSPNAME; 0)
ARRAY LONGINT:C221(NBINSPDONE; 0)
ARRAY LONGINT:C221(ELINSPDONE; 0)
ARRAY LONGINT:C221(UWINSPDONE; 0)
ARRAY LONGINT:C221(FCINSPDONE; 0)
ARRAY LONGINT:C221(OSINSPDONE; 0)
ARRAY LONGINT:C221(PontisCUCount; 0)

//, cast(INSPEVNT.INSPDATE as text)
C_LONGINT:C283($startTick_L; $EndTick_L)
$startTick_L:=Tickcount:C458

Begin SQL
	SELECT BRIDGE.BRKEY
	, BRIDGE.BRIDGE_ID
	, BRIDGE.STRUCT_NUM
	, BRIDGE.BRIDGEGROUP
	, INSPEVNT.INSPKEY
	, INSPEVNT.INSPDATE
	, (select COUNT(*) from
	[ELEMINSP]
	where [ELEMINSP].INSPKEY = [INSPEVNT].INSPKEY
	and [ELEMINSP].BRKEY = [INSPEVNT].BRKEY )as ThisCount
	
	FROM Pontis.dbo.BRIDGE BRIDGE, Pontis.dbo.INSPEVNT INSPEVNT
	WHERE BRIDGE.BRKEY = INSPEVNT.BRKEY
	into :Bridgekey
	, :BridgeID
	, :BridgeStrNum
	, :BridgeGroup
	, :InspKey
	, :InspDate_ad
	, :PontisCUCount
	;
End SQL
$EndTick_L:=Tickcount:C458

SQL LOGOUT:C872

ALERT:C41("Retrieved "+String:C10(Size of array:C274(InspKey))+" records in "+String:C10($EndTick_L-$startTick_L)+" ticks! ")
//check for multiple inspkeys with same date

MULTI SORT ARRAY:C718(BridgeID; >; InspDate_ad; >; Bridgekey; BridgeStrNum; BridgeGroup; InspKey)
C_LONGINT:C283($loop_L)
C_TEXT:C284($MultKeys_txt)
For ($loop_L; 2; Size of array:C274(InspKey))
	
	If ((BridgeID{$loop_L-1}=BridgeID{$loop_L}) & (InspDate_ad{$loop_L-1}=InspDate_ad{$loop_L}))
		$MultKeys_txt:=$MultKeys_txt+"BIN :"+BridgeID{$loop_L-1}+" Date :"+String:C10(InspDate_ad{$loop_L-1})+"  PrevKey :"+InspKey{$Loop_L-1}+"  thisKey :"+InspKey{$loop_L}
		$MultKeys_txt:=$MultKeys_txt+" PrevCount :"+String:C10(PontisCUCount{$loop_L-1})+" ThisCount :"+String:C10(PontisCUCount{$loop_L})+Char:C90(13)
	End if 
	
End for 

ut_BigAlert($MultKeys_txt)

//log in to boston server
//ALERT("connect to boston server")
ARRAY TEXT:C222(BMSBIN; 0)
ARRAY LONGINT:C221(BMSInspID; 0)
ARRAY DATE:C224(BMSInspDate; 0)
ARRAY TEXT:C222(BMSInspType; 0)
ARRAY LONGINT:C221(BmsNBEID; 0)
ARRAY LONGINT:C221(BmsComplete; 0)
ARRAY LONGINT:C221(BmsReviewed; 0)
ARRAY LONGINT:C221(BmsApproved; 0)
ARRAY LONGINT:C221(BMSBMSInspID; 0)

SQL LOGIN:C817("IP:146.243.135.242:19812"; "designer"; "caesar"; *)

If (OK=1)
	
	$startTick_L:=Tickcount:C458
	//[PON_ELEM_INSP]INSPID
	//[PON_ELEM_INSP]ELEMID
	//[PON_ELEM_INSP]
	Begin SQL
		select
		[Inspections].BIN
		, [Inspections].InspID
		, [Inspections].[Insp Date]
		, [Inspections].[Insp Type]
		, cast([Inspections].InspComplete AS INT)
		, [Inspections].InspReviewed
		, [Inspections].InspApproved
		/*
		, (select count(*) from  [PON_ELEM_INSP] where  [PON_ELEM_INSP].INSPID = [Inspections].InspID)
		*/
		/* */
		, [PON_ELEM_INSP].ELEMID
		, [Combined Inspections].BMSInspID
		/* */
		from [inspections]
		/* */
		, [PON_ELEM_INSP]
		, [Combined Inspections]
		where
		[PON_ELEM_INSP].INSPID = [Inspections].InspID
		and 
		[Combined Inspections].NBISInspID =  [Inspections].InspID
		/*   */
		into
		:BMSBIN
		, :BMSInspID
		, :BMSInspDate
		, :BMSInspType
		, :BmsComplete
		, :BmsReviewed
		, :BmsApproved
		, :BmsNBEID
		, :BMSBMSInspID
		;
		
	End SQL
	
	$EndTick_L:=Tickcount:C458
	
	SQL LOGOUT:C872
	
	ALERT:C41("Retrieved "+String:C10(Size of array:C274(BMSInspID))+" NBE records in "+String:C10($EndTick_L-$startTick_L)+" ticks! ")
	
	//check to see if we have all NBE inspections in pontis db
	C_LONGINT:C283($loop_L; $BInFound_L; $DateFound_L)
	C_BOOLEAN:C305($Done_b; $EndBINSearch_b)
	C_TEXT:C284($NBE_InspKey_txt)
	$MultKeys_txt:=""
	SHORT_MESSAGE("scanning "+String:C10(Size of array:C274(BmsNBEID))+" NBEs")
	C_BOOLEAN:C305($InspDateMatch_b)
	For ($loop_L; 1; Size of array:C274(BmsNBEID))
		$Done_b:=False:C215
		$BInFound_L:=0
		$NBE_InspKey_txt:=""
		QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=BMSBIN{$loop_L})
		
		If (($loop_L%100)=0)
			MESSAGE:C88(String:C10($loop_L)+"..")
		End if 
		
		If ([Bridge MHD NBIS:1]FHWARecord:174)
			
			Repeat 
				$BInFound_L:=Find in array:C230(BridgeID; BMSBIN{$loop_L}; $BInFound_L+1)
				
				If ($BInFound_L<1)
					//BIN not found!!
					$Done_b:=True:C214  //done with this NBE
				Else 
					$InspDateMatch_b:=(BMSInspDate{$loop_L}=InspDate_ad{$BInFound_L})
					$InspDateMatch_b:=$InspDateMatch_b | ((Month of:C24(BMSInspDate{$loop_L})=Month of:C24(InspDate_ad{$BInFound_L})) & (Year of:C25(BMSInspDate{$loop_L})=Year of:C25(InspDate_ad{$BInFound_L})))
					If ($InspDateMatch_b)
						//Found date`
						$Done_b:=True:C214  //done with this NBE
						$NBE_InspKey_txt:=InspKey{$BInFound_L}
					Else 
						//have to search to check all other dates
						$BInFound_L:=Find in array:C230(BridgeID; BMSBIN{$loop_L}; $BInFound_L+1)
						$EndBINSearch_b:=False:C215
						Repeat 
							
							If ($BInFound_L<1)
								//no more BIN !!
								$EndBINSearch_b:=True:C214
								$Done_b:=True:C214  //done with this NBE
							Else 
								//check date
								$InspDateMatch_b:=(BMSInspDate{$loop_L}=InspDate_ad{$BInFound_L})
								$InspDateMatch_b:=$InspDateMatch_b | ((Month of:C24(BMSInspDate{$loop_L})=Month of:C24(InspDate_ad{$BInFound_L})) & (Year of:C25(BMSInspDate{$loop_L})=Year of:C25(InspDate_ad{$BInFound_L})))
								
								If ($InspDateMatch_b)
									//found it!
									$EndBINSearch_b:=True:C214
									$Done_b:=True:C214  //done with this NBE
									$NBE_InspKey_txt:=InspKey{$BInFound_L}
								Else 
									//search again
									$BInFound_L:=Find in array:C230(BridgeID; BMSBIN{$loop_L}; $BInFound_L+1)
									
								End if 
								
							End if 
							
						Until ($EndBINSearch_b)
						
					End if 
					
				End if 
				
			Until ($done_b)
			
			C_TEXT:C284($msg_txt)
			If ($NBE_InspKey_txt="")
				//did not find 
				$msg_txt:="For BIN :"+BMSBIN{$loop_L}+" insp date :"+String:C10(BMSInspDate{$loop_L})+" Type :"+BMSInspType{$loop_L}+" no matching inspection!"
				
				If (Position:C15($msg_txt; $MultKeys_txt)<1)
					$MultKeys_txt:=$MultKeys_txt+$msg_txt+" BMSInspID :"+String:C10(BMSBMSInspID{$loop_L})+" Complete :"+String:C10(BmsComplete{$loop_L})+" Review :"+String:C10(BmsReviewed{$loop_L})+" approve :"+String:C10(BmsApproved{$loop_L})+Char:C90(13)
				End if 
				
			End if 
			
		Else 
			//dont't care about non-nbi bridges yet....
		End if 
		
	End for 
	CLOSE WINDOW:C154
Else 
	ALERT:C41("did not connect!!!!")
End if 

ut_BigAlert($MultKeys_txt)

ARRAY TEXT:C222(BMSBIN; 0)
ARRAY LONGINT:C221(BMSInspID; 0)
ARRAY DATE:C224(BMSInspDate; 0)
ARRAY TEXT:C222(BMSInspType; 0)
ARRAY LONGINT:C221(BmsNBEID; 0)

ARRAY TEXT:C222(Bridgekey; 0)
ARRAY TEXT:C222(BridgeID; 0)
ARRAY TEXT:C222(BridgeStrNum; 0)
ARRAY TEXT:C222(BridgeGroup; 0)
ARRAY TEXT:C222(InspKey; 0)
ARRAY TEXT:C222(InspDateText; 0)
ARRAY DATE:C224(InspDate_ad; 0)
ARRAY TEXT:C222(INSPNAME; 0)
ARRAY LONGINT:C221(NBINSPDONE; 0)
ARRAY LONGINT:C221(ELINSPDONE; 0)
ARRAY LONGINT:C221(UWINSPDONE; 0)
ARRAY LONGINT:C221(FCINSPDONE; 0)
ARRAY LONGINT:C221(OSINSPDONE; 0)

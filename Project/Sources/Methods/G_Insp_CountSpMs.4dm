//%attributes = {"invisible":true}
// Method: G_Insp_CountSpMs
// Description
// 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// Modified by: Costas Manousakis-(Designer)-(4/26/19 14:16:40)
	Mods_2019_04
	//  `use BEGIN SQL to count the spec memb elements
End if 

C_LONGINT:C283($0; $vlNumElmts)
If (False:C215)
	COPY NAMED SELECTION:C331([ElementsSafety:29]; "ElmtsSafetyPreCount")
	QUERY:C277([ElementsSafety:29]; [ElementsSafety:29]InspID:4=[Inspections:27]InspID:2)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $vlNumElmts)
	QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]SpecMemb Flag:8=True:C214; *)
	QUERY SELECTION:C341([ElementsSafety:29];  & ; [ElementsSafety:29]Rating:2#"N"; *)
	QUERY SELECTION:C341([ElementsSafety:29];  & ; [ElementsSafety:29]Rating:2#" "; *)
	QUERY SELECTION:C341([ElementsSafety:29];  & ; [ElementsSafety:29]Rating:2#"")
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	
	//$vlNumElmts:=Records in set("SpecMembElmts")
	//CLEAR SET("SpecMembElmts")
	USE NAMED SELECTION:C332("ElmtsSafetyPreCount")
	CLEAR NAMED SELECTION:C333("ElmtsSafetyPreCount")
Else 
	C_LONGINT:C283($inspID_L)
	$inspID_L:=[Inspections:27]InspID:2
	Begin SQL
		select count(*)
		from [ElementsSafety]
		where [ElementsSafety].[inspid]= :$inspID_L
		and [ElementsSafety].[Rating] <> 'N'
		and [ElementsSafety].[Rating] <> ' '
		and [ElementsSafety].[Rating] <> ''
		and cast([ElementsSafety].[SpecMemb Flag] as INT) = 1
		into :$vlNumElmts ;
	End SQL
End if 
$0:=$vlNumElmts
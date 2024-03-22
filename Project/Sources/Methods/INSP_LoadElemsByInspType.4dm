//%attributes = {"invisible":true}
//Method: INSP_LoadElemsByInspType
//Description
// define a process object containing element definitions by inspection type for use in reports and listboxes
// where multiple inspection types are presented. Creates/updates process objects INSP_InspTypeElems
// INSP_InspTypeElems {
//    "RRR"    : attribute same as inspection type 
//          {  : object
//            { , , } : "ElemIDs" longinteger array of element numbers match to field [ElementDict]ElementNo
//            { , , } : "ElemLabels" text array of element numbers as printed on forms ie 1, 2, 1.a etc.
//          }
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2021-12-27  12:42:11
	// ----------------------------------------------------
	//Created : 
	Mods_2021_12_bug
End if 
//

C_OBJECT:C1216(INSP_InspTypeElems_o)

ARRAY TEXT:C222($inspTypes_atxt; 0)

Begin SQL
	select [Inspection Type].[Code]
	from [Inspection Type]
	into :$inspTypes_atxt ;
End SQL

C_OBJECT:C1216($ElemData_o; $seed_o)
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($inspTypes_atxt))
	INSP_LoadElmLabelsforReport($inspTypes_atxt{$loop_L})
	$ElemData_o:=OB Copy:C1225($seed_o)
	OB SET ARRAY:C1227($ElemData_o; "ElemIDs"; INSP_NewElementNumbers_ai)
	OB SET ARRAY:C1227($ElemData_o; "ElemLabels"; INSP_NewElementLabels_atxt)
	OB SET:C1220(INSP_InspTypeElems_o; $inspTypes_atxt{$loop_L}; $ElemData_o)
	
End for 

//End INSP_LoadElemsByInspType
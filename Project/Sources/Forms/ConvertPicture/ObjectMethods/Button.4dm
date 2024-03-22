
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 05/13/16, 11:35:42
//----------------------------------------------------
//Method: Object Method: ConvertPicture.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_05  // 
	//Modified by: administrator (5/13/16 11:35:45)
	
End if 


If (CNV_End_d<CNV_Start_d)
Else 
	ARRAY LONGINT:C221($InspectionIDs_aL; 0)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	QUERY:C277([Inspections:27]; [Inspections:27]Insp Date:78>=CNV_Start_d; *)
	QUERY:C277([Inspections:27];  & [Inspections:27]Insp Date:78<=CNV_End_d)
	SELECTION TO ARRAY:C260([Inspections:27]InspID:2; $InspectionIDs_aL)
	
	//
	//Begin SQL
	//select
	//[Inspections].[InspID]
	//from [Inspections]
	//where
	//[Inspections].[Insp Date]  >= :CNV_Start_d
	//and
	//[Inspections].[Insp Date] <= :CNV_End_d
	//into :$InspectionIDs_aL
	//
	//
	//End SQL
	SET QUERY DESTINATION:C396(Into set:K19:2; "STANDARD_PHOTOALLSET")
	QUERY WITH ARRAY:C644([Standard Photos:36]InspID:1; $InspectionIDs_aL)
	USE SET:C118("STANDARD_PHOTOALLSET")
	
	If (CNV_All_L=1) | ((CNV_Photos_L=0) & (CNV_Sketches_L=0) & (CNV_Charts_L=0))
		
	Else 
		CREATE EMPTY SET:C140([Standard Photos:36]; "STANDARD_PHOTOSET")
		CREATE EMPTY SET:C140([Standard Photos:36]; "STANDARD_SketchSET")
		CREATE EMPTY SET:C140([Standard Photos:36]; "STANDARD_ChartSET")
		If (CNV_Photos_L=1)
			USE SET:C118("STANDARD_PHOTOALLSET")
			
			SET QUERY DESTINATION:C396(Into set:K19:2; "STANDARD_PHOTOSET")
			QUERY SELECTION:C341([Standard Photos:36]; [Standard Photos:36]PictType:5=BMS Photo)
			
		End if 
		If (CNV_Sketches_L=1)
			USE SET:C118("STANDARD_PHOTOALLSET")
			
			SET QUERY DESTINATION:C396(Into set:K19:2; "STANDARD_SketchSET")
			QUERY SELECTION:C341([Standard Photos:36]; [Standard Photos:36]PictType:5=BMS Sketch)
			
		End if 
		If (CNV_Charts_L=1)
			USE SET:C118("STANDARD_PHOTOALLSET")
			
			SET QUERY DESTINATION:C396(Into set:K19:2; "STANDARD_ChartSET")
			QUERY SELECTION:C341([Standard Photos:36]; [Standard Photos:36]PictType:5=BMS Chart)
			
		End if 
		SET QUERY DESTINATION:C396(Into set:K19:2; "BlankSet")
		USE SET:C118("STANDARD_PHOTOALLSET")
		QUERY SELECTION:C341([Standard Photos:36]; [Standard Photos:36]PictType:5="")
		
		UNION:C120("STANDARD_PHOTOSET"; "STANDARD_SketchSET"; "STANDARD_PHOTOSET")
		UNION:C120("STANDARD_PHOTOSET"; "STANDARD_ChartSET"; "STANDARD_PHOTOSET")
		UNION:C120("STANDARD_PHOTOSET"; "BlankSet"; "STANDARD_PHOTOSET")
		
		INTERSECTION:C121("STANDARD_PHOTOALLSET"; "STANDARD_PHOTOSET"; "STANDARD_PHOTOALLSET")
		
		USE SET:C118("STANDARD_PHOTOALLSET")
	End if 
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	OBJECT SET VISIBLE:C603(*; "Button1"; False:C215)
	If (Records in selection:C76([Standard Photos:36])>0)
		OBJECT SET VISIBLE:C603(*; "Button1"; True:C214)
		ColumnWidths_txt:="You are going to be converting "+String:C10(Records in selection:C76([Standard Photos:36]))+" Standard Photos records"
	End if 
	
End if 
//End Object Method: ConvertPicture.Button


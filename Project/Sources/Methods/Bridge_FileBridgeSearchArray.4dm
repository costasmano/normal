//%attributes = {"invisible":true,"executedOnServer":true}
//Method: Bridge_FileBridgeSearchArray
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 09/19/19, 13:42:53
	// ----------------------------------------------------
	//Created : 
	Mods_2019_09
End if 
//



ARRAY TEXT:C222($BridgeSearchArray_atxt; 0)
If (False:C215)
	Begin SQL
		
		select
		CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT([Bridge MHD NBIS].[BDEPT],' '),
		CONCAT([Bridge MHD NBIS].[BIN],' ')),
		CONCAT([Bridge MHD NBIS].[Item8],' ')),
		CONCAT([Bridge MHD NBIS].[Item7],' ')),
		CONCAT([Bridge MHD NBIS].[Item6A],' ')),
		CONCAT([Bridge MHD NBIS].[Bridge Name],' '))
		FROM
		[Bridge MHD NBIS]
		INTO
		:$BridgeSearchArray_atxt;
	End SQL
Else 
	Begin SQL
		select
		CONCAT(CONCAT(CONCAT(CONCAT('~!~',[Bridge MHD NBIS].[BDEPT]),
		CONCAT('~!~',[Bridge MHD NBIS].[BIN])),
		CONCAT('~!~',[Bridge MHD NBIS].[Item7])),
		CONCAT('~!~',[Bridge MHD NBIS].[Item6A]))
		
		FROM
		[Bridge MHD NBIS]
		INTO
		:$BridgeSearchArray_atxt;
	End SQL
End if 
ARRAY TEXT:C222(<>BridgeSearchArray_atxt; 0)
COPY ARRAY:C226($BridgeSearchArray_atxt; <>BridgeSearchArray_atxt)


//End Bridge_FileBridgeSearchArray
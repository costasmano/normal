If (False:C215)
	Mods_2011_06  // CJ Miller`06/20/11, 10:57:58      ` Type all local variables for v11
End if 
C_BOOLEAN:C305($OKTOGO_B)
$OKTOGO_B:=False:C215

If (vRadiusR>0)
	If (UnitsList_as=0)
		//assume miles
		UnitsList_as:=1
	End if 
	
	Case of 
		: (FileInput=1)
			
			If (Test path name:C476(SourceFile_txt)=Is a document:K24:1)
				$OKTOGO_B:=True:C214
				If (MaxArraySize=0)
					MaxArraySize:=3000
				End if 
			Else 
				ALERT:C41("Invalid file !!!")
			End if 
			
		: (Center_chk=1)
			If ((center_Lat>0) & (Center_Lon>0))
				$OKTOGO_B:=True:C214
			Else 
				ALERT:C41("You must have non-zero lat and lon values!")
				Case of 
					: (Not:C34(center_Lat>0))
						GOTO OBJECT:C206(center_Lat)
					: (Not:C34(center_Lon>0))
						GOTO OBJECT:C206(center_Lon)
				End case 
				
			End if 
			
	End case 
	If ($OKTOGO_B)
		ACCEPT:C269
	End if 
	
Else 
	ALERT:C41("Must specify a radius to search!")
	GOTO OBJECT:C206(vRadiusR)
End if 

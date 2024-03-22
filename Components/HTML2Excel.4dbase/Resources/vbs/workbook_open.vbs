Function GETENV(variableName)
	
	Set objShell 		= WScript.CreateObject("WScript.Shell")
	Set theVariable 	= objShell.Environment("PROCESS")
	GETENV 			= theVariable(variableName)
	Set objShell 		= Nothing

end Function

Function GETAPP(applicationName)

	On Error Resume Next
	Set GETAPP		 = GetObject(, applicationName)
	If Err.Number <> 0 Then
		Set GETAPP 	= CreateObject(applicationName) 
	End If
	On Error GoTo 0

end Function

Set objExcelApplication	= GETAPP("Excel.Application")

objExcelApplication.DisplayAlerts 	= False
Set theWorkbook				= objExcelApplication.Workbooks.Open(GETENV("XCEL_DOCUMENT_PATH"))
objExcelApplication.DisplayAlerts 	= True

WScript.StdOut.Write theWorkbook.Name

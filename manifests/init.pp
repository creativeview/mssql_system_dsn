# Class: mssql_system_dsn
#
# This module manages ms sql system dsn
#
# Actions:
#
# Requires: see Modulefile
#
class mssql_system_dsn (
  $dsn_name = "", 
  $db_name = "",  
  $db_server_ip = "",
  $db_drivername = "",
  $sql_version = "2012",  
  $dsn_64bit = true
) {

if $dsn_64bit == true
{
  $system_folder = 'system32'
  $hklm_odbc_present1 = 'HKLM\SOFTWARE\ODBC'
  $hklm_path1_base = 'HKLM\SOFTWARE\ODBC\ODBC.INI'
  $hklm_path1 = "${hklm_path1_base}\\${dsn_name}"
  $hklm_path2 = 'HKLM\SOFTWARE\ODBC\ODBC.INI\ODBC Data Sources'
}
else
{
  $system_folder = 'SysWOW64'
  $hklm_odbc_present1 = 'HKLM\SOFTWARE\Wow6432Node\ODBC'
  $hklm_path1_base = 'HKLM\SOFTWARE\Wow6432Node\ODBC\ODBC.INI'
  $hklm_path1 = "${hklm_path1_base}\\${dsn_name}"
  $hklm_path2 = 'HKLM\SOFTWARE\Wow6432Node\ODBC\ODBC.INI\ODBC Data Sources'
}
if  $db_drivername == ""{
	if $sql_version == '2012'{
		$driver = "C:\\Windows\\${system_folder}\\sqlncli11.dll"
		$sql_client_name = 'SQL Server Native Client 11.0'
	}
	elsif $sql_version == 'SQLNativeClient'{
		$driver = "C:\\Windows\\${system_folder}\\sqlncli.dll"
		$sql_client_name = 'SQL Native Client'
	}
	else
	{
		$driver = "C:\\Windows\\${system_folder}\\sqlncli10.dll"
		$sql_client_name = 'SQL Server Native Client 10.0'
	}
}
else {
	$driver = "C:\\Windows\\${system_folder}\\sqlncli.dll"
	$sql_client_name = $db_drivername
}
	   
  registry_key { [ $hklm_odbc_present1,
                   $hklm_path1_base ]:
    ensure => present,
  }
  
Registry::Value {
    key   => $hklm_path1,
  }
    
  registry::value {$dsn_name:
    key   => $hklm_path2,
    value => $dsn_name,
    data  => $sql_client_name,
    type  => string,
  }
    

  registry::value { 'Driver':
    value => 'Driver',
    data  => $driver,
    type  => string,
  }

  registry::value { 'Server':
    value => 'Server',
    data  => $db_server_ip,
    type  => string,
  }

  registry::value { 'Database':
    value => 'Database',
    data  => $db_name,
    type  => string,
  }

  registry::value { 'LastUser':
    value => 'LastUser',
    data  => 'Administrator',
    type  => string,
  }

  registry::value { 'Trusted_Connection':
    value => 'Trusted_Connection',
    data  => 'Yes',
    type  => string,
  }
  
}

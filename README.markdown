# Microsoft SQL ODBC System DSN puppet module.

This module adds a ODBC System DSN for a MS SQL 2008 or 2012 database. This has been tested on Windows Server 2012.  

## Installation

Run this code on your puppet node using the Puppet Module Tool:

```bash
$ puppet module install creativeview/mssql_system_dsn
```
This module depends on puppetlabs/registry >= 0.1.1

## Usage
Example usage:

```puppet
class {'mssql_system_dsn':
        dsn_name => 'vcenter',
        db_name => 'vcdb',
        db_server_ip => '192.168.35.20',
        sql_version => '2012',
        dsn_64bit => true,
    }
```

##### sql_version parameter options

| Value  | Driver |
| ------------- | ------------- |
| 2012 | SQL Server Native Client 11.0 - sqlncli11.dll |
| 2008 | SQL Server Native Client 10.0 - sqlncli10.dll |
| SQLNativeClient | SQL Native Client - sqlncli.dll |

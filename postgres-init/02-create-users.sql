-- Create users
CREATE USER authentik WITH PASSWORD 'authentik';
CREATE USER sftpgo WITH PASSWORD 'sftpgo';

-- Set database ownership
ALTER DATABASE authentik OWNER TO authentik;
ALTER DATABASE sftpgo OWNER TO sftpgo;

-- Grant privileges
GRANT ALL PRIVILEGES ON DATABASE authentik TO authentik;
GRANT ALL PRIVILEGES ON DATABASE sftpgo TO sftpgo;

# Nginx Custom HTTP Response Header Configuration

This README provides instructions on how to configure Nginx to add a custom HTTP response header named "X-Served-By" containing the hostname of the server. This setup is intended for Ubuntu-based servers.

## Prerequisites

- Ubuntu Server installed on your machine(s).
- Nginx web server installed. If not installed, you can install it using the following command:

   ```bash
   sudo apt update
   sudo apt install nginx
Configuration Steps
Clone or download this repository to your server(s).

Open a terminal and navigate to the repository directory.

Run the provided shell script 0-custom_http_response_header with superuser privileges (sudo):

bash
Copy code
sudo ./0-custom_http_response_header
This script will:

Determine the hostname of the server.
Modify the Nginx configuration to add the custom header.
Test the Nginx configuration for errors and reload Nginx if successful.
Verify the configuration by checking the Nginx status:

bash
Copy code
sudo systemctl status nginx
Ensure that Nginx is running without errors.

To confirm that the custom header is being added, you can use a tool like curl to send an HTTP request to your server:

bash
Copy code
curl -I http://your_server_ip_or_domain
Replace your_server_ip_or_domain with your server's actual IP address or domain name.

Additional Notes
The custom header "X-Served-By" will now be included in the HTTP response from your Nginx server, containing the server's hostname.

If you ever need to undo this configuration and remove the custom header, you can edit the Nginx configuration file directly or restore the original Nginx configuration from the backup created by the script.

Remember to customize your Nginx server configuration further to suit your specific needs, such as adding your website files and configuring virtual hosts.

License
This project is licensed under the MIT License - see the LICENSE file for details.

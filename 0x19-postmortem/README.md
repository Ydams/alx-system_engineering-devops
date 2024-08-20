#0x19-postmortem task using webstack debugging #2 By Damilola Yusuf
Postmortem: Webserver Downtime Incident

Issue Summary
Duration: The outage lasted from August 18, 2024, 09:45 AM UTC to August 18, 2024, 11:10 AM UTC.
Impact: During the 1 hour and 25-minute outage, 100% of users were unable to access the website due to the webserver being unable to handle HTTPS requests on port 443. This led to a complete service disruption, where users experienced connection failures and timeouts when attempting to access the website.
Root Cause: The root cause was an expired SSL certificate that prevented the webserver from establishing secure connections over port 443, resulting in the webserver failing to process any incoming HTTPS requests.
Timeline
09:45 AM UTC: Issue detected through automated monitoring alerts indicating a sudden drop in incoming traffic and high error rates on port 443.
09:50 AM UTC: Initial investigation by the on-call engineer focused on network configurations and firewall settings, suspecting a connectivity issue.
10:00 AM UTC: Issue escalated to the DevOps team as network settings appeared normal; deeper investigations into server logs commenced.
10:15 AM UTC: Debugging revealed that the webserver's SSL certificate had expired, leading to HTTPS requests being rejected.
10:25 AM UTC: Misleading investigation paths included checking for DNS misconfigurations and investigating load balancer issues, which were unrelated to the problem.
10:40 AM UTC: SSL certificate renewal process initiated and tested in a staging environment to confirm resolution.
11:00 AM UTC: New SSL certificate deployed to production webservers.
11:10 AM UTC: Monitoring confirmed that HTTPS requests were being successfully processed again, resolving the incident.
Root Cause and Resolution
Root Cause: The SSL certificate used by the webserver to handle HTTPS requests on port 443 had expired. As a result, all incoming secure connections were rejected, causing the webserver to fail in serving any user requests over HTTPS.

Resolution: The expired SSL certificate was renewed, and the new certificate was deployed to all production servers. After the renewal, HTTPS requests resumed as expected, and the webserver was fully operational again. The system was closely monitored post-resolution to ensure no further issues arose.

Corrective and Preventative Measures
Areas for Improvement:

Improve SSL certificate expiration monitoring to ensure timely renewals before expiration.
Enhance alerting mechanisms to differentiate between SSL issues and other network-related problems.
Tasks:

Implement SSL Expiration Alerts: Set up automated monitoring and alerting for SSL certificates that will notify the DevOps team 30 days before expiration.
Automate SSL Certificate Renewals: Introduce automation to handle SSL certificate renewals and deployments across production servers to avoid manual interventions.
Enhance Error Messaging: Improve server logs and monitoring alerts to provide more accurate error messages specifically related to SSL issues.
Test Certificate Expiration Scenarios: Conduct periodic tests in a staging environment to simulate certificate expirations and ensure incident response processes are well-practiced.
Add Redundancy: Implement redundancy measures to failover to backup certificates or fallback mechanisms to prevent total service disruption in case of certificate issues.
By addressing these corrective measures, we aim to prevent future incidents related to SSL certificate expiration and minimize the risk of service outages.

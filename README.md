# SimpleDFIR

SimpleDFIR is a lightweight Digital Forensics and Incident Response (DFIR) tool designed to automate the collection of various system information on Windows machines. It is particularly useful for initial incident response activities, providing a quick overview of the system's configuration and state.

## Features

- Automated execution of predefined commands to gather information across different categories.
- Organizes collected data into themed folders for easy analysis.
- Generates timestamped output files for each command executed.

## Usage

1. **Run the Script:** Execute the `SimpleDFIR.bat` script on a target Windows machine. It should ask for administrative privileges. Otherwise make sure to run it with administrative privileges to ensure all commands are executed successfully.

2. **Automated Data Collection:** SimpleDFIR runs a set of predefined commands to gather information related to General Info, Users, Network, Tasks, Bitlocker, System Config, Event Logs, Registry Export, Installed Programs, Drivers, and more.

3. **Organized Output:** The collected data is organized into themed folders based on the command category, providing a structured view of the information. Each theme folder contains individual text files for each command executed.

4. **Output Files:** Each command generates a corresponding `.txt` file containing the command output, making it easy to review and analyze. The output files are timestamped for reference.

## Planned Enhancements

As SimpleDFIR continues to evolve, the following enhancements are planned for future releases:

- **Support for Multiple Output Formats**: Extend the capability of the tool to export data not only in text format but also in other common formats such as HTML, CSV, and XML, providing users with more flexible options for analysis and reporting.

- **Configuration Options**: Implement a configuration mechanism that allows users to specify which commands or scripts to include or exclude from the data collection process. This will enable users to tailor the tool's behavior to their specific requirements and streamline the collection process.

- **Improved Command Execution**: Enhance the command execution mechanism to handle edge cases more gracefully and improve error handling for robustness and reliability.

- **User Interface Enhancements**: Explore options for enhancing the user interface of SimpleDFIR, such as adding interactive prompts, progress indicators, or graphical visualizations to improve the user experience and usability of the tool.

- **Logging and Reporting**: Introduce logging functionality to capture detailed information about the execution process, errors encountered, and data collected. Additionally, enable the generation of comprehensive reports summarizing the findings for easy reference and sharing.

- **Integration with External Tools**: Investigate opportunities for integrating SimpleDFIR with other DFIR tools and platforms to enhance its capabilities and interoperability within broader forensic workflows.

These planned enhancements aim to make SimpleDFIR more versatile, customizable, and user-friendly, empowering investigators with greater control and efficiency in gathering and analyzing digital evidence.


## Commands and Descriptions

SimpleDFIR automates the collection of various system information on Windows machines by executing a set of predefined commands. Each command generates a themed folder containing an output file with the results. Here's a comprehensive list of the commands, along with brief explanations organized by folder themes:

### General Info

1. **ver:** Displays the version of the operating system.

2. **systeminfo:** Provides detailed configuration information about the computer's hardware and software.

### Users

3. **Quser:** Displays information about users logged on to the system.

4. **Date /t:** Displays the current date.

5. **time /t:** Displays the current time.

6. **Whoami:** Displays information about the currently logged-in user.

### Network

7. **Netstat -ano:** Shows active network connections and listening ports along with the associated process IDs.

8. **Netstat -anb:** Similar to the above but includes the process name.

9. **Ipconfig /all:** Displays detailed IP configuration information for all interfaces.

10. **Ipconfig /displaydns:** Shows the contents of the DNS Resolver Cache.

11. **Net user:** Lists user accounts on the system.

12. **Arp -a:** Displays the ARP (Address Resolution Protocol) cache.

13. **route print:** Shows the routing table.

14. **Nbtstat -S:** Displays NetBIOS over TCP/IP statistics.

15. **Net sessions:** Lists information about sessions established on the system.

16. **net view \\127.0.0.1:** Lists shared resources on the local machine.

### Tasks

17. **Tasklist:** Displays a list of running processes.

18. **Tasklist -v:** Similar to the above but includes additional information.

19. **schtasks:** Lists scheduled tasks.

### Bitlocker

20. **manage-bde -status:** Shows the status of BitLocker Drive Encryption.

21. **manage-bde -protectors C: -get:** Retrieves information about BitLocker protection for the C: drive.

### System Config

22. **set:** Displays environment variables.

23. **vssadmin list shadows:** Lists all shadow copies on the system.

### Event Logs

24. **wevtutil qe System /c:1 /rd:true /f:text:** Queries the System event log.

25. **wevtutil qe Security /c:1 /rd:true /f:text:** Queries the Security event log.

26. **wevtutil qe Application /c:1 /rd:true /f:text:** Queries the Application event log.

### Registry Export

27. **reg export HKLM\Software registry_export_software.reg:** Exports the Software registry key to a file.

28. **reg export HKLM\System registry_export_system.reg:** Exports the System registry key to a file.

### Installed Programs

29. **wmic product get name,version:** Lists installed programs using Windows Management Instrumentation (WMI).

### Drivers

30. **driverquery:** Displays a list of installed device drivers.

### Directory Listing

31. **dir C:\ /s:** Lists all files in the C: drive and its subdirectories.

### Directory Listing

32. **dir C:\ /s:** Lists all files in the C: drive and its subdirectories.

### Firewall Rules

33. **netsh advfirewall firewall show rule name=all:** Shows all firewall rules.

### Running Services

34. **net start:** Lists running services.

### Network Statistics

35. **netstat -abno:** Displays active network connections and includes the process using each connection.

### Open Handles

36. **handle:** Lists open handles for files or directories.

### Logged-In Users

37. **quser:** Displays information about currently logged-in users.

### Domain Controller List

38. **nltest /dclist:domain.com:** Lists domain controllers for a specified domain.

### Shared Folders

39. **net share:** Lists shared resources on the system.

### Stored Credentials

40. **cmdkey /list:** Lists stored credentials.

### Signed Drivers

41. **wmic path win32_pnpsigneddriver get deviceid,description,driverversion:** Lists signed device drivers.

### Printers Status

42. **wmic printer list status:** Lists the status of installed printers.

### Startup Programs

43. **wmic startup list full:** Lists startup programs.

### User Accounts

44. **wmic useraccount list full:** Lists user accounts.

### Current User Groups

45. **whoami /groups:** Displays the security groups of the current user.

### Group Policies

46. **gpresult /Scope Computer /v:** Displays Group Policy settings for the computer.

### Installed Hotfixes

47. **wmic qfe get HotFixID,InstalledOn:** Lists installed hotfixes.

### System Restore

48. **wmic /namespace:\\root\default path SystemRestore get * /value:** Queries System Restore information.

### Performance Providers

49. **logman query providers:** Lists performance monitoring providers.

### DNS Cache

50. **ipconfig /displaydns:** Displays the contents of the DNS Resolver Cache.

### System File Check

51. **sfc /scannow:** Initiates a system file check.

### Power Configuration

52. **powercfg /query:** Displays power configuration information.

### Filter Manager

53. **fltmc:** Lists Filter Manager information.

### Loaded Modules

54. **tasklist /m:** Lists loaded modules for each process.

### Memory Info

55. **wmic memorychip get:** Displays information about installed memory chips.

These commands collectively provide a comprehensive set of data for digital forensics and incident response purposes, offering insights into various aspects of the system's configuration, software, network, and more.

## Output Structure

The collected data is organized into themed folders based on the command categories. Each theme folder contains individual text files for each command executed, allowing for easy access and analysis of the collected information. The output files are timestamped for reference and are stored within the themed folders.


## Support

For questions or issues, make an issue in this repo or contact me.

## License

This project is licensed under the [MIT License](LICENSE).
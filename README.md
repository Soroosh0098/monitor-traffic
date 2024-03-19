# Network Traffic Monitoring Tool

This repository contains a Node.js application and accompanying Bash script for monitoring network traffic using the `nethogs` command-line tool. The tool periodically captures network usage statistics and stores them in a JSON file for further analysis and reporting.

## Features

- **Real-time Monitoring**: The application runs the `nethogs` command with specified options to continuously monitor network usage.
- **Data Storage**: Network usage data is stored in a JSON file (`traffics-output.json`) for persistence between runs.
- **Data Aggregation**: The application aggregates network usage data for each user, providing insights into individual and total network usage over time.
- **Customization**: The monitoring interval and output file path can be easily customized to suit specific requirements.
- **Systemd Service**: The included Bash script automates the setup of a systemd service for running the monitoring script as a background service.

## Dependencies

Before using this script, ensure you have the following dependencies installed on your system:

- **nethogs**: This script utilizes the nethogs library. You'll need to install nethogs from the [nethogs repository](https://github.com/raboof/nethogs). Follow the installation instructions provided in the nethogs repository to install nethogs on your system.

- **Node.js**: The script is written in Node.js, so you'll need to have Node.js installed. You can download and install Node.js from the [official Node.js website](https://nodejs.org/).

- **npm (Node Package Manager)**: npm is the package manager for Node.js. It is usually installed automatically when you install Node.js. However, if you need to install it separately, you can follow the instructions on the [npm website](https://www.npmjs.com/get-npm).

- **Git**: If you choose to clone the repository manually, you'll need Git installed on your system. You can download and install Git from the [official Git website](https://git-scm.com/).

## Installation

### Method 1: Using Our Installer (Recommended)

#### Execute the Script Directly

To execute the script directly on your server, run the following command:

```bash
curl -sL https://raw.githubusercontent.com/Soroosh0098/monitor-traffic/main/install.sh | sudo bash
```

#### Download the Script

To download the script, you can use either curl or wget. Run one of the following commands in your terminal:

Using curl:

```
curl -o install.sh -L https://raw.githubusercontent.com/Soroosh0098/monitor-traffic/main/install.sh
```

Using wget:

```
wget https://raw.githubusercontent.com/your-username/monitor-traffic/main/install.sh -O install.sh
```

**Install the Project**: Once downloaded, make the script executable and run it to install the project:

```
chmod +x install.sh
./install.sh
```

Finally Follow the on-screen prompts to complete the installation.

### Method 2: Using Git Clone

1. Clone the repository:

   ```bash
   git clone https://github.com/Soroosh0098/monitor-traffic.git
   ```

2. Navigate to the cloned directory:

   ```bash
   cd monitor-traffic
   ```

3. Install dependencies:

   ```bash
   npm install
   ```

4. Proceed to usage instructions as described in the [Usage](#usage) section.

Note: Ensure that Node.js and npm are installed on your system before proceeding with this method.

## Usage

1. **Run the application:**

   ```bash
   npm start
   ```

   This will start the network traffic monitoring process using the default interval (60 seconds) and output file path (`/root/monitor-traffic/data/traffics-output.json`).

2. **Customize settings (optional):**

   - Adjust the monitoring interval by specifying the desired interval (in seconds) as an argument to the `runNethogs` function call in `monitor-traffic.js`.
   - Modify the output file path by updating the `outputFileName` constant in `monitor-traffic.js`.

3. **Setup systemd service (optional):**

   Run the included Bash script to create and start a systemd service for automatic execution of the monitoring script:

   ```bash
   chmod +x create-service.sh
   ./create-service.sh
   ```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- The application utilizes the `nethogs` command-line tool for network traffic monitoring.

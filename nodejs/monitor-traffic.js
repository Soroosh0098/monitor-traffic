const { exec } = require('child_process');
const fs = require('fs');
const outputFileName = '/root/monitor-traffic/data/traffics-output.json';
const updatesInterval = 60;

function loadDataFromFile() {
  try {
    const fileContents = fs.readFileSync(outputFileName);
    return JSON.parse(fileContents);
  } catch (err) {
    if (err.code === 'ENOENT') {
      fs.writeFileSync(outputFileName, '');
      return [];
    } else {
      throw err;
    }
  }
}

function saveDataToFile(data) {
  try {
    fs.writeFileSync(outputFileName, JSON.stringify(data, null, 2));
  } catch (err) {
    if (err.code === 'ENOENT') {
      fs.writeFileSync(outputFileName, '');
      fs.writeFileSync(outputFileName, JSON.stringify(data, null, 2));
    } else {
      throw err;
    }
  }
}

function runNethogs(updates = 60) {
  const nethogsCommand = `sudo nethogs -v 1 -c ${updates} -t`;
  const nethogsProcess = exec(nethogsCommand, (error, stdout, stderr) => {
    if (error) {
      console.error(`Error running Nethogs: ${error}`);
      return;
    }

    const output = stdout.toString();
    const sections = output.split('Refreshing:');
    const lastSection = sections.filter((section) => section.trim() !== '').pop();
    const dataAsArray = [];

    if (lastSection) {
      const dataEntries = lastSection.split('\n');

      dataEntries.forEach((line) => {
        const match = line.match(/sshd: (\S+)\/\d+\/\d+\s+([\d.]+)\s+([\d.]+)/);
        if (match) {
          const [, username, upload, download] = match;
          const uploadValue = Number(parseFloat(upload).toPrecision(2));
          const downloadValue = Number(parseFloat(download).toPrecision(2));
          const total = Number((uploadValue + downloadValue).toPrecision(2));
          dataAsArray.push({ username, upload: uploadValue, download: downloadValue, total });
        }
      });
    }
    updateUsages(dataAsArray);
  });
}

function updateUsages(data) {
  if (data.length === 0) {
    return;
  }
  const dataAsArray = loadDataFromFile();
  data.forEach((entry) => {
    const existingUser = dataAsArray.find((item) => item.username === entry.username);
    if (existingUser) {
      existingUser.upload = Number((existingUser.upload + entry.upload).toFixed(2));
      existingUser.download = Number((existingUser.download + entry.download).toFixed(2));
      existingUser.total = Number((existingUser.total + entry.total).toFixed(2));
    } else {
      dataAsArray.push(entry);
    }
  });
  saveDataToFile(dataAsArray);
}

runNethogs(updatesInterval);
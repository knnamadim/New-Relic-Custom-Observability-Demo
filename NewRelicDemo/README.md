# New Relic Custom Observability Demo

This project demonstrates how to extend New Relic observability with custom metrics
using simple Bash scripts. It shows a complete workflow: installing the agent, 
collecting custom metrics, and visualizing them in New Relic dashboards.

---

## 🚀 Project Overview
- Install the **New Relic Infrastructure Agent**
- Collect **custom metrics** (free memory and CPU load) via a Bash script
- Configure the agent to run the script at regular intervals
- Visualize metrics in New Relic dashboards using NRQL queries

---

## 📂 Project Structure
newrelic-custom-observability/
│── README.md
│
│── scripts/
│ ├── install-newrelic.sh # Installs & configures New Relic Infra agent
│ └── custom-metrics.sh # Collects system metrics and outputs JSON
│
│── config/
│ └── custom-metrics.yml # Integration config for agent
│
│── screenshots/
│ ├── dashboard.png # Screenshot of your NRQL dashboard
│ └── query.png # Screenshot of NRQL query results

---

## 🛠️ Setup Instructions

1. Install the New Relic Agent
chmod +x scripts/install-newrelic.sh
./scripts/install-newrelic.sh

2. Set Up the Custom Metrics Integration
    a. Copy **custom-metrics.sh** to **/etc/newrelic-infra/custom-metrics.sh**:
    sudo cp scripts/custom-metrics.sh /etc/newrelic-infra/custom-metrics.sh
    sudo chmod +x /etc/newrelic-infra/custom-metrics.sh

    b. Copy **custom-metrics.yml** to **/etc/newrelic-infra/integrations.d/** :
    sudo cp config/custom-metrics.yml /etc/newrelic-infra/integrations.d/custom-metrics.yml

    c. Restart the agent:
    sudo systemctl restart newrelic-infra

---

## Viewing Metrics in New Relic
- After a minute, your custom metrics will appear in New Relic as a Custom Event Type: **CustomSystemMetrics**.
- Example NRQL query to see CPU load and free memory:

SELECT average(free_memory_mb), average(cpu_load_1min)
FROM CustomSystemMetrics
SINCE 30 minutes ago
TIMESERIES

---

## Adding Screenshots
1. Dashboard screenshot (**dashboard.png**)
- Create a dashboard in New Relic One
- Add a chart with **CustomSystemMetrics**
- Take a screenshot and save it as **screenshots/dashboard.png**

2. Query screenshot (**query.png**)
- Run the NRQL query above
- Visualize it (chart or table)
- Take a screenshot and save it as **screenshots/query.png**


Notes: You can leave the placeholder images for now and replace them later once you generate actual screenshots.

---

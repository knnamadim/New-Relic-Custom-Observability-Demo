#!/bin/bash

# Collect system metrics
FREE_MEM=$(free -m | awk '/^Mem:/{print $4}')
CPU_LOAD=$(uptime | awk -F'load average:' '{print $2}' | cut -d, -f1 | xargs)

# Output JSON in New Relic integration format
cat <<EOF
{
  "name": "custom-metrics",
  "protocol_version": "1",
  "integration_version": "1.0.0",
  "metrics": [
    {
      "event_type": "CustomSystemMetrics",
      "free_memory_mb": $FREE_MEM,
      "cpu_load_1min": $CPU_LOAD
    }
  ]
}
EOF

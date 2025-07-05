# 🛰️ Home Network Monitoring & Analytics Dashboard

![demo](https://github.com/user-attachments/assets/0301e2aa-54b1-4b63-bfea-84320242e519)

A real-time network monitoring and analytics platform built using **Node-RED**, **PostgreSQL**, **OpenWRT**, and **AppSmith**.  
Track traffic, devices, and DNS activity across your home or small-office network using a clean, extensible architecture.

---

## ✨ Features

- 🔍 **Device Discovery & Tracking**
  - Real-time DHCP leases, hostnames, MAC/IP mapping
  - Scan logs, RTT (latency), and status monitoring

- 📡 **Traffic Monitoring**
  - Per-device download/upload stats using `nlbwmon`
  - Layer-7 protocol tracking (QUIC, HTTPS, etc.)
  - Traffic deltas and rate (bytes/sec) calculations

- 📊 **DNS Analytics**
  - Summary of DNS queries per device
  - Total vs blocked queries, top domains
  - Latency averages

- 📈 **Dashboards**
  - AppSmith-powered UI with tables, charts, and trends
  - Top protocols, hourly trends, device-specific views

- 🛢️ **PostgreSQL Backend**
  - Schemas for `network_devices`, `network_usage`, `dns_query_summary`, `device_scan_log`, and more
  - Efficient queries for rollups and trends

---

## 🏗️ Architecture

```text
[ OpenWRT + nlbwmon + Adguard Home]
        ↓
   [ Node-RED ]
   - Parses NLBW + DHCP
   - Calculates deltas & rate
   - Saves to PostgreSQL
        ↓
  [ PostgreSQL DB ]
        ↓
    [ AppSmith ]
  - Interactive Dashboards
  - Editable Device Table
```



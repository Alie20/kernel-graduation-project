#!/bin/bash

# Bash Script to Analyze Network Traffic

# Path to the Wireshark pcap file
pcap_file="network_interface.pcap"

# Function to extract information from the pcap file
analyze_traffic() {
    echo "----- Network Traffic Analysis Report -----"

    # Total Packets
    total_packets=$(tshark -r "$pcap_file" | wc -l)
    echo "1. Total Packets: $total_packets"

    # Protocols
    echo "2. Protocols:"
    http_packets=$(tshark -r "$pcap_file" -Y http | wc -l)
    https_packets=$(tshark -r "$pcap_file" -Y tls | wc -l)
    echo "   - HTTP: $http_packets packets"
    echo "   - HTTPS/TLS: $https_packets packets"
    echo ""

    # Top Source IPs
    echo "3. Top 5 Source IP Addresses:"
    top_source_ips=$(tshark -r "$pcap_file" -T fields -e ip.src | sort | uniq -c | sort -nr | head -n 5)
    echo "$top_source_ips"
    echo ""

    # Top Destination IPs
    echo "4. Top 5 Destination IP Addresses:"
    top_dest_ips=$(tshark -r "$pcap_file" -T fields -e ip.dst | sort | uniq -c | sort -nr | head -n 5)
    echo "$top_dest_ips"
    echo ""

    echo "----- End of Report -----"
}

# Run the analysis function
analyze_traffic

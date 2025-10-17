#!/bin/bash
cd /home/cgonzalez/repos/cgonzalez-vt/db-mcp-server/bin

# Send both initialize and tools/list requests
{
  echo '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2024-11-05","capabilities":{},"clientInfo":{"name":"test-client","version":"1.0.0"}}}'
  sleep 0.5
  echo '{"jsonrpc":"2.0","id":2,"method":"tools/list","params":{}}'
  sleep 0.5
} | ./db-mcp-server -t stdio 2>/dev/null




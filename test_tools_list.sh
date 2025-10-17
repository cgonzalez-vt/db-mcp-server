#!/bin/bash
# Test if the MCP server exposes tools list properly

cd /home/cgonzalez/repos/cgonzalez-vt/db-mcp-server/bin

# Send initialize request to stdio server
echo '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"0.1.0","capabilities":{},"clientInfo":{"name":"test-client","version":"1.0.0"}}}' | ./db-mcp-server -t stdio 2>/dev/null




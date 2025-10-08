#!/bin/sh
MERMAID_FILTER_FORMAT="svg" pandoc -t html --filter mermaid-filter $@

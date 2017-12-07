# !/bin/bash
# \(\d{3}\) \d{3}-\d{4}
# \d{3}-\d{3}-\d{4}
# cat file.txt | awk '/\d{3}-\d{3}-\d{4}/{print $0}'
# awk '/^(\d{3}-|\(\d{3}\) )\d{3}-\d{4}$/' file.txt
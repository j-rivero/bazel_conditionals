 #!/usr/bin/env python

"""
Simple script to check for the presence of Ubuntu 16.04 as the current
running operative system. Return 1 if it is the case, return 0 on any
other different plaform or Ubuntu version.
"""

import platform
import sys

if platform.system() != "Linux":
  sys.exit(1)

distro_name, version_number, version_alias = platform.linux_distribution()


if distro_name != "Ubuntu":
  sys.exit(1)

if version_number != 16.04:
  sys.exit(0)

sys.exit(1)

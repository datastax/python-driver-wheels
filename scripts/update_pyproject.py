import toml

import shutil
import sys

(pyproject_path, libev_includes,libev_libs) = sys.argv[1:]

pyproject_path_backup = pyproject_path + ".original"

shutil.move(pyproject_path, pyproject_path_backup)
the_toml = toml.load(pyproject_path_backup)

the_toml["tool"]["cassandra-driver"]["libev-includes"] = [libev_includes]
the_toml["tool"]["cassandra-driver"]["libev-libs"] = [libev_libs]

toml.dump(the_toml, open(pyproject_path, "w"))

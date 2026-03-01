import os, sys
import pathlib
import stat
import time

def get_metadata(path: pathlib.Path) -> os.stat_result:
    return os.stat(path)

def print_metadata(meta: os.stat_result) -> None:
    print("Size:", meta.st_size, "bytes")
    print("Last accessed:", time.ctime(meta.st_atime))
    print("Last modified:", time.ctime(meta.st_mtime))
    print("Created:", time.ctime(meta.st_ctime))
    print("Permissions:", stat.filemode(meta.st_mode))

def main() -> None:
    # get the file as an argument
    # validate the path
    try:
        file_path = pathlib.Path(sys.argv[1]).resolve()
    except IndexError:
        print("No file provided")
        sys.exit(-1)

    if not file_path.exists():
        print("File not found")
        sys.exit(-1)

    # get the metadata
    metadata: os.stat_result = get_metadata(file_path)
    
    # print the metadata
    print_metadata(metadata)

if __name__ == "__main__":
    main()

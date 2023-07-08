import os
import pathlib
from platform import system

with open("compilation_list.txt", "w") as output: 
    root_dir = str(pathlib.Path(__name__).parent.resolve().parent.resolve()) #get parent directory
    if (system() == "Windows"):
        root_dir = root_dir + "\\src\\" #paths in windows use backslashes
    else:
        root_dir = root_dir + "/src/" #paths in linux use forward slashes

    file_list = []

    #recursively explore subfolders and add files' relative paths to file list
    for dir_, _, files in os.walk(root_dir):
        for file_name in files:
            rel_dir = os.path.relpath(dir_, root_dir)
            rel_file = os.path.join(rel_dir, file_name)
            file_list.append(rel_file)

    file_list.sort(reverse=True, key=str.casefold) #sort file list in alphabetically ascending order

    #write sorted filenames to output file
    for i in range(len(file_list)):
        file_list[i] = file_list[i].replace("\\", "/") #replace Windows's backslashes with UNIX's forward slashes 
        output.write(file_list[i] + "\n")

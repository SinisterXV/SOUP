#!/usr/bin/python3

import argparse
import subprocess

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

def color_print(string, color):
    print(f'{color}{string}{bcolors.ENDC}')

def check_return_code(return_code, command = ""):
    if return_code == 0:
        color_print(
            f'Command {command} terminated with exit code {return_code}\n',
            bcolors.OKGREEN
        )
    else:
        color_print(
            f'Command {command} terminated with exit code {return_code}\n',
            bcolors.FAIL
        )
        exit(1)


def main():

    parser = argparse.ArgumentParser()
    
    # Argument to compile only the files
    parser.add_argument(
        "-c", "--compile_only",
        action = "store_true",
        help = "compile the files without executing them"
    )

    # Argument to specify which file to simulate
    parser.add_argument(
        "-a", "--asm",
        help = "which assembler file to execute"
    )

    # Argument to specify which file to simulate
    parser.add_argument(
        "-g", "--gui",
        action="store_true",
        help = "open the gui to analyze waveforms"
    )

    arguments = parser.parse_args()

    color_print("Start of execution\n",bcolors.HEADER)

    # Compile operation

    retcode = subprocess.call(["vcom", "-F", "dlx_compile_sources.f"], cwd="../sim/")
    check_return_code(retcode, "vcom")

    color_print(f'Compilation process terminated successfully\n',bcolors.OKCYAN)
    
    if arguments.compile_only == True:
        exit(0)

    if arguments.asm == None:
        color_print(f'Argument -a (--asm) is required for the simulation\n',bcolors.FAIL)
        exit(1)

    # Assemble the input file
    assembler_command = ["./assemble.sh", f"asm_example/{arguments.asm}/{arguments.asm}.asm"]
    retcode = subprocess.call(assembler_command , cwd="../sim/")
    check_return_code(retcode, "assembler")

    # vsim command
    vsim_command = ["vsim","-do", "simulation_cli.do", "tb_dlx"]

    if arguments.gui == False:
        vsim_command.append("-c")
        retcode = subprocess.call(vsim_command, cwd="../sim/")
        check_return_code(retcode, "vsim")
    else:   
        vsim_command[2] = "simulation_gui.do"
        retcode = subprocess.call(vsim_command, cwd="../sim/")
        check_return_code(retcode, "vsim")

    color_print(f'Execution terminated successfully',bcolors.OKCYAN)

if __name__ == "__main__":
    main()

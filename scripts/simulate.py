#!/usr/bin/python3

import argparse
import subprocess
from verify_result import verify_result

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
    message = f'Command {command} terminated with exit code {return_code}\n'
    if return_code == 0:
        color_print(message, bcolors.OKGREEN)
    else:
        color_print(message, bcolors.FAIL)
        exit(1)

# Utility functions to parse the `-v` arguments
def parse_verify_argument(s):
    items = s.split('=')
    return (items[0].strip(), items[1].strip())

def parse_verify_arguments(items):
    return [{"key" : parse_verify_argument(item)[0], "value" : parse_verify_argument(item)[1]} for item in items ]

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

    # Argument to prettify the dump of rf and dram
    parser.add_argument(
        "-p", "--pretty",
        action="store_true",
        help = "prettify dump"
    )

    parser.add_argument("-v", "--verify",
                        metavar="KEY=VALUE",
                        nargs='*',
                        help="""Set a list of key-value elements to verify from the rf/dram final dump.
                                This option is used only if `-p` is present.
                                You can add either a register as `rx=XXX` where `x` is in 0...31
                                or a memory cell as `my=YYY`, where `y` is in 0...255.
                                The value can be written both in hex (8 digits) or in dec"""
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

    vsim_command = ["vsim","-do", "simulation_cli.do", "-t", "10ps", "tb_dlx"]

    if arguments.gui == False:
        vsim_command.append("-c")
        retcode = subprocess.call(vsim_command, cwd="../sim/")
        check_return_code(retcode, "vsim")
    else:   
        vsim_command[2] = "simulation_gui.do"
        retcode = subprocess.call(vsim_command, cwd="../sim/")
        check_return_code(retcode, "vsim")

    # Prettify dump file
    if arguments.pretty == True: 
        retcode = subprocess.call(["python3", "prettify_dump.py"])
        check_return_code(retcode, "prettify_dump")

        to_verify = parse_verify_arguments(arguments.verify)

        for pair in to_verify:
            return_code, message = verify_result(pair["key"], pair["value"])
            if return_code == True:
                color_print(message ,bcolors.BOLD)
            else:
                color_print(message ,bcolors.FAIL)

    color_print(f'\nExecution terminated successfully',bcolors.OKCYAN)

if __name__ == "__main__":
    main()

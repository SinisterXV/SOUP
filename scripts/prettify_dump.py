# This script takes as input the dump of the register file and the dram produced 
# by modelsim and improves its readability
import re

def main():
    rf_dump = None
    dram_dump = None
    # Read lines from source file
    with open("../sim/dump_rf_dmem.dump") as input_file:
        lines = input_file.readlines()
        rf_dump = lines[1]
        dram_dump = lines[4]

    # Tokenize into numbers
    rf_content = re.findall(r'\d+', rf_dump)
    dram_content = re.findall(r'\d+', dram_dump)

    # Output in the expected way
    with open("../sim/dump_rf_dmem.dump", "w") as output_file:
        # Register file
        counter = 0
        output_file.write("REGISTER FILE DUMP: \n")
        output_file.write(f"{f'reg':<7} {f'hex':<15} int\n")
        output_file.write("-------------------------------------\n")
        for register in rf_content:
            string = f"{f'r{counter}:':<7} {f'0x{int(register):08x}':<15} {int(register)}\n"
            output_file.write(string)
            counter += 1

        # Dram
        output_file.write("\nDRAM: \n")
        # Cells are sorted in decreasing way
        output_file.write(f"{f'reg':<7} {f'hex':<15} int\n")
        output_file.write("-------------------------------------\n")

        counter = 255
        for word in dram_content:
            string = f"{f'{counter}:':<7} {f'0x{int(word):08x}':<15} {int(word)}\n"
            output_file.write(string)
            counter -= 1
        

if __name__ == "__main__":
    main()
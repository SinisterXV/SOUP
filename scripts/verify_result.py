import re 

def verify_result(key, value):
    target_line = None 
    with open("../sim/dump_rf_dmem.dump", "r") as read_file:
        for line in read_file.readlines():
            if line.startswith(f"{key}:"):
                target_line = line
        if target_line is None:
            return False, f"{key} is not a valid argument"

    integer_value = str(re.findall(r'\d+', target_line)[-1])
    hex_value = str(re.findall(r'0x[0-9a-f]+', target_line)[-1])

    if integer_value == value or hex_value == value:
        if str(key)[0] == 'r':
            return True, f"Register {key} is {value} as expected"
        else:
            return True, f"Memory location {key} is {value} as expected"
    else:
        integer_match = False if str(value[0:2]) == "0x" else True

        if str(key)[0] == 'r':
            return False, f"Register {key} is not {value};\n->\tfound {integer_value if integer_match else hex_value} instead"
        else:
            return False, f"Memory location {key} is not {value};\n->\tFound {integer_value if integer_match else hex_value}"


import decouple
import paramiko
import subprocess
import sys

# Get the environment variables
def get_env(name):
    return decouple.config(name)

# Get string of the arguments of the python command
def get_arguments():
    return ' '.join(sys.argv[1:])

# Class to connect to the remote machine
class ssh_connection:
    def __init__(self, username, password, port, host):
        self.connection = paramiko.SSHClient()
        self.connection.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        self.connection.connect(hostname=host, username =username, password=password, port=port, look_for_keys=False)

    # Method to execute a command on the remote machine
    def exec(self, command, show_output = True):

        (stdin, stdout, stderr) = self.connection.exec_command(command)
        exit_status = stdout.channel.recv_exit_status()

        if exit_status != 0:
            print("{}".format(stdout.read().decode("ascii")))
            print(stderr.read().decode("ascii"))
            self.close()
            raise Exception

        elif stdout and show_output:
            print("{}".format(stdout.read().decode("ascii")))

    # Close the connection
    def close(self):
        self.connection.close()

if __name__ == '__main__':

    # Get the environment variables
    HOST = get_env("HOST")
    PORT = get_env("PORT")
    USER_SERVER = get_env("USER_SERVER") 
    PASSWORD = get_env("PASSWORD")
    SERVER_WORKING_DIRECTORY = get_env("SERVER_WORKING_DIRECTORY")

    # Send data to the server
    subprocess.call(["sshpass", "-p", PASSWORD, "bash", "../scripts/rsync_server.sh", SERVER_WORKING_DIRECTORY, HOST, PORT, USER_SERVER])
    
    # THE FOLLOWING LINES CAN BE USED TO AUTOMATICALLY EXECUTE A SCRIPT ON THE SERVER AND DOWNLOAD THE RESULT BACK

    # Activate the connection
    # connection = ssh_connection(USER_SERVER, PASSWORD, PORT, HOST)

    # Run the simulation
    # connection.exec(f"source /eda/scripts/init_questa_core_prime; cd {server_working_directory}/sim; python3 ../scripts/execute.py {get_arguments()}")
    
    # Close the connection
    # connection.close()

    # Download the data back from the server
    # subprocess.call(["sshpass", "-p", PASSWORD, "bash", "../scripts/rsync_local.sh",server_working_directory])

    # Display the results 
    # subprocess.call(["cat", "results/output.txt"])

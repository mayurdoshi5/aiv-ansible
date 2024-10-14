#!/usr/bin/python3

from flask import Flask, request, jsonify
from flask_cors import CORS
import os
import subprocess

app = Flask(__name__)
CORS(app)

@app.route('/create_host', methods=['POST'])
def create_host():
    try:
        data = request.get_json()
        if not isinstance(data, dict):
            raise ValueError('Invalid JSON format')

        server = data.get('server')
        ip = data.get('ip')
        ansible_user = data.get('ansible_user')
        ansible_ssh_pass = data.get('ansible_ssh_pass')
        inventory_name = 'inventory_' + ip.replace('.', '')
        playbook_name = 'playbook_' + ip.replace('.', '') + '.yml'

        if not all([server, ip, ansible_user, ansible_ssh_pass]):
            raise ValueError('Incomplete server information')

        # Write host file
        with open(inventory_name, 'w') as f:
            f.write('[{}]\n'.format(server))
            f.write('{} '.format(ip))
            f.write('ansible_user={} '.format(ansible_user))
            f.write('ansible_ssh_private_key_file=/home/aivadmin/aiv.pem')
            #f.write('ansible_connection=ssh\n')  # Directly write ansible_connection=ssh
            f.write('\n')  # Empty line between entries

        # Write playbook file
        with open(playbook_name, 'w') as f:
            f.write("---\n")
            f.write("- hosts: {}\n".format(server))
            f.write("  gather_facts: no\n")
            f.write("  tasks:\n")
            f.write("    - name: Running aiv-hub Roles\n")
            f.write("      include_role:\n")
            f.write("        name: aiv-hub\n")

        # Set SSH_ASKPASS environment variable to automatically respond with 'yes'
        os.environ["SSH_ASKPASS"] = "/home/aivadmin/aiv-ansible/ssh_askpass_script.sh"

        # Execute the Ansible playbook command
        subprocess.run(['sudo', 'ansible-playbook', '-i', inventory_name, playbook_name], check=True)

        return jsonify({'message': 'Server created successfully'})
    except Exception as e:
        return jsonify({'error': str(e)}), 400

if __name__ == '__main__':
    # Load SSL certificate and private key
    ssl_cert = 'fullchain.pem'
    ssl_key = 'privkey.pem'
    
    # Run the Flask app with HTTPS enabled
    app.run(debug=True, host='0.0.0.0', ssl_context=(ssl_cert, ssl_key))

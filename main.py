
import subprocess


def main():
    install_k3s()
    # TODO wait until k3s is available
    # TODO install and configure keycloak
    # TODO configure k3s authentication using keycloak
    # TODO install MinIO
    # TODO configure MinIO to authenticate with keycloak
    # TODO configure MinIO to be a Container Registry
    # TODO install KubeDB and configure it to authenticate using keycloak
    # TODO install Traefik as a reverse proxy inside k3s
    # TODO configure Traefik HTTPS certificate
    # TODO configure Traefik to redirect requests based on DNS subdomain
    # TODO configure Traefik to redirect request from port 80 to port 443
    # TODO install and configure Woodpecker CI
    # TODO configure Traefik CI/CD to update DNS subdomain list and redirects
    # TODO configure KubeDB backups
    # TODO configure firewall to block all requests in ports that are not 22, 80 or 443
    # TODO configure firewall to allow 22 requests only from some IPs, if the list is not empty
    # TODO configure email server

def install_k3s():
    # TODO download this without subprocess, only use sh to install the k3s
    subprocess.run(['curl', '-sfL', 'https://get.k3s.io', '|', 'sh', '-'])

main()
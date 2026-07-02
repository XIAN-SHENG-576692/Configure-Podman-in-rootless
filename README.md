# Configure-Podman-in-rootless

This guide demonstrates how to configure **Podman** in a rootless environment.

---

## Setup Instructions

### On the **Host** as the **root user**

1. Install **Podman** and **sudo**

### On the **Host** as the **rootless user**

1. Set up **Podman**:
    ```shell
    setup_podman.sh
    ```
2. **(Optional)**: Set up **ssh-agent** for Sharing Git credentials with container.
    ```shell
    setup_ssh-agent.sh
    ```

### **(Optional)** On the **Client** with **VS Code**

1. Install `ms-vscode-remote.remote-containers`
    ```shell
    code --install-extension ms-vscode-remote.remote-containers
    ```
2. Set `dev.containers.dockerPath`
    ```shell
    set_vscode_devcontainer_podman_linux.sh
    ```
    ```shell
    set_vscode_devcontainer_podman_macos.sh
    ```
    ```powershell
    set_vscode_devcontainer_podman_windows.ps1   
    ```

# AppImageDragDrop

This repository contains a script to simplify the process of handling AppImage files with drag-and-drop functionality. Inspired by macOS where the user can drag and drop an app into the Applications folder
![Alt text](readme_src/installmac.png)

# DEMO

![Demo](readme_src/demo_w.webp)

## Features

- Drag and drop AppImage files for easy management.
- Automates adding executing privileges to AppImages and creating .desktop entries.
- Includes a custom parameter `remove` to easily remove the service.

## Usage

1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/AppImageDragDrop.git
    cd AppImageDragDrop
    ```
    Or download the zip file under the green code button
2. Make the AppImage script executable:


    ```bash
    chmod +x AppImageDragDrop.sh
    ```

3. Run the script with the desired options:
    ```bash
    ./AppImageDragDrop.sh
    ```
## Removal
1. Run the script with the "remove" option to remove the service:
    ```bash
    ./AppImageDragDrop.sh remove
    ```


## Script Overview

- **`AppImageDragDrop.sh`**: Handles AppImage files with drag-and-drop functionality. Use the `remove` parameter to delete AppImages.

## Requirements

- Bash shell
- inotify-tools (script will install)

## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.

## License

This project is licensed under the [GPLv2 License](LICENSE).

## Acknowledgments

Thanks to the open-source community for inspiration and support.

#!/bin/bash

prequisities() {

  # Function to install gh on Ubuntu and Debian
  install_gh_debian() {
    sudo apt-get update
    sudo apt-get install -y gh
  } 

  # Function to install gh on Fedora
  install_gh_fedora() {
      sudo dnf install -y gh
  }

  # Function to install gh on CentOS and RHEL
  install_gh_centos_rhel() {
      sudo yum install -y gh
  }

  # Function to install gh on Arch and Artix
  install_gh_arch() {
      sudo pacman -S --noconfirm gh
  }

  # Function to install gh on macOS
  install_gh_macos() {
      brew install gh
  }

  if [[ $(uname) == "Darwin" ]]; then
      if command -v brew >/dev/null 2>&1; then
          package_manager="brew"
      else
          echo "Homebrew is not installed on this macOS system"
          read -p "Would you like to install it? (y/n) " install_brew

          if [ "$install_brew" == "y" ]; then
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            echo "Homebrew is installed. Installing dependencies ..."
            install_gh_macos
          else
            echo "Error: Homebrew is required to install the GitHub command line tools."
            exit 1
          fi
      fi
  else
      # Read the contents of /etc/os-release for Linux distributions
      . /etc/os-release

      # Check the distribution and set the package manager binary accordingly
      case $ID in
          ubuntu | debian)
              package_manager="apt"
              install_gh_debian
              ;;
          arch | artix)
              package_manager="pacman"
              install_gh_arch
              ;;
          fedora)
              package_manager="dnf"
              install_gh_fedora
              ;;
          centos | rhel)
              package_manager="yum"
              install_gh_centos_rhel
              ;;
          *)
              echo "Unsupported distribution"
              exit 1
              ;;
      esac
  fi
}

clone() {
  project_name=$1

  # Clone the nursery repository into a folder with the name of the new project
  git clone https://github.com/notional-labs/nursery.git $project_name

  cd $project_name
  mv cmd/nurseryd cmd/${project_name}d

  find . -type f -print0 |
    while IFS= read -r -d $'\0' file; do
        # Check if the file contains the search word
        if grep -q "nursery" "$file"; then
            # Replace the search word with the replacement word using 'sed'
            if [[ "$package_manager" == "brew" ]]; then
                # macOS sed
                sed -i '' "s/nursery/$project_name/g" "$file"
            else
                # GNU sed (Linux)
                sed -i "s/nursery/$project_name/g" "$file"
            fi
            echo "Replaced '$search_word' with '$replacement_word' in: $file"
        fi
    done
}

prequisities

# Accept the name of a new project from the user
read -p "Enter the name of your new project (lowercase letters only): " new_project_name

# Validate that the new project name is only lowercase letters a-z
if [[ ! "$new_project_name" =~ ^[a-z]+$ ]]; then
  echo "Error: The new project name can only contain lowercase letters a-z."
  exit 1
fi

clone $new_project_name

# Check if Go 1.20 is installed, and install it using Homebrew/apt if it isn't
if ! command -v go &> /dev/null || ! go version | grep -q "go1.20"; then
  echo "Go 1.20 is not installed. Golang is required to continue."
  exit 1
fi

# Run gh repo fork --fork-name $new_project_name --remote from inside the new project's folder
gh repo fork --fork-name "$new_project_name" --remote

# Inform the user that they now only need to commit and push the code to their new repository
echo "Congratulations! Your new project '$new_project_name' has been created on GitHub."
echo "You now only need to commit and push the code to your new repository using the following commands:"
echo ""
echo "git add ."
echo "git commit -m 'Initial commit'"
echo "git push origin main"